//
//  DDCircleView.h
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDCircleView;

@protocol DDCircleViewDelegate <NSObject>


- (void)circleView:(DDCircleView *)view didSelectedIndex:(NSInteger)index;

- (void)circleView:(DDCircleView *)view didScrollToIndex:(NSInteger)index;


@end

@interface DDCircleView : UIView

@property (nonatomic, weak) id<DDCircleViewDelegate> delegate;

@property (nonatomic, assign) BOOL showPageControl;

@property (nonatomic, assign) BOOL showTitleControl;

-(instancetype)initWithTitles:(NSArray *)titles urls:(NSArray *)urls;
@end
