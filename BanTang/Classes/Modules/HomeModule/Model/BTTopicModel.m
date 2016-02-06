//
//  BTTopicModel.m
//  BanTang
//
//  Created by lovelydd on 16/2/4.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTTopicModel.h"

@implementation BTTopicModel


+(NSDictionary *)attributeMapDictionary {
    
    return @{
             @"updateTime" : @"update_time",
             @"topicId": @"id",
             };
}
@end
