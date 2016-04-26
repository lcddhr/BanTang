//
//  DDTimer.h
//
//  Created by lcd on 15/6/9.
//  Copyright (c) 2015年 lcd. All rights reserved.
//

#import "DDTimer.h"

@implementation DDTimer {
    dispatch_queue_t _queue;
    void (^_block)();
    
    dispatch_source_t _timer_source;
    BOOL _started;
}

- (instancetype)initWithQueue:(dispatch_queue_t)queue block:(void (^)())block {
    self = [super init];
    if (self) {
        _queue = queue;
        _block = [block copy];
        _tolerance = 0.1;
        _timer_source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _queue);
        dispatch_source_set_event_handler(_timer_source, ^{
            if (_started) {
                dispatch_suspend(_timer_source);
                _started = NO;
            }
            _block();
        });
    }
    return self;
}

- (void)startWithTimeInterval:(NSTimeInterval)timeInterval {
    dispatch_source_set_timer(_timer_source, dispatch_time(DISPATCH_TIME_NOW, timeInterval * NSEC_PER_SEC), 0, _tolerance * NSEC_PER_MSEC);
    if (!_started) {
        dispatch_resume(_timer_source);
        _started = YES;
    }
}

- (void)stop {
    if (_started) {
        dispatch_suspend(_timer_source);
        _started = NO;
    }
}

- (BOOL)isRunning
{
    return _started;
}
@end
