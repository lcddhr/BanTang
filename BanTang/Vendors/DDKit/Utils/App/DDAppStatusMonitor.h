//
//  DDAppStatusMonitor.h
//
//  Created by lcd on 16/4/21.
//  Copyright © 2016年 lcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDAppStatusMonitor : NSObject

+ (instancetype)defaultMonitor;

- (void)start;
- (void)removeMonitor;
@end
