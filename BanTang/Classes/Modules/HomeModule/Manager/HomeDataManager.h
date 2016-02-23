//
//  HomeDataManager.h
//  BanTang
//
//  Created by lovelydd on 16/2/4.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//


#import "BTBaseDataManager.h"

typedef void(^HomeDataBlcok)(NSArray *bannerModels, NSArray *topicModels);

@interface HomeDataManager : BTBaseDataManager

+ (instancetype)manager;

- (void)fetchHomeData:(HomeDataBlcok)homeDataBlock;

- (void)pullUpFetchHomeDataWithPage:(NSInteger)page data:(HomeDataBlcok)homeDataBlock;
@end
