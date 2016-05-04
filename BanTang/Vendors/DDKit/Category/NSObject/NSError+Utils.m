//
//  NSError+Utils.m
//
//  Created by lcd on 16/4/15.
//  Copyright © 2016年 lcd. All rights reserved.
//

#import "NSError+Utils.h"

static NSString *kDDDomain = @"com.DD";
@implementation NSError (Utils)

+ (NSError *)dd_createErrorWithMessage:(NSString *)errorMessage errorCode:(NSInteger)errorCode {
    
    return [self dd_createErrorWithDomain:kDDDomain errorMessage:errorMessage errorCode:errorCode];
}

+ (NSError *)dd_createErrorWithDomain:(NSString *)comain
                      errorMessage:(NSString *)errorMessage
                         errorCode:(NSInteger)errorCode {
    
    NSDictionary *infoDict = @{NSLocalizedDescriptionKey : errorMessage};
    NSError *error = [[NSError alloc] initWithDomain:comain
                                                code:errorCode
                                            userInfo:infoDict];
    return error;
}

@end

NSInteger kDDErrorParseCode        = -2;
NSInteger kDDErrorResponseCode     = -3;
