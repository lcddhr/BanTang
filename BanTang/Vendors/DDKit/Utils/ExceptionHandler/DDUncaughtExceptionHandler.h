//
//  MTUncaughtExceptionHandler.h
//  MTCrashDemo
//
//  Created by meitu on 16/4/18.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDUncaughtExceptionHandler : NSObject

+ (void)setDefaultHandler;

+ (NSUncaughtExceptionHandler*)getHandler;
@end
