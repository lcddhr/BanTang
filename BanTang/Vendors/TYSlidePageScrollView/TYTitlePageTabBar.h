//
//  TYTitlePageTabBar.h
//  TYSlidePageScrollViewDemo
//
//  Created by SunYong on 15/7/16.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "TYBasePageTabBar.h"

@interface TYTitlePageTabBar : TYBasePageTabBar

@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIFont *selectedTextFont;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;

@property (nonatomic, strong) UIColor *horIndicatorColor;
@property (nonatomic, assign) CGFloat horIndicatorHeight;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, assign) UIEdgeInsets edgeInset;   // view edge Inset
@property (nonatomic, assign) CGFloat titleSpacing;     // title button spacing

@property (nonatomic, assign) CGFloat horIndicatorSpacing;

- (instancetype)initWithTitleArray:(NSArray *)titleArray;

- (instancetype)initWithTitleArray:(NSArray *)titleArray imageNameArray:(NSArray *)imageNameArray;

@end
