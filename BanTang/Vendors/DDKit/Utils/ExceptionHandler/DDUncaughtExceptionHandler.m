//
//  DDUncaughtExceptionHandler.m
//  DDCrashDemo
//
//  Created by xiaomutou on 16/4/18.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "DDUncaughtExceptionHandler.h"

static NSString *const kDDCrashFileName = @"MTException.txt";

NSString *applicationDocumentsDirectory() {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

NSString *exceptionTime() {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    return  [formatter stringFromDate:[NSDate date]];
}


void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr                = [exception callStackSymbols];
    NSString *reason            = [exception reason];
    NSString *name              = [exception name];
    NSDictionary *userInfo      = [exception userInfo];
    NSArray *returnAddresses    = [exception callStackReturnAddresses];
    
    NSString *content = [NSString stringWithFormat:@"=============异常崩溃信息=============\nname:\n %@\nreason:\n %@\n callStackSymbols:\n \n %@ \n userInfo:\n %@\n returnAddresses:\n %@",
                     name,reason,[arr componentsJoinedByString:@"\n"],userInfo, returnAddresses];
    NSString *fileName = [NSString stringWithFormat:@"%@-%@",exceptionTime(),kDDCrashFileName];
    NSString *path = [applicationDocumentsDirectory() stringByAppendingPathComponent:fileName];
    NSLog(@"path :%@\n",path);
    [content writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}


@implementation DDUncaughtExceptionHandler

+ (void)setDefaultHandler
{
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
}

+ (NSUncaughtExceptionHandler*)getHandler
{
    return NSGetUncaughtExceptionHandler();
}

@end
