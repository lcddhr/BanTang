//
//  BTHomeHeadView.m
//  BanTang
//
//  Created by lovelydd on 16/2/3.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTHomeHeadView.h"
#import "DDCircleView.h"
#import "UIConfig.h"

#import "StyledPageControl.h"

#import "UIImage+Extend.h"
#import "UIView+Extend.h"

#import "BTHomeMenuItem.h"

@interface BTHomeHeadView () <DDCircleViewDelegate>

@property (nonatomic, strong) DDCircleView *circleView;
@property (nonatomic, strong) BTHomeMenuView *menuView;

@property (nonatomic, assign) NSInteger currentIndex;

@end


@implementation BTHomeHeadView

- (instancetype)initWithUrls:(NSArray *)urls {
    
    CGRect rect = CGRectMake(0, 0, kBTScreenWidth, kBTHomeHeadMenuHeight + kBTCicleViewHeight - kBTHomeHeadMenuAndCircleViewSpacing);
    return [self initWithFrame:rect urls:urls];
}

- (instancetype)initWithFrame:(CGRect)frame urls:(NSArray*)urls {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _circleView = [self createCircleViewWithUrls:urls];
        _menuView = [self createMenuViewWithCount:urls.count];
        
        [self addSubview:_circleView];
        [self addSubview:_menuView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

#pragma mark - Private

- (DDCircleView *)createCircleViewWithUrls:(NSArray *)urls {
    
    DDCircleView *headview = [[DDCircleView alloc] initWithTitles:@[] urls:urls];
    headview.showPageControl = NO;
    headview.showTitleControl = NO;
    headview.delegate = self;
    return headview;
}

- (BTHomeMenuView *)createMenuViewWithCount:(NSInteger)count {
    
    return [[BTHomeMenuView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kBTHomeHeadMenuHeight)
                                       pageCount:count];
}




- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    _circleView.frame = CGRectMake(0, 0, self.bounds.size.width, kBTCicleViewHeight);
    _menuView.frame = CGRectMake(0, _circleView.frame.size.height - 30, self.bounds.size.width, kBTHomeHeadMenuHeight);
}


#pragma makr -

-(void)circleView:(DDCircleView *)view didScrollToIndex:(NSInteger)index {
    
    
    if (_currentIndex == index) {
        
        return;
    }
    _currentIndex = index;
    
//    NSLog(@"circle :%ld",(long)index);
    self.menuView.pageControl.currentPage = index;
}


-(void)circleView:(DDCircleView *)view didSelectedIndex:(NSInteger)index {
    
    
}

#pragma mark - getter and setter

@end


@interface BTHomeMenuView ()

@property (nonatomic, strong) NSArray *menuItems;

@end


@implementation BTHomeMenuView



- (instancetype)initWithFrame:(CGRect)frame pageCount:(NSInteger)pageCount {
    
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = [UIColor whiteColor];
        self.layer.mask = [self createMenuShapeLayerWithFrame:frame];
        
        _pageControl = [self createPageControlWithCount:pageCount];
        [self addSubview:_pageControl];
        
        _menuItems = [self createMenuItem];
        
        [_menuItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self addSubview:obj];
        }];
        
    }
    return self;
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    _pageControl.frame = CGRectMake(self.width / 2 - kBTHomeHeadMenuPageControlWidth / 2, 10, kBTHomeHeadMenuPageControlWidth,kBTHomeHeadMenuPageControlHeight);
    
    CGFloat betweenItemsSpacing = ( self.width - kBTHomeHeadMenuItemSpacing * 2 - 4 * kBTHomeHeadMenuItemWidth) / 3;
    
    for (NSInteger i = 0; i < self.menuItems.count; i++) {
        
        BTHomeMenuItem *item = self.menuItems[i];
        
        item.frame = CGRectMake(kBTHomeHeadMenuItemSpacing + i * ( kBTHomeHeadMenuItemWidth + betweenItemsSpacing), _pageControl.bottom + 5, kBTHomeHeadMenuItemWidth, kBTHomeHeadMenuItemHeight);
        
    }
    
}

#pragma mark - Private
- (CAShapeLayer *)createMenuShapeLayerWithFrame:(CGRect)frame {

    UIBezierPath *path = [self createMaskPathWithFrame:frame];
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.path = path.CGPath;
    return shapLayer;
}

//创建圆弧的蒙版层
- (UIBezierPath*)createMaskPathWithFrame:(CGRect)frame {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    [path moveToPoint:CGPointMake(frame.origin.x, 30)];
    [path addQuadCurveToPoint:CGPointMake(frame.size.width, 30) controlPoint:CGPointMake(frame.size.width / 2, 0)];
    [path addLineToPoint:CGPointMake(frame.size.width, frame.size.height)];
    [path addLineToPoint:CGPointMake(0, frame.size.height)];
    [path addLineToPoint:CGPointMake(frame.origin.x, 30)];
    
    return path;
}

- (StyledPageControl *)createPageControlWithCount:(NSInteger)pageCount {
    
    
    StyledPageControl *pageControl = [[StyledPageControl alloc] initWithFrame:CGRectMake(self.width / 2 - kBTHomeHeadMenuPageControlWidth / 2, 10, kBTHomeHeadMenuPageControlWidth,kBTHomeHeadMenuPageControlHeight)];
    [pageControl setNumberOfPages:pageCount];
    [pageControl setCurrentPage:0];
    [pageControl setPageControlStyle:PageControlStyleDefault];
    [pageControl setCoreNormalColor:[UIColor lightGrayColor]];
    [pageControl setCoreSelectedColor:[UIColor orangeColor]];
    return pageControl;
}

- (NSArray *)createMenuItem {
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:4];
    NSArray *itemTitles = @[@"好物",@"搜索",@"种草",@"签到"];
    for (NSInteger i = 0; i < 4; i++) {
        
        BTHomeMenuItem *item = [BTHomeMenuItem createMenuItem];
        item.tag = i;
        [items addObject:item];
        NSString *imageName = [NSString stringWithFormat:@"button%ld",i+1];
        UIImage *image = [UIImage imageNamed:imageName];
//        [item.menuButton setImage:image forState:UIControlStateNormal];
        item.menuTitle.text = itemTitles[i];
        image = nil;
    }
    return items;
}


@end