//
//  APIRequestHandle.m
//  YouXiaoYun
//
//  Created by lovelydd on 15/12/9.
//  Copyright © 2015年 lovelydd. All rights reserved.
//

#import "DDNetworkDebugLog.h"
#import <AFNetworking.h>

#define DEBUG_HTTP 1

static DDNetworkDebugLog *debugNetwork = nil;
@interface DDNetworkDebugLog ()

@end

@implementation DDNetworkDebugLog


+ (void)registerNotifications {
    
    debugNetwork = [[DDNetworkDebugLog alloc] init];
#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000) || (defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED >= 1090)
    [[NSNotificationCenter defaultCenter] addObserver:debugNetwork
                                             selector:@selector(debugNetworkRequestDidStart:)
                                                 name:AFNetworkingTaskDidResumeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:debugNetwork
                                             selector:@selector(debugNetworkRequestDidFinish:)
                                                 name:AFNetworkingTaskDidCompleteNotification
                                            object:nil];
#endif
}

+ (void)closeDebug {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)debugNetworkRequestDidStart:(NSNotification *)notification {
    NSURLRequest *request = AFNetworkRequestFromNotification(notification);
    if (!request) return;
    
    NSString *body = nil;
    if ([request HTTPBody]) {
        body = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
    }
}

// finish
- (void)debugNetworkRequestDidFinish:(NSNotification *)notification {
    NSURLRequest *request = AFNetworkRequestFromNotification(notification);
    NSURLResponse *response = [notification.object response];
    NSError *error = [notification.object error];
    
    if (!request && !response) {
        return;
    }
    
    NSUInteger responseStatusCode = 0;
    NSDictionary *responseHeaderFields = nil;
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        responseStatusCode = (NSUInteger)[(NSHTTPURLResponse *)response statusCode];
        responseHeaderFields = [(NSHTTPURLResponse *)response allHeaderFields];
    }
    
    id responseObject = nil;
    if ([[notification object] respondsToSelector:@selector(responseString)]) {
//        responseObject = [[notification object] responseString];
    } else if (notification.userInfo) {
        responseObject = notification.userInfo[AFNetworkingTaskDidCompleteSerializedResponseKey];
    }
    
    
    NSString *body = nil;
    if ([request HTTPBody]) {
        body = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
    }
    
    if (error) {
        if (DEBUG_HTTP) {
        
             NSLog(@"\n---------------------------------------------------------------\n---------------------😠【 API Error 】😠---------------------\n---------------------------------------------------------------");
            NSLog(@"\n ❌：[Network Error] method: %@\n\n  request URL : '%@' \n\n  responseCode: %i \n\n : error: %@\n\n   response: %@\n" , [request HTTPMethod], [[response URL] absoluteString], (int)responseStatusCode, error, response);
        }
        
    }
    else {
        if (DEBUG_HTTP) {
            NSLog(@"🎈  -----------   【 开始调试 】 ----------- 🎈");
            
            NSLog(@"\n---------------------------------------------------------------\n---------------------😜【 API Request 】😜---------------------\n---------------------------------------------------------------");
            
            NSLog(@"\n ❤️ Request HTTP URL :  %@ \n\n ❤️ Request HTTP Method: %@ \n\n ❤️ Request HTTP Headers : %@ \n\n ❤️ Request HTTP Body : %@ \n\n ❤️ Request Token is :%@\n", [[request URL] absoluteString], [request HTTPMethod], [request allHTTPHeaderFields],body,[request valueForHTTPHeaderField:@"Authorization"]);
            
            NSLog(@"\n---------------------------------------------------------------\n--------------------😄【 API Response 】😄---------------------\n---------------------------------------------------------------");

            
            NSLog(@"\n 🚩 Respond HTTP Status Code :  %i \n\n 📌 Respond HTTP URL ：  '%@'\n\n 💌：Respond HTTP Header -----> %@ \n\n ", (int)responseStatusCode,[[response URL] absoluteString],responseHeaderFields);
        
            NSLog(@"🎈  -----------   【 结束调试 】 ----------- 🎈");
        }
    }
    
    NSDictionary *userInfo = notification.userInfo;
    
    if (userInfo[AFNetworkingTaskDidCompleteErrorKey]) {
        if ((int)responseStatusCode == 401)
        {
            NSString *message = responseObject[@"message"];
            if (
                [message isEqualToString:@"Access token is not valid"]
                || [message isEqualToString:@"Access token is missing"]
                || [message isEqualToString:@"The resource owner or authorization server denied the request."]
                )
            {
                

            }
        }
        
        if ((int)responseStatusCode == 403)
        {
            NSString *message = responseObject[@"error_message"];
            if ([message isEqualToString:@"Only access tokens representing client can use this endpoint"])
            {
                //                [[CurrentUser Instance] setupClientRequestState];
                NSLog(@"AFNetworkingTaskDidCompleteErrorKey - %@", message);
                NSLog(@"---- 403 forbidden! You are using the wrong access token!");
            }
        }
        
        NSLog(@" --->  %@", userInfo[AFNetworkingTaskDidCompleteErrorKey]);
    }
}

#pragma mark -  helper method

static NSURLRequest * AFNetworkRequestFromNotification(NSNotification *notification) {
    NSURLRequest *request = nil;
    
    if ([[notification object] isKindOfClass:[NSURLSessionTask class]]) {
        
        request = [(NSURLSessionTask *)[notification object]  currentRequest];
    } else if ([[notification object] respondsToSelector:@selector(originalRequest)]) {
        
        request = [(NSURLSessionTask *)[notification object]  originalRequest];
    }
    return request;
}



- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
