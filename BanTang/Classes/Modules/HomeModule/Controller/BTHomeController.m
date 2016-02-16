//
//  BTHomeController.m
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTHomeController.h"
#import "BTDefaultConfig.h"
#import "UIViewController+Addition.h"

//Model
#import "BTBannerModel.h"
#import "BTTopicModel.h"

//View
#import "DDCircleView.h"
#import "BTHomeHeadView.h"

//Controlller
#import "BTListViewController.h"
#import "BTTableViewController.h"

//Data
#import "HomeDataManager.h"

//Present
#import "BTHomePresent.h"

@interface BTHomeController()<BTPageMenuControllerDelegate>

@property (nonatomic, strong) NSArray *lists;
@property (nonatomic, assign) NSInteger currentListIndex;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL isFinish;
@property (nonatomic, strong) BTHomePresent *homePresent;

@end

@implementation BTHomeController


#pragma mark - LifeCycle
-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self dd_cusomNavBarItemWithImage:@"home_search_normal"
                            highlight:@"home_search_normal"
                                title:@""
                                 type:DDNavBarItemTypeLeft
                               action:^{
        
    }];
    
    [self dd_setCustomTitleViewWithTitle:@"半糖"];
    
    _currentListIndex = 0; //默认加载第一个
    _currentPage = 0;
    _isFinish = YES;
    
    [self loadHomeData];
}

#pragma mark - Private
- (void)configBanner:(NSArray *)banners {
    
    NSArray *imageUrls  = [self.homePresent filterBannerUrls:banners];
    NSArray *items      = [self.homePresent filterMenuItems];
    
    BTHomeHeadView *headView    = [[BTHomeHeadView alloc] initWithUrls:imageUrls];
    self.titles                 = items;
    self.headView               = headView;
    self.parallaxHeaderEffect   = NO;
    self.showTitleLabel         = NO;
    self.delegate               = self;
    self.controllers            = self.childViewControllers;
    
    [self reloadData];
}

- (void)configList:(NSArray *)topics {
    
    BTListViewController *listTableVC = [[BTListViewController alloc] initWithListData:@[]];
    [self addChildViewController:listTableVC];
}

#pragma mark - Request

- (void)loadHomeData {
    
    [[HomeDataManager manager] fetchHomeData:^(NSArray *bannerModels, NSArray *topicModels) {
        
//        NSLog(@"bannerModels %@",bannerModels);
        _lists = topicModels;
        [self configList:topicModels];
        [self configList:topicModels];
        [self configList:topicModels];
        
        [self configBanner:bannerModels];
        
        BTListViewController *listvc = self.controllers[0];
        [listvc reloadWithListData:topicModels];
    }];
}

- (void)pullUpLoadData {
    
    //防止重复请求
    if (!_isFinish) {
        return;
    }
     _currentPage++;
    [[HomeDataManager manager] pullUpFetchHomeDataWithPage:_currentPage data:^(NSArray *bannerModels, NSArray *topicModels) {
       
        _isFinish = YES;
        
        [[_lists mutableCopy] addObject:topicModels];
        
        BTListViewController *listvc = self.controllers[0];
        [listvc reloadWithListData:_lists];
    }];
}



#pragma mark - BTPageMenuControllerDelegate
-(void)pageMenuController:(BTPageMenuController *)pageMenuController selectedAtIndex:(NSInteger)index {
    
    if (index == _currentListIndex) {
        
        return;
    }
    _currentListIndex = index;
    BTListViewController *listvc = self.controllers[index];
    [listvc reloadWithListData:_lists];
}

#pragma mark - Getter and Setter
-(BTHomePresent *)homePresent {
    
    if (!_homePresent) {
        _homePresent = [[BTHomePresent alloc] init];
    }
    return _homePresent;
}
@end
