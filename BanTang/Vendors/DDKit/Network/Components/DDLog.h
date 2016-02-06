//
//  DDLog.h
//  BanTang
//
//  Created by lovelydd on 16/2/4.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DDLog(format, ...) [DDLog logDeatil: \
[[NSString stringWithUTF8String: __FILE__] lastPathComponent]\
lineNum: [NSNumber numberWithInt:__LINE__] \
funcName: [NSString stringWithUTF8String: __PRETTY_FUNCTION__] \
formatstring: format, ##__VA_ARGS__ \
]

@interface DDLog : NSObject

+ (void) log: (id)formatstring,...;
+ (void) logDeatil: (NSString *)fileName
           lineNum: (NSNumber *)lineNum
          funcName: (NSString *)funcName
      formatstring: (id)formatstring,...;
+ (void) setIsDebugMode: (BOOL) theIsDebugMode;
+ (BOOL) getIsDebugMode;


@end
