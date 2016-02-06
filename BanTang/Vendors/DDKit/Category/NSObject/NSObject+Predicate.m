//
//  NSObject+Predicate.m
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "NSObject+Predicate.h"

@implementation NSObject (Predicate)


- (BOOL)dd_isNull {

    if ([self isEqual:[NSNull null]]) return YES;
    
    if ([self isKindOfClass:[NSNull class]]) return YES;
        
    if (!self)  return YES;
    
    if ([self isKindOfClass:[NSString class]]) {
        
        if ([((NSString *)self) isEqualToString:@"(null)"])  return YES;
    }
    
    return NO;
}
@end
