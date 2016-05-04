//
//  DDNetworkMonitor.h
//
//  Created by xiaomutou on 16/4/14.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DDNetworkType) {
    DDNetworkTypeNone,      //没有网络
    DDNetworkTypeWifi,      //wifi
    DDNetworkType3G,        //手机网络(3G, 4G)
    DDNetworkTypeUnknown    //未知的网络
};


typedef void(^DDNetworkMonitorBlock)(BOOL isWifi);

@interface DDNetworkMonitor : NSObject

@property (nonatomic, assign) BOOL hasReport;   //外部设置, 一天只检测一次有没有上传

@property (nonatomic, assign, readonly) BOOL isWifi;
+ (instancetype)defaultMonitor;

- (void)startMonitor:(DDNetworkMonitorBlock)monitorBlock;
- (void)stopMonitor;
@end
