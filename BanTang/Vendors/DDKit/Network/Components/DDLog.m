//
//  DDLog.m
//  BanTang
//
//  Created by lovelydd on 16/2/4.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "DDLog.h"

static BOOL ddIsDebugMode = YES;                   //标识是否是debug模式


@implementation DDLog

+ (void) log: (id)formatstring, ...
{
    //    if(isDebugMode){
    if(ddIsDebugMode){
        va_list arglist;
        va_start(arglist, formatstring);
        id statement = [[NSString alloc] initWithFormat:formatstring arguments:arglist];
        NSLog(@"%@", statement);
        va_end(arglist);
    }
}

+ (void) logDeatil: (NSString *)fileName
           lineNum: (NSNumber *)lineNum
          funcName: (NSString *)funcName
      formatstring: (id)formatstring,...
{
    if(ddIsDebugMode){
        va_list arglist;
        va_start(arglist, formatstring);
        NSString *statement = [[NSString alloc] initWithFormat:formatstring arguments:arglist];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
        NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
        NSLog(@"<< %@ %@:%d %@ >>\n%@\n",   currentDateStr, fileName, [lineNum intValue],funcName, statement);
        
        va_end(arglist);
    }
}

+ (void) setIsDebugMode: (BOOL) theIsDebugMode
{
    ddIsDebugMode = theIsDebugMode;
}

+ (BOOL) getIsDebugMode
{
    return ddIsDebugMode;
}

@end
