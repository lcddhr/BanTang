//
//  MTAppState.m
//  Makeup
//
//  Created by lcd on 15/3/25.
//  Copyright (c) 2015年 Meitu Inc. All rights reserved.
//

#import "DDAppState.h"

#import "ReactiveCocoa.h"

@interface DDAppState ()
@property (nonatomic, readwrite, assign) UIApplicationState applicationState;
@property (nonatomic, strong) NSMutableArray *targets;
@property (nonatomic, strong) NSMutableArray *callbacks;
@end

@implementation DDAppState

+ (instancetype)sharedAppState
{
    static dispatch_once_t onceToken;
    static id object;
    dispatch_once(&onceToken, ^{
        object = [[self alloc] init];
    });
    return object;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _launchType = DDApplicationLaunchNormal;
        _applicationState = [UIApplication sharedApplication].applicationState;
        _targets = [NSMutableArray array];
        _callbacks = [NSMutableArray array];
        
        
        RACSignal *becomeActiveSignal =  [[NSNotificationCenter defaultCenter]
                                           rac_addObserverForName:UIApplicationDidBecomeActiveNotification
                                           object:nil];
        
        RACSignal *resignActiveSignal = [[NSNotificationCenter defaultCenter]
                                          rac_addObserverForName:UIApplicationWillResignActiveNotification
                                          object:nil];
        RACSignal *backgroundSignal = [[NSNotificationCenter defaultCenter]
                                       rac_addObserverForName:UIApplicationDidEnterBackgroundNotification
                                       object:nil];
        
        RACSignal *foregroundSignal = [[NSNotificationCenter defaultCenter]
                                       rac_addObserverForName:UIApplicationWillEnterForegroundNotification
                                       object:nil];
        
        RACSignal *activeSignal = [becomeActiveSignal merge:resignActiveSignal];
        RACSignal *enterSignal = [backgroundSignal merge:foregroundSignal];
        
        RACSignal *sinal = [activeSignal merge:enterSignal];
        
        RAC(self,applicationState) = [[sinal takeUntil:self.rac_willDeallocSignal] map:^id(id value) {
            return @([UIApplication sharedApplication].applicationState);
        }];
        
        __weak typeof(self) weakSelf = self;
        [[sinal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            for (NSValue *value in strongSelf.targets) {
                [value.nonretainedObjectValue appStateDidChange:strongSelf];
            }
            
            for (void (^Callback)(UIApplicationState) in self.callbacks) {
                Callback(self.applicationState);
            }
        }];
    }
    return self;
}

- (void)addCallbackBlock:(void (^)(UIApplicationState))callback
{
    [_callbacks addObject:callback];
}

- (void)removeCallbackBlock:(id)callback
{
    [_callbacks removeObject:callback];
}

- (void)addTarget:(id<DDAppStateTarget>)target
{
    if (![self.targets containsObject:target]) {
        [self.targets addObject:[NSValue valueWithNonretainedObject:target]];
    }
}

- (void)removeTarget:(id<DDAppStateTarget>)target
{
    for (NSValue *value in self.targets) {
        if (value.nonretainedObjectValue == target) {
            [self.targets removeObject:value];
            break;
        }
    }
}

@end
