//
//  UIViewController+Addition.h
//
//
//  Created by lcd on 15/8/18.
//  Copyright (c) 2015年 4399. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DDNavBarItemType) {
    DDNavBarItemTypeLeft =  0,
    DDNavBarItemTypeRight = 1,
};

@interface UIViewController (LNAddition)


@property (nonatomic, strong) UIButton *leftNavBarItem;
@property (nonatomic, strong) UIButton *rightNavBarItem;

- (void)dd_cusomNavBarItemWithImage:(NSString *)normalName
                          highlight:(NSString *)highlightName
                              title:(NSString *)title
                               type:(DDNavBarItemType)type
                             action:(dispatch_block_t)btnBlock;

/*
 *  title设置
 */
- (void)dd_navTitle:(NSString *)title;

/*
 *
 */
- (void)dd_setCustomTitleViewWithTitle:(NSString *)title;

/*
 *  导航栏color设置
 */
- (void)dd_navBarColor:(UIColor *)color;

/*
 *  背景设置
 */
- (void)dd_backgroundColor:(UIColor *)color;

/*
 *  导航栏加阴影
 */

- (void)dd_navBarShadow;



@end
