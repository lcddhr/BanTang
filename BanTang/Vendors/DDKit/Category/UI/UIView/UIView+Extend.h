//
//  UIView+Extend.h
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extend)

@property (nonatomic, assign, readonly) CGPoint origin;
@property (nonatomic, assign, readonly) CGSize size;

@property (nonatomic, assign, readonly) CGPoint bottomLeft;
@property (nonatomic, assign, readonly) CGPoint bottomRight;
@property (nonatomic, assign, readonly) CGPoint topRight;

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;

@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;


- (UIViewController *)dd_topViewController;
@end
