//
//  BTProductViewController.m
//  BanTang
//
//  Created by lovelydd on 16/2/15.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTProductViewController.h"

#import "BTProductPresent.h"
#import "UIViewController+Addition.h"


#import "BTDefaultConfig.h"

//View
#include "BTProductMenuView.h"
#import "BTProductTitleView.h"
#import "BTProductListSectionView.h"

#import "BTProductListCell.h"

@interface BTProductViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BTProductMenuView *productMenu;
@property (nonatomic, strong) BTProductPresent *productPresnet;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@end

@implementation BTProductViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self configUI];

}

- (void)configUI{
    
    [self dd_navBarColor: kBTNavBarColor];
    
    [self dd_cusomNavBarItemWithImage:@"home_search_normal"
                            highlight:@"home_search_normal"
                                title:@""
                                 type:DDNavBarItemTypeLeft
                               action:^{
                                   
                               }];

    BTProductTitleView *titleView = [BTProductTitleView createTitleViewWithSelectedBlock:^(NSInteger index) {
        DDLog(@"点击的是%ld",index);
    }];
    [self dd_setCustomTitleView:titleView];
    
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
  
    [self.listTableView registerNib:[UINib nibWithNibName:[BTProductListCell nibName] bundle:nil]
             forCellReuseIdentifier:[BTProductListCell cellIdentifier]];
    [self.listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
//    self.listTableView.tableHeaderView = headView;
//    self.listTableView.tableFooterView = [UIView new];
    
}

#pragma mark - TableViewDelegate 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (section == 0) {
        
        NSLog(@"numberOfRowsInSection 0");
        return 1;
    }
    
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        
        if (!_productMenu) {
            _productMenu =  [[BTProductMenuView alloc] initWithBarTitles:[self.productPresnet barTitles]
                                                          menuItemTitles:[self.productPresnet itemTitles]];
            cell.contentView.backgroundColor = kBTProductMenuBackgroundColor;
            [cell.contentView addSubview:_productMenu];
        }
        
        cell.backgroundColor = [UIColor redColor];
    
        return cell;
    }
    
    BTProductListCell *productCell = [tableView dequeueReusableCellWithIdentifier:[BTProductListCell cellIdentifier] forIndexPath:indexPath];
    return productCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return kBTProductMenuViewSizeHeight;
    }
    return 150;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        /*
         *  TODO: 设置成0的话会有个空白
         */
        return 0.01;
    }
    
    return 40;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        
          NSLog(@"viewForHeaderInSection section 0");
        
        return nil;
    }
    
    
    BTProductListSectionView *sectionHeadView = [BTProductListSectionView createSectionViewWithTitle:@"种草小分队"];
    
    return sectionHeadView;
}


#pragma mark - Getter and Setter
- (BTProductPresent *)productPresnet {
    
    if (!_productPresnet) {
        _productPresnet = [[BTProductPresent alloc] init];
    }
    return _productPresnet;
}


@end
