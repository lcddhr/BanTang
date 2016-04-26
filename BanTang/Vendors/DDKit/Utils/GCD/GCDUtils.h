//
//  GCDUtils.h
//
//  Created by lcd on 16/4/14.
//  Copyright © 2016年 lcd. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^DDRunBlock)(void);

void DDAsyncRun(DDRunBlock run);

void DDAsyncRunInMain(DDRunBlock run);

@interface GCDUtils : NSObject

@end

