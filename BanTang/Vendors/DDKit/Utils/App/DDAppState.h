//
//  MTAppState.h
//  Makeup
//
//  Created by lcd on 15/3/25.
//  Copyright (c) 2015年 xiaomutou Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DDApplicationLaunchNormal,
    DDApplicationLaunchPush,
} DDApplicationLaunchType;

@class DDAppState;
@protocol DDAppStateTarget <NSObject>
- (void)appStateDidChange:(DDAppState *)appState;
@end


@interface DDAppState : NSObject

@property (nonatomic, readonly, assign) UIApplicationState applicationState;
@property (nonatomic, assign) DDApplicationLaunchType launchType;
+ (instancetype)sharedAppState;
- (void)addTarget:(id<DDAppStateTarget>)target;
- (void)removeTarget:(id<DDAppStateTarget>)target;
- (void)addCallbackBlock:(void (^)(UIApplicationState))callback;
- (void)removeCallbackBlock:(id)callback;
@end
