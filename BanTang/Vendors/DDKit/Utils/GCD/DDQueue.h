//
//  DDQueue.h
//  Makeup
//
//  Created by lcd on 15/3/31.
//  Copyright (c) 2015年 xiaomutou Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDQueue : NSObject
{
    dispatch_queue_t _contextQueue;
    NSMutableArray *_tempQueue;
}
- (void)addSyncBlock:(dispatch_block_t)block;
- (void)addAsyncBlock:(dispatch_block_t)block;
@end
