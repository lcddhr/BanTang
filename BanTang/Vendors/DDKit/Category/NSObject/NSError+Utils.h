//
//  NSError+Utils.h
//
//  Created by lcd on 16/4/15.
//  Copyright © 2016年 lcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Utils)

+ (NSError *)dd_createErrorWithMessage:(NSString *)errorMessage
                             errorCode:(NSInteger)errorCode;

+ (NSError *)dd_createErrorWithDomain:(NSString *)comain
                         errorMessage:(NSString *)errorMessage
                            errorCode:(NSInteger)errorCode;
@end


FOUNDATION_EXTERN NSInteger kDDErrorParseCode;     //无法解析返回的数据
FOUNDATION_EXTERN NSInteger kDDErrorResponseCode;  //无法正常响应