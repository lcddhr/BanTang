//
//  DDAppStatusMonitor.m
//
//  Created by lcd on 16/4/21.
//  Copyright © 2016年 lcd. All rights reserved.
//

#import "DDAppStatusMonitor.h"
#import <UIKit/UIKit.h>

@interface DDAppStatusMonitor ()

@end

@implementation DDAppStatusMonitor

+ (instancetype)defaultMonitor {
    
    static DDAppStatusMonitor *mtAPPStatusMonitor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mtAPPStatusMonitor = [[DDAppStatusMonitor alloc] init];
    });
    return mtAPPStatusMonitor;
}

-(instancetype)init {
    
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void)start {
    
    //进入前台通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterForegroundNotification:) name:UIApplicationDidFinishLaunchingNotification object:nil];
}

#pragma mark - Notification Event
- (void)didEnterForegroundNotification:(NSNotification *)notification {
    
    NSLog(@"进入前台了");
    
}

- (void)removeMonitor {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
