//
//  DDTimer.h
//
//  Created by lcd on 15/6/9.
//  Copyright (c) 2015年 lcd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDTimer : NSObject

- (instancetype)initWithQueue:(dispatch_queue_t)queue block:(void (^)())block;

@property (assign, nonatomic) NSTimeInterval tolerance;

- (void)startWithTimeInterval:(NSTimeInterval)timeInterval;
- (void)stop;

- (BOOL)isRunning;
@end

NS_ASSUME_NONNULL_END
