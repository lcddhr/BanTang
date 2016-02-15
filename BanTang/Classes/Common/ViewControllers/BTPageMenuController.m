//
//  BTPageMenuController.m
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTPageMenuController.h"
#import "TYSlidePageScrollView.h"
#import "TYTitlePageTabBar.h"
#import "UINavigationBar+Awesome.h"
#import "BTTableViewController.h"
#import "UIConfig.h"
#import "UIViewController+Addition.h"

@interface BTPageMenuController () <TYSlidePageScrollViewDataSource, TYSlidePageScrollViewDelegate>


@property (nonatomic, weak, readwrite) TYSlidePageScrollView *slidePageScrollView;
@end

@implementation BTPageMenuController


#pragma mark - Life Cycle 

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _titles = [NSArray array];
        _controllers = [NSArray array];
    }
    return self;
}


-(void)viewDidLoad {
    
    [super viewDidLoad];
    _parallaxHeaderEffect = NO;
}



#pragma mark - Public  Method
- (void)reloadData {
    
    if (!self.slidePageScrollView) {
        
        [self configUI];
    }
    
    [self.slidePageScrollView reloadData];
}


#pragma makr - Private Method
- (void)configUI {
    
    TYSlidePageScrollView *slidePageScrollView = [[TYSlidePageScrollView alloc]initWithFrame:self.view.bounds];
    slidePageScrollView.pageTabBarIsStopOnTop = YES;
    slidePageScrollView.pageTabBarStopOnTopHeight = kBTNavBarHeight;
    slidePageScrollView.parallaxHeaderEffect = _parallaxHeaderEffect;
    slidePageScrollView.dataSource = self;
    slidePageScrollView.delegate = self;
    slidePageScrollView.backgroundColor = [UIColor redColor];
    _slidePageScrollView = slidePageScrollView;
    [self.view addSubview:_slidePageScrollView];
    
    TYTitlePageTabBar *titlePageTabBar = [[TYTitlePageTabBar alloc]initWithTitleArray:_titles];
    titlePageTabBar.frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), 40);
    titlePageTabBar.backgroundColor = [UIColor whiteColor];
    titlePageTabBar.horIndicatorColor = kBTNavBarColor;
    titlePageTabBar.titleSpacing = 5;
    titlePageTabBar.textColor = [UIColor lightGrayColor];
    titlePageTabBar.horIndicatorSpacing = 30.0f;
    titlePageTabBar.selectedTextColor = kBTNavBarColor;
    self.slidePageScrollView.pageTabBar = titlePageTabBar;

    if (_headView) {
          self.slidePageScrollView.headerView = _headView;
    }
}

#pragma mark - datasource
- (NSInteger)numberOfPageViewOnSlidePageScrollView
{
    return self.controllers.count;
}

- (UIScrollView *)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index
{
    UITableViewController *tableViewVC = self.controllers[index];
    return tableViewVC.tableView;
}

#pragma mark - delegate

- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView verticalScrollViewDidScroll:(UIScrollView *)pageScrollView
{
    UIColor * color = kBTNavBarColor;
    
    CGFloat headerContentViewHeight = -(CGRectGetHeight(slidePageScrollView.headerView.frame)+CGRectGetHeight(slidePageScrollView.pageTabBar.frame));
    // 获取当前偏移量
    CGFloat offsetY = pageScrollView.contentOffset.y;
    
    // 获取偏移量差值
    CGFloat delta = offsetY - headerContentViewHeight;
    
    CGFloat alpha = delta / (CGRectGetHeight(slidePageScrollView.headerView.frame) - 64);
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    
    self.leftNavBarItem.alpha = alpha;
    self.navigationItem.titleView.alpha = alpha;
}


- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView horizenScrollToPageIndex:(NSInteger)index {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageMenuController:selectedAtIndex:)]) {
        [self.delegate pageMenuController:self selectedAtIndex:index];
    }
}


#pragma mark - getter and setter

-(void)setHeadView:(UIView *)headView {
    
    _headView = headView;
}



@end
