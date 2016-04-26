//
//  GCDUtils.m
//
//  Created by lcd on 16/4/14.
//  Copyright © 2016年 lcd. All rights reserved.
//

#import "GCDUtils.h"

@implementation GCDUtils

@end


void DDAsyncRun(DDRunBlock run) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        run();
    });
}

void DDAsyncRunInMain(DDRunBlock run) {
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        run();
    });
}