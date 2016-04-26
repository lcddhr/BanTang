//
//  DDNetworkMonitor.m
//  DDDemo
//
//  Created by meitu on 16/4/14.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "DDNetworkMonitor.h"
#import "DDReachability.h"

@interface DDNetworkMonitor ()

@property (nonatomic, strong) DDReachability *reachability;

@property (nonatomic, copy) DDNetworkMonitorBlock networkMonitorBlock;

@property (nonatomic, assign, readwrite) BOOL isWifi;
@end

@implementation DDNetworkMonitor


+ (instancetype)defaultMonitor {
    
    static DDNetworkMonitor *ddNetworkMonitor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ddNetworkMonitor = [[DDNetworkMonitor alloc] init];
    });
    return ddNetworkMonitor;
}

- (void)startMonitor:(DDNetworkMonitorBlock)monitorBlock {
    
    _networkMonitorBlock = monitorBlock;
    
    [self startNetworkMonitor];
}

- (void)stopMonitor {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)init {
    
    self = [super init];
    if (self) {
    
    }
    return self;
}

- (void)startNetworkMonitor {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChangeNotification:) name:kDDReachabilityChangedNotification object:nil];
    
    self.reachability = [DDReachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    
    self.isWifi = [self isWifi];
}

#pragma mark - Event
- (void)networkChangeNotification:(NSNotification *)notificaton {
    
    if (self.hasReport) {   //如果这次开机已经上报,就不做任何处理了
        
        return;
    }
    
    self.isWifi = [self isWifi];
    
    if (self.isWifi) {
        
        //上报数据
        _networkMonitorBlock(YES);
    } else {
        
        //3G或者4G或者没有网络的话就只保存数据
        _networkMonitorBlock(NO);
    }
}

- (BOOL)isWifi {
    
    return ([self networkType] == DDNetworkTypeWifi) ? YES : NO;
}

- (DDNetworkType)networkType {
    
    DDReachability *reachability = [DDReachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    DDNetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == DDNotReachable){
        //No internet
        return DDNetworkTypeNone;
    }
    else if (status == DDReachableViaWiFi) {
        //WiFi
        return DDNetworkTypeWifi;
    }
    else if (status == DDReachableViaWWAN)
    {
        //3G
        return DDNetworkType3G;
    }
    return DDNetworkTypeUnknown;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
