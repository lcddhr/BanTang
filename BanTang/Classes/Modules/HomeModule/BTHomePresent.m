//
//  BTHomePresent.m
//  BanTang
//
//  Created by lovelydd on 16/2/5.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTHomePresent.h"
#import "BTBannerModel.h"

@implementation BTHomePresent


- (NSArray *)filterBannerUrls:(NSArray *)banners {
    
    NSMutableArray *imageUrls = [NSMutableArray array];
    
    [banners enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BTBannerModel *bannerModel = (BTBannerModel *)obj;
        [imageUrls addObject:bannerModel.photo];
    }];
    
    return imageUrls;
}

- (NSArray *)filterMenuItems {
    
    return @[@"最新",@"一周最热",@"文艺",@"礼物"];
}
@end
