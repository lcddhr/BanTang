//
//  DDCircleView.m
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "DDCircleView.h"
#import <SDCycleScrollView.h>
#import "UIConfig.h"

@interface DDCircleView () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *urls;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@end

@implementation DDCircleView


-(instancetype)initWithTitles:(NSArray *)titles urls:(NSArray *)urls{
    
    return [self initWithFrame:CGRectZero titles:titles urls:urls];
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles urls:(NSArray *)urls{
    
    
    _titles = titles;
    _urls = urls;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kBTScreenWidth, kBTCicleViewHeight) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.titlesGroup = self.titles;
    _cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    _cycleScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_cycleScrollView];
    _cycleScrollView.imageURLStringsGroup = self.urls;
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    _cycleScrollView.frame = self.bounds;
}

#pragma mark - 

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(circleView:didSelectedIndex:)]) {
        
        [self.delegate circleView:self didSelectedIndex:index];
    }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(circleView:didScrollToIndex:)]) {
        
        [self.delegate circleView:self didScrollToIndex:index];
    }
}


#pragma mark - Getter and Setter

-(void)setShowPageControl:(BOOL)showPageControl {
    
    
    _showPageControl = showPageControl;
    
    if (_cycleScrollView) {
        
        _cycleScrollView.showPageControl = showPageControl;
    }
}


-(void)setShowTitleControl:(BOOL)showTitleControl {
    
    showTitleControl = showTitleControl;
    
    if (_cycleScrollView) {
        _cycleScrollView.titleLabelHeight = 0;
        
    }
}


@end
