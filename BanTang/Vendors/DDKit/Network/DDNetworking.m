//
//  DDNetworking.m
//  BanTang
//
//  Created by lovelydd on 16/2/4.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "DDNetworking.h"
#import "DDLog.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFHTTPSessionManager.h"
#import "EXTScope.h"
#import "DDNetworkDebugLog.h"


typedef NS_ENUM(NSUInteger,DDRequestMethod) {
    DDRequestMethodGet,
    DDRequestMethodPost,
};



static NSString *kDDBaseUrl = nil;
static BOOL kDDDebugModel = nil;
static NSDictionary *kDDHeaderDic = nil;

@implementation DDNetworking

#pragma mark - Config
+ (void)configBaseUrl:(NSString *)url {
    
    kDDBaseUrl = url;
}

+ (void)enableDebugLog:(BOOL)isDebug {
    
    kDDDebugModel = isDebug;
    [DDLog setIsDebugMode:isDebug];
    
    if (isDebug) {
        
        [DDNetworkDebugLog registerNotifications];
        
    } else {
        
        [DDNetworkDebugLog closeDebug];
    }

}

+ (void)configHeader:(NSDictionary *)heder {
    kDDHeaderDic = heder;
}


+ (BOOL)canConnectToNetwork {
    
    struct sockaddr zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sa_len = sizeof(zeroAddress);
    zeroAddress.sa_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

#pragma mark - Request
+ (NSURLSessionTask *)get:(NSString *)url success:(DDResponseSuccess)success fail:(DDResponseFail)fail {
    
    return [self get:url params:nil success:success fail:fail];
}

+ (NSURLSessionTask *)get:(NSString *)url params:(NSDictionary *)params success:(DDResponseSuccess)success fail:(DDResponseFail)fail {
    
    
    return [self get:url params:params progress:nil success:success fail:fail];
}

+ (NSURLSessionTask *)get:(NSString *)url params:(NSDictionary *)params progress:(DDDownloadProgress)progress success:(DDResponseSuccess)success fail:(DDResponseFail)fail {
    
    return [self _ddRequestWithUrl:url method:DDRequestMethodGet params:params progress:progress success:success fail:fail];
}

+ (NSURLSessionTask *)post:(NSString *)url params:(NSDictionary *)params success:(DDResponseSuccess)success fail:(DDResponseFail)fail {
    
    return [self post:url params:params progress:nil success:success fail:fail];
}

+ (NSURLSessionTask *)post:(NSString *)url params:(NSDictionary *)params progress:(DDDownloadProgress)progress success:(DDResponseSuccess)success fail:(DDResponseFail)fail {

    return [self _ddRequestWithUrl:url method:DDRequestMethodPost params:params progress:progress success:success fail:fail];
}

+ (NSURLSessionTask *)_ddRequestWithUrl:(NSString*)url method:(DDRequestMethod)method params:(NSDictionary*)params progress:(DDDownloadProgress)progress success:(DDResponseSuccess)success fail:(DDResponseFail)fail {
    
    AFHTTPSessionManager *manager = [self manager];
    
    if (!kDDBaseUrl) {
        DDLog(@"BaseURL不存在!");
        return nil;
    }
    
    NSString *requestURL = [self requestURL:url];
    
    if (!requestURL) {
        return nil;
    }
    
    NSURLSessionTask *session = nil;
    
    @weakify(self);
    
    if (method == DDRequestMethodGet) {
        
        
        session = [manager GET:requestURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
            if (progress) {
                progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            @strongify(self);
            
            if ([DDLog getIsDebugMode]) {
                
                [self printSuccessLog:responseObject url:task.response.URL.absoluteString params:params];
            }
            
            [self successResponse:responseObject callBack:success];
            
            
           
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
           
            @strongify(self);
            if ([DDLog getIsDebugMode]) {
                
                [self printErrorLog:error url:task.response.URL.absoluteString params:params];
            }
            
            if (fail) {
                fail(error);
            }
            
            
        }];
        
    } else if (method == DDRequestMethodPost) {
        
        
        session = [manager POST:requestURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
            if (progress) {
                
                progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            @strongify(self);
            
            if ([DDLog getIsDebugMode]) {
                
                [self printSuccessLog:responseObject url:task.response.URL.absoluteString params:params];
            }
            
            
            [self successResponse:responseObject callBack:success];
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            @strongify(self);
            
            if ([DDLog getIsDebugMode]) {
                
                [self printErrorLog:error url:task.response.URL.absoluteString params:params];
            }
            
            if (fail) {
                fail(error);
            }
            
        }];
        
    
        
    }
    return session;
}

+ (void)successResponse:(id)responseObject callBack:(DDResponseSuccess)success {

    if (success) {
        success([self parseData:responseObject]);
        
    }
}

+ (id)parseData:(id)responseObject {
    
    if ([responseObject isKindOfClass:[NSData class]]) {
        
        if (!responseObject) {
            return responseObject;
        }
        
        NSError *error = nil;
        NSDictionary *reponseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        
        if (!error) {
            return reponseDic;
        }
        
        return responseObject;
    }
    return responseObject;
}

+ (void)printSuccessLog:(id)responseObject url:(NSString *)url params:(NSDictionary *)params {
    
    DDLog(@"\n <-------------  url:%@  \n params:%@  \n responseObject:%@  \n ------>\n",[self generateGETAbsoluteURL:url params:params],params,[self parseData:responseObject]);
}

+ (void)printErrorLog:(NSError *)error url:(NSString *)url params:(NSDictionary *)params {

    DDLog(@"\n <-------------  url:%@  \n params:%@  \n error:%@  \n ------>\n",[self generateGETAbsoluteURL:url params:params], params, [error localizedDescription]);

}


#pragma mark - Private 
+ (AFHTTPSessionManager *)manager {
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = nil;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    if (!kDDBaseUrl) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kDDBaseUrl]];
    } else {
        
        manager = [AFHTTPSessionManager manager];
    }

    if (kDDHeaderDic) {
        
        [kDDHeaderDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            [manager.requestSerializer setValue:obj forKey:key];
        }];
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 4;
    return manager;
}

+ (NSString *)requestURL:(NSString *)url {
    
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kDDBaseUrl,url]];
    if (!requestURL) {
        
        url = [self _ddURLEncode:url];
        requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kDDBaseUrl,url]];
        
        if (!requestURL) {
            
            DDLog(@"url:%@  ------> 生成不了requestURL,请检查url是否正确",url);
            return nil;
        }
    }
    return [NSString stringWithFormat:@"%@%@",kDDBaseUrl,url];
    
}

+ (NSString *)_ddURLEncode:(NSString *)url {
    NSString *newString =
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)url,
                                                              NULL,
                                                              CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    
    return url;
}

+ (NSString *)generateGETAbsoluteURL:(NSString *)url params:(NSDictionary *)params {
    if (params.count == 0) {
        return url;
    }
    
    NSString *queries = @"";
    for (NSString *key in params) {
        id value = [params objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            continue;
        } else if ([value isKindOfClass:[NSArray class]]) {
            continue;
        } else if ([value isKindOfClass:[NSSet class]]) {
            continue;
        } else {
            queries = [NSString stringWithFormat:@"%@%@=%@&",
                       (queries.length == 0 ? @"&" : queries),
                       key,
                       value];
        }
    }
    
    if (queries.length > 1) {
        queries = [queries substringToIndex:queries.length - 1];
    }
    
    if (([url rangeOfString:@"http://"].location != NSNotFound
         || [url rangeOfString:@"https://"].location != NSNotFound)
        && queries.length > 1) {
        if ([url rangeOfString:@"?"].location != NSNotFound
            || [url rangeOfString:@"#"].location != NSNotFound) {
            url = [NSString stringWithFormat:@"%@%@", url, queries];
        } else {
            queries = [queries substringFromIndex:1];
            url = [NSString stringWithFormat:@"%@?%@", url, queries];
        }
    }
    
    return url.length == 0 ? queries : url;
}


@end
