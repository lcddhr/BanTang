//
//  BTTopicModel.h
//  BanTang
//
//  Created by lovelydd on 16/2/4.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//


#import "BTBaseModel.h"

@interface BTTopicModel : BTBaseModel

@property (nonatomic, copy) NSString *topicId;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSNumber *isLike;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;



@end
