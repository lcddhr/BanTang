//
//  DDUncaughtExceptionHandler.h
//  DDCrashDemo
//
//  Created by xiaomutou on 16/4/18.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDUncaughtExceptionHandler : NSObject

+ (void)setDefaultHandler;

+ (NSUncaughtExceptionHandler*)getHandler;
@end
