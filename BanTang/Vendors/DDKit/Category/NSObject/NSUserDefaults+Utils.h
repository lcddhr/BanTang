//
//  NSUserDefaults+MTUserOperation.h
//
//  Created by lcd on 16/4/21.
//  Copyright © 2016年 lcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (DDUtils)

+ (instancetype)sharedInstance;

//第一天第一次打开APP
- (BOOL)firstOpenAppInDay;

@end
