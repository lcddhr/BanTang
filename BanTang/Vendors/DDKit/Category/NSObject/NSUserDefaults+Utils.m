//
//  NSUserDefaults+MTUserOperation.m
//
//  Created by lcd on 16/4/21.
//  Copyright © 2016年 lcd. All rights reserved.
//

#import "NSUserDefaults+Utils.h"

static NSUserDefaults *_userOperationDefaults = nil;

static NSString *kFirstOpenAppTimeKey       = @"firstOpenAppTimeKey";
static NSString *kLastOpenAppTimeKey        = @"lastOpenAppTime";

static NSTimeInterval kMaxTimeInterval      = 60 * 60 * 24;

@implementation NSUserDefaults (DDUtils)

+ (instancetype)sharedInstance {

    if (!_userOperationDefaults) {
        
        _userOperationDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"DDUserDefaults"];
    }
    return _userOperationDefaults;
}

- (BOOL)firstOpenAppInDay {
    
    NSTimeInterval lastOpenAppTime = [[[NSUserDefaults sharedInstance] objectForKey:kLastOpenAppTimeKey] doubleValue];
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    
    //不存在的话说明是第一次打开
    if (!lastOpenAppTime) {
        [[NSUserDefaults sharedInstance] setObject:@(currentTime) forKey:kLastOpenAppTimeKey];
        [[NSUserDefaults sharedInstance] synchronize];
        return NO;
    }
    //判断时间差是否超过一天。
    if (currentTime - lastOpenAppTime > kMaxTimeInterval) {
        
        [[NSUserDefaults sharedInstance] setObject:@(currentTime) forKey:kLastOpenAppTimeKey];
        [[NSUserDefaults sharedInstance] synchronize];
        return YES;
    }
    
    return NO;
}
@end
