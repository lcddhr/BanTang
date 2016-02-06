//
//  BTBannerModel.h
//  BanTang
//
//  Created by lovelydd on 16/2/4.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//


#import "BTBaseModel.h"

@interface BTBannerModel : BTBaseModel

@property (nonatomic, copy)NSString *bannerId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *extend;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSNumber *index;


@end
