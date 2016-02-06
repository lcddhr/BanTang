//
//  HomeDataManager.m
//  BanTang
//
//  Created by lovelydd on 16/2/4.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "HomeDataManager.h"
#import "DDNetworking.h"
#import "BTBannerModel.h"
#import "BTTopicModel.h"
#import "DDExtendModel.h"



@implementation HomeDataManager

+ (instancetype)manager {
    
    static HomeDataManager *homeDataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        homeDataManager = [[HomeDataManager alloc] init];
    });
    return homeDataManager;
}

-(instancetype)init {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)fetchHomeData:(HomeDataBlcok)homeDataBlock {

   
    
    [self _requestHomeDataWithPage:0 data:homeDataBlock];
    
}

- (void)pullUpFetchHomeDataWithPage:(NSInteger)page data:(HomeDataBlcok)homeDataBlock {
    
    [self _requestHomeDataWithPage:page data:homeDataBlock];
}

- (void)_requestHomeDataWithPage:(NSInteger)page data:(HomeDataBlcok)homeDataBlock {
    
    BOOL canConnect = [DDNetworking canConnectToNetwork];
    
    if (!canConnect) {
        
        return;
    }
    
    [DDNetworking get:kBTHomeURL params:[self addParameters:@{@"page" :@(page), @"pagesize":@"20"}] success:^(id response) {
        
        NSMutableArray *banners = [DDExtendModel modelMultiTransformationWithResponseObj:response[@"data"][@"banner"] modelClass:[BTBannerModel class] replaceProperty:[BTBannerModel attributeMapDictionary]];
        
        NSMutableArray *topics = [DDExtendModel modelMultiTransformationWithResponseObj:response[@"data"][@"topic"] modelClass:[BTTopicModel class] replaceProperty:[BTTopicModel attributeMapDictionary]];
        
        if (homeDataBlock) {
            
            homeDataBlock(banners, topics);
        }
        
        
    } fail:^(NSError *error) {
        
        NSLog(@"%@",[error description]);
    }];
    
}

@end
