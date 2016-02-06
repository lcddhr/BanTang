//
//  BTHomeHeadView.h
//  BanTang
//
//  Created by lovelydd on 16/2/3.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import <UIKit/UIKit.h>


@class StyledPageControl;

@interface BTHomeHeadView : UIView


- (instancetype)initWithUrls:(NSArray *)urls;
@end

@interface BTHomeMenuView : UIView

@property (nonatomic, strong) StyledPageControl *pageControl;

- (instancetype)initWithFrame:(CGRect)frame pageCount:(NSInteger)pageCount;


@end