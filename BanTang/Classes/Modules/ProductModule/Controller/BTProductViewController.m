//
//  BTProductViewController.m
//  BanTang
//
//  Created by lovelydd on 16/2/15.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTProductViewController.h"
#import "UIViewController+Addition.h"

#import "UIConfig.h"
#include "BTProductMenuView.h"

#import "BTProductPresent.h"
#import "BTProductMenuItemCell.h"

@interface BTProductViewController ()
@property (nonatomic, strong) BTProductPresent *productPresnet;
@end

@implementation BTProductViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.productPresnet = [[BTProductPresent alloc] init];
    
    [self dd_cusomNavBarItemWithImage:@"home_search_normal"
                            highlight:@"home_search_normal"
                                title:@""
                                 type:DDNavBarItemTypeLeft
                               action:^{
                                   
                               }];
    [self dd_navBarColor: kBTNavBarColor];
    
   BTProductMenuView *menuView =  [[BTProductMenuView alloc] initWithBarTitles:[self.productPresnet barTitles]
                                                                menuItemTitles:[self.productPresnet itemTitles]];
    [self.view addSubview:menuView];
    
}



@end
