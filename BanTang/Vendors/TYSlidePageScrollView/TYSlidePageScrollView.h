//
//  TYSlidePageScrollView.h
//  TYSlidePageScrollViewDemo
//
//  Created by tanyang on 15/7/16.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYBasePageTabBar.h"

@class TYSlidePageScrollView;

typedef NS_ENUM(NSUInteger, TYPageTabBarState) {
    TYPageTabBarStateStopOnTop,
    TYPageTabBarStateScrolling,
    TYPageTabBarStateStopOnButtom,
};

@protocol TYSlidePageScrollViewDataSource <NSObject>

@required

// num of pageViews
- (NSInteger)numberOfPageViewOnSlidePageScrollView;

// pageView need inherit UIScrollView (UITableview inherit it) ,and vertical scroll
- (UIScrollView *)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index;

@end

@protocol TYSlidePageScrollViewDelegate <NSObject>

@optional

// vertical scroll any offset changes will call
- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView verticalScrollViewDidScroll:(UIScrollView *)pageScrollView;

// pageTabBar vertical scroll and state
- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageTabBarScrollOffset:(CGFloat)offset state:(TYPageTabBarState)state;

// horizen scroll to pageIndex, when index change will call
- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView horizenScrollToPageIndex:(NSInteger)index;

// horizen scroll any offset changes will call
- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView horizenScrollViewDidScroll:(UIScrollView *)scrollView;

// horizen scroll Begin Dragging
- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView horizenScrollViewWillBeginDragging:(UIScrollView *)scrollView;

// horizen scroll called when scroll view grinds to a halt
- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView horizenScrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end

@interface TYSlidePageScrollView : UIView

@property (nonatomic, weak)   id<TYSlidePageScrollViewDataSource> dataSource;
@property (nonatomic, weak)   id<TYSlidePageScrollViewDelegate> delegate;

@property (nonatomic, assign) BOOL automaticallyAdjustsScrollViewInsets; // default NO;(iOS 7) it will setup viewController automaticallyAdjustsScrollViewInsets, because this property (YES) cause scrollView layout no correct

@property (nonatomic, assign) BOOL headerContentViewPanGestureEnable; // default NO,if YES header also can let to veritical scroll (header区域是否可以上下滑动)

@property (nonatomic, strong) UIView *headerView; // defult nil，don't forget set height
@property (nonatomic, assign) BOOL parallaxHeaderEffect; // def NO, Parallax effect (弹性视差效果)

@property (nonatomic, strong) TYBasePageTabBar *pageTabBar; //defult nil
@property (nonatomic, assign) BOOL pageTabBarIsStopOnTop;  // default YES, is stop on top
@property (nonatomic, assign) CGFloat pageTabBarStopOnTopHeight; // default 0, bageTabBar stop on top height, if pageTabBarIsStopOnTop is NO ,this property is inValid

@property (nonatomic, strong) UIView *footerView; // defult nil

@property (nonatomic, assign, readonly) NSInteger curPageIndex; // defult 0

// 当滚动到scroll宽度的百分之多少 改变index 
@property (nonatomic, assign) CGFloat changeToNextIndexWhenScrollToWidthOfPercent; // 0.0~0.1 default 0.5, when scroll to half of width, change to next index


- (void)reloadData;

- (void)scrollToPageIndex:(NSInteger)index animated:(BOOL)animated;

- (UIScrollView *)pageScrollViewForIndex:(NSInteger)index;

- (NSInteger)indexOfPageScrollView:(UIScrollView *)pageScrollView;

@end
