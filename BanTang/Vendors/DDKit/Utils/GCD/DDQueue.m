//
//  DDQueue.m
//  Makeup
//
//  Created by lcd on 15/3/31.
//  Copyright (c) 2015年 xiaomutou Inc. All rights reserved.
//

#import "DDQueue.h"
#import "DDAppState.h"

static void *kDDQueueKey;

@interface DDQueueTask : NSObject
@property (nonatomic, strong) dispatch_block_t block;
@property (nonatomic, assign) BOOL isAsync;
@end

@implementation DDQueueTask

@end

@implementation DDQueue

- (void)dealloc
{
    [[DDAppState sharedAppState] removeTarget:(id<DDAppStateTarget>)self];
}

- (instancetype)init
{
    self = [super init];
    if(self){
        _contextQueue = dispatch_queue_create("DDQueue", DISPATCH_QUEUE_SERIAL);
        dispatch_queue_set_specific(_contextQueue, kDDQueueKey, (__bridge void *)self, NULL);
        [[DDAppState sharedAppState] addTarget:(id<DDAppStateTarget>)self];
        _tempQueue = [NSMutableArray array];
    }
    return self;
}

- (void)addSyncBlock:(dispatch_block_t)block
{
    switch([DDAppState sharedAppState].applicationState){
        case UIApplicationStateActive:
        {
            [self runSyncProcessingQueue:block];
            break;
        }
        case UIApplicationStateBackground:
        case UIApplicationStateInactive:
        {
            DDQueueTask *task = [[DDQueueTask alloc] init];
            task.block = block;
            task.isAsync = NO;
            [_tempQueue addObject:task];
            break;
        }
        default:
            break;
    }
}

- (void)addAsyncBlock:(dispatch_block_t)block
{
    switch([DDAppState sharedAppState].applicationState){
        case UIApplicationStateActive:
        {
            [self runAsyncProcessingQueue:block];
            break;
        }
        case UIApplicationStateBackground:
        case UIApplicationStateInactive:
        {
            
            DDQueueTask *task = [[DDQueueTask alloc] init];
            task.block = block;
            task.isAsync = YES;
            [_tempQueue addObject:task];
            break;
        }
        default:
            break;
    }
}

- (void)appStateDidChange:(DDAppState *)appState
{
    switch(appState.applicationState)
    {
        case UIApplicationStateActive:
        {
            
            // 有未执行的任务
            if(_tempQueue.count > 0){
            
                for(NSUInteger i = 0; i < _tempQueue.count; i++){
                    DDQueueTask *task = _tempQueue[i];
                    if(task.isAsync){
                        [self runAsyncProcessingQueue:task.block];
                    }else{
                        [self runSyncProcessingQueue:task.block];
                    }
                }
                
                [_tempQueue removeAllObjects];
            }
            
           break;
        }
        default:
            break;
    }
}

- (void)runSyncProcessingQueue:(void (^)(void))block
{
    if (dispatch_get_specific(kDDQueueKey))
    {
        block();
    }
    else
    {
        dispatch_sync(_contextQueue, block);
    }
}
- (void)runAsyncProcessingQueue:(void (^)(void))block
{
    if (dispatch_get_specific(kDDQueueKey))
    {
        block();
    }
    else
    {
        dispatch_async(_contextQueue, block);
    }
}

@end