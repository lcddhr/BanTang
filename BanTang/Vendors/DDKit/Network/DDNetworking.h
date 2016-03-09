//
//  DDNetworking.h
//  BanTang
//
//  Created by lovelydd on 16/2/4.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLConfig.h"

typedef NS_ENUM(NSUInteger, DDNetworkingErrorType) {
    DDNetworkingErrorTypeNormal,
    DDNetworkingErrorTypeNotNetwork,
    DDNetworkingErrorTypeRequestFail,
    DDNetworkingErrorTypeRequestTimeOut,
};

typedef void (^DDDownloadProgress)(int64_t bytesRead,
                                    int64_t totalBytesRead);

typedef void(^DDResponseSuccess)(id response);
typedef void(^DDResponseFail)(NSError *error);


@interface DDNetworking : NSObject

+ (void)configBaseUrl:(NSString *)url;

+ (void)enableDebugLog:(BOOL)isDebug;

+ (void)configHeader:(NSDictionary *)heder;

+ (BOOL)canConnectToNetwork;

+ (NSURLSessionTask *)get:(NSString *)url
    success:(DDResponseSuccess)success
       fail:(DDResponseFail)fail;

+ (NSURLSessionTask *)get:(NSString *)url
     params:(NSDictionary *)params
    success:(DDResponseSuccess)success
       fail:(DDResponseFail)fail;

+ (NSURLSessionTask *)get:(NSString *)url params:(NSDictionary *)params progress:(DDDownloadProgress)progress success:(DDResponseSuccess)success fail:(DDResponseFail)fail;

+ (NSURLSessionTask *)post:(NSString *)url params:(NSDictionary *)params success:(DDResponseSuccess)success fail:(DDResponseFail)fail;

+ (NSURLSessionTask *)post:(NSString *)url params:(NSDictionary *)params progress:(DDDownloadProgress)progress success:(DDResponseSuccess)success fail:(DDResponseFail)fail;
@end
