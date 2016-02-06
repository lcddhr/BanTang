//
//  TYSlidePageScrollView.m
//  TYSlidePageScrollViewDemo
//
//  Created by tanyang on 15/7/16.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "TYSlidePageScrollView.h"
#import "UIScrollView+ty_swizzle.h"

@interface TYBasePageTabBar ()
@property (nonatomic, weak) id<TYBasePageTabBarPrivateDelegate> praviteDelegate;
@end

@interface TYSlidePageScrollView ()<UIScrollViewDelegate,TYBasePageTabBarPrivateDelegate>{
    struct {
        unsigned int horizenScrollToPageIndex   :1;
        unsigned int horizenScrollViewDidScroll :1;
        unsigned int horizenScrollViewDidEndDecelerating :1;
        unsigned int horizenScrollViewWillBeginDragging :1;
        unsigned int verticalScrollViewDidScroll :1;
        unsigned int pageTabBarScrollOffset :1;
    }_delegateFlags;
}

@property (nonatomic, weak) UIScrollView    *horScrollView;     // horizen scroll View
@property (nonatomic, weak) UIView          *headerContentView; // contain header and pageTab
@property (nonatomic, strong) NSArray       *pageViewArray;

@property (nonatomic, weak) UIPanGestureRecognizer *headerContentPanGusture;

@property (nonatomic, strong) NSLayoutConstraint *headerContentYConstraint;
@property (nonatomic, strong) NSLayoutConstraint *headerContentHeightConstraint;

@property (nonatomic, assign) CGFloat headerContentViewHeight;
@property (nonatomic, assign) CGFloat pageScrollViewOffsetY;

@end

@implementation TYSlidePageScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setPropertys];
        
        [self addHorScrollView];
        
        [self addHeaderContentView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setPropertys];
        
        [self addHorScrollView];
        
        [self addHeaderContentView];
    }
    return self;
}

#pragma mark - setter getter

- (void)setPropertys
{
    _curPageIndex = 0;
    _headerContentViewPanGestureEnable = NO;
    _pageTabBarStopOnTopHeight = 0;
    _pageTabBarIsStopOnTop = YES;
    _automaticallyAdjustsScrollViewInsets = NO;
    _changeToNextIndexWhenScrollToWidthOfPercent = 0.5;
}

- (void)resetPropertys
{
    [self addPageViewKeyPathOffsetWithOldIndex:_curPageIndex newIndex:-1];
    [_headerContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_footerView removeFromSuperview];
    [_pageViewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == _headerContentView ||constraint.firstItem == _horScrollView) {
            [self removeConstraint:constraint];
        }
    }
}

- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)setViewControllerAdjustsScrollView
{
    UIViewController *viewController = [self viewController];
    if ([viewController respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        viewController.automaticallyAdjustsScrollViewInsets = _automaticallyAdjustsScrollViewInsets;
    }
}

- (void)setDelegate:(id<TYSlidePageScrollViewDelegate>)delegate
{
    _delegate = delegate;
    
    _delegateFlags.horizenScrollToPageIndex = [delegate respondsToSelector:@selector(slidePageScrollView:horizenScrollToPageIndex:)];
    _delegateFlags.horizenScrollViewDidScroll = [delegate respondsToSelector:@selector(slidePageScrollView:horizenScrollViewDidScroll:)];
    _delegateFlags.horizenScrollViewDidEndDecelerating = [delegate respondsToSelector:@selector(slidePageScrollView:horizenScrollViewDidEndDecelerating:)];
    _delegateFlags.horizenScrollViewWillBeginDragging = [delegate respondsToSelector:@selector(slidePageScrollView:horizenScrollViewWillBeginDragging:)];
    _delegateFlags.verticalScrollViewDidScroll = [delegate respondsToSelector:@selector(slidePageScrollView:verticalScrollViewDidScroll:)];
    _delegateFlags.pageTabBarScrollOffset = [delegate respondsToSelector:@selector(slidePageScrollView:pageTabBarScrollOffset:state:)];
}

#pragma mark - add subView

- (void)addHorScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    [self addSubview:scrollView];
    _horScrollView = scrollView;
    
}

- (void)addHeaderContentView
{
    UIView *headerContentView = [[UIView alloc]init];
    [self addSubview:headerContentView];
    _headerContentView = headerContentView;
    
    self.headerContentViewPanGestureEnable = _headerContentViewPanGestureEnable;
}

- (void)setHeaderContentViewPanGestureEnable:(BOOL)headerContentViewPanGestureEnabe
{
    if (!headerContentViewPanGestureEnabe) {
        [_headerContentView removeGestureRecognizer:_headerContentPanGusture];
        _headerContentPanGusture = nil;
        return;
    }
    
    if (_headerContentPanGusture == nil) {
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [_headerContentView addGestureRecognizer:panRecognizer];
        _headerContentPanGusture = panRecognizer;
    }
}

#pragma mark - private method

- (void)updateHeaderContentView
{
    if (_headerView) {
        [_headerContentView addSubview:_headerView];
    }
    
    if (_pageTabBar) {
        _pageTabBar.praviteDelegate = self;
        [_headerContentView addSubview:_pageTabBar];
    }
}

- (void)layoutHeaderContentView
{
    _headerContentView.translatesAutoresizingMaskIntoConstraints = NO;
    _headerContentYConstraint = [NSLayoutConstraint constraintWithItem:_headerContentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_headerContentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:_headerContentYConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_headerContentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    _headerContentViewHeight = CGRectGetHeight(_headerView.frame)+CGRectGetHeight(_pageTabBar.frame);
    
    NSLayoutConstraint *heightConstraint = nil;
    for (NSLayoutConstraint *constraint in _headerContentView.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            heightConstraint = constraint;
            break;
        }
    }
    
    if (!heightConstraint) {
        heightConstraint = [NSLayoutConstraint constraintWithItem:_headerContentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:_headerContentViewHeight];
        [_headerContentView addConstraint:heightConstraint];
    }else {
        heightConstraint.constant = _headerContentViewHeight;
    }
    _headerContentHeightConstraint = heightConstraint;
    
    if (_headerView) {
        _headerView.translatesAutoresizingMaskIntoConstraints = NO;
        [_headerContentView addConstraint:[NSLayoutConstraint constraintWithItem:_headerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_headerContentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [_headerContentView addConstraint:[NSLayoutConstraint constraintWithItem:_headerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_headerContentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [_headerContentView addConstraint:[NSLayoutConstraint constraintWithItem:_headerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_headerContentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        
        if (!_pageTabBar){
            [_headerContentView addConstraint:[NSLayoutConstraint constraintWithItem:_headerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_headerContentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        }
    }

    if (_pageTabBar) {
        _pageTabBar.translatesAutoresizingMaskIntoConstraints = NO;
        [_headerContentView addConstraint:[NSLayoutConstraint constraintWithItem:_pageTabBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_headerContentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [_headerContentView addConstraint:[NSLayoutConstraint constraintWithItem:_pageTabBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_headerView ? _headerView:_headerContentView attribute:_headerView ? NSLayoutAttributeBottom:NSLayoutAttributeTop multiplier:1 constant:0]];
        [_headerContentView addConstraint:[NSLayoutConstraint constraintWithItem:_pageTabBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_headerContentView attribute: NSLayoutAttributeBottom multiplier:1 constant:0]];
        [_headerContentView addConstraint:[NSLayoutConstraint constraintWithItem:_pageTabBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_headerContentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        
        NSLayoutConstraint *heightConstraint = nil;
        for (NSLayoutConstraint *constraint in _pageTabBar.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                heightConstraint = constraint;
                break;
            }
        }
        
        if (!heightConstraint) {
            [_pageTabBar addConstraint:[NSLayoutConstraint constraintWithItem:_pageTabBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:CGRectGetHeight(_pageTabBar.frame)]];
        }else {
            heightConstraint.constant = CGRectGetHeight(_pageTabBar.frame);
        }
    }
}

- (void)updateFooterView
{
    if (_footerView) {
        [self addSubview:_footerView];
    }
}

- (void)layoutFooterView
{
    if (_footerView) {
        _footerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_footerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_footerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_footerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        
        NSLayoutConstraint *heightConstraint = nil;
        for (NSLayoutConstraint *constraint in _footerView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                heightConstraint = constraint;
                break;
            }
        }
        
        if (!heightConstraint) {
            [_footerView addConstraint:[NSLayoutConstraint constraintWithItem:_footerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:CGRectGetHeight(_footerView.frame)]];
        }else {
            heightConstraint.constant = CGRectGetHeight(_footerView.frame);
        }
    }
}

- (void)updatePageViews
{
    NSInteger pageNum = [_dataSource numberOfPageViewOnSlidePageScrollView];
    NSMutableArray *scrollViewArray = [NSMutableArray arrayWithCapacity:pageNum];
    for (NSInteger index = 0; index < pageNum; ++index) {
        UIScrollView *pageVerScrollView = [_dataSource slidePageScrollView:self pageVerticalScrollViewForIndex:index];
        [_horScrollView addSubview:pageVerScrollView];
        [scrollViewArray addObject:pageVerScrollView];
    }
    
    _pageViewArray = [scrollViewArray copy];
}

- (void)layoutPageViews
{
    _horScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_horScrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_horScrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_horScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_horScrollView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    CGFloat footerViewHieght = CGRectGetHeight(_footerView.frame);
    
    __block UIScrollView *prePageView = nil;
    for (UIScrollView *pageVerScrollView in _pageViewArray) {
        pageVerScrollView.translatesAutoresizingMaskIntoConstraints = NO;
        if (prePageView) {
            [_horScrollView addConstraint:[NSLayoutConstraint constraintWithItem:pageVerScrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:prePageView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        }else {
            [_horScrollView addConstraint:[NSLayoutConstraint constraintWithItem:pageVerScrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_horScrollView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        }
        prePageView = pageVerScrollView;

        [_horScrollView addConstraint:[NSLayoutConstraint constraintWithItem:pageVerScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_horScrollView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [_horScrollView addConstraint:[NSLayoutConstraint constraintWithItem:pageVerScrollView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_horScrollView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
        [_horScrollView addConstraint:[NSLayoutConstraint constraintWithItem:pageVerScrollView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_horScrollView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        
        pageVerScrollView.contentInset = UIEdgeInsetsMake(_headerContentViewHeight, 0, footerViewHieght, 0);
        pageVerScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(_headerContentViewHeight, 0, footerViewHieght, 0);
    };
    [_horScrollView addConstraint:[NSLayoutConstraint constraintWithItem:_horScrollView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:prePageView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    _horScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*_pageViewArray.count, 0);

}

- (void)addPageViewKeyPathOffsetWithOldIndex:(NSInteger)oldIndex newIndex:(NSInteger)newIndex
{
    if (oldIndex == newIndex) {
        return;
    }
    
    if (oldIndex >= 0 && oldIndex < _pageViewArray.count) {
        [_pageViewArray[oldIndex] removeObserver:self forKeyPath:@"contentOffset" context:nil];
    }
    if (newIndex >= 0 && newIndex < _pageViewArray.count) {
        [_pageViewArray[newIndex] addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self pageScrollViewDidScroll:object changeOtherPageViews:NO];
    }
}

- (CGFloat)scrollViewMinContentSizeHeight
{
    CGFloat viewHeight = CGRectGetHeight(self.frame);
    CGFloat pageTabBarHieght = CGRectGetHeight(_pageTabBar.frame);
    CGFloat footerHeight = CGRectGetHeight(_footerView.frame);
    
    NSInteger scrollMinContentSizeHeight = viewHeight - (pageTabBarHieght + _pageTabBarStopOnTopHeight + footerHeight);
    
    if (!_pageTabBarIsStopOnTop) {
        scrollMinContentSizeHeight = viewHeight - footerHeight;
    }
    return scrollMinContentSizeHeight;
}

- (void)dealPageScrollView:(UIScrollView *)pageScrollView minContentSizeHeight:(CGFloat)minContentSizeHeight
{
    pageScrollView.minContentSizeHeight = minContentSizeHeight;
    
    if (pageScrollView.contentSize.height < minContentSizeHeight) {
        pageScrollView.contentSize = CGSizeMake(pageScrollView.contentSize.width, minContentSizeHeight);
    }
}

- (void)dealAllPageScrollViewMinContentSize
{
    NSInteger minContentSizeHeight = [self scrollViewMinContentSizeHeight];
    // 处理所有scrollView contentsize
    for (UIScrollView *pageView in _pageViewArray) {
        [self dealPageScrollView:pageView minContentSizeHeight:minContentSizeHeight];
    }
}

- (void)changeAllPageScrollViewOffsetY:(CGFloat)offsetY isOnTop:(BOOL)isOnTop
{
    [_pageViewArray enumerateObjectsUsingBlock:^(UIScrollView *pageScrollView, NSUInteger idx, BOOL *stop) {
        if (idx != _curPageIndex && !(isOnTop && pageScrollView.contentOffset.y > offsetY)) {
            [pageScrollView setContentOffset:CGPointMake(pageScrollView.contentOffset.x, offsetY)];
        }
    }];
}

- (void)resetPageScrollViewContentOffset
{
    if (_curPageIndex >= 0 && _curPageIndex < _pageViewArray.count) {
        UIScrollView *pagescrollView = _pageViewArray[_curPageIndex];
        pagescrollView.contentOffset = CGPointMake(pagescrollView.contentOffset.x, -_headerContentViewHeight);
    }
}

#pragma mark - public method

- (void)reloadData
{
    [self resetPropertys];
    
    [self setViewControllerAdjustsScrollView];
    
    [self updateHeaderContentView];
    
    [self layoutHeaderContentView];
    
    [self updateFooterView];
    
    [self layoutFooterView];
    
    [self updatePageViews];
    
    [self layoutPageViews];
    
    [self addPageViewKeyPathOffsetWithOldIndex:-1 newIndex:_curPageIndex];
    
    [self dealAllPageScrollViewMinContentSize];
    
    [self resetPageScrollViewContentOffset];
}

- (void)scrollToPageIndex:(NSInteger)index animated:(BOOL)animated
{
    if (index < 0 || index >= _pageViewArray.count) {
        NSLog(@"scrollToPageIndex index illegal");
        return;
    }
    
    [self pageScrollViewDidScroll:_pageViewArray[_curPageIndex] changeOtherPageViews:YES];
    [_horScrollView setContentOffset:CGPointMake(index * CGRectGetWidth(_horScrollView.frame), 0) animated:animated];
}

- (UIScrollView *)pageScrollViewForIndex:(NSInteger)index
{
    if (index < 0 || index >= _pageViewArray.count) {
        NSLog(@"pageScrollViewForIndex index illegal");
        return nil;
    }
    
    return _pageViewArray[index];
}

- (NSInteger)indexOfPageScrollView:(UIScrollView *)pageScrollView
{
    return [_pageViewArray indexOfObject:pageScrollView];
}

#pragma mark - UIPanGestureRecognizer

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translatedPoint = [recognizer translationInView:self];
    CGFloat pageTabbarHeight = CGRectGetHeight(_pageTabBar.frame);
    
    UIScrollView *pageScrollView = _pageViewArray[_curPageIndex];
    if (pageScrollView.contentOffset.y <= -_headerContentViewHeight && translatedPoint.y > 0) {
        if (pageScrollView.contentOffset.y != -_headerContentViewHeight) {
            pageScrollView.contentOffset = CGPointMake(pageScrollView.contentOffset.x, -_headerContentViewHeight);
            _pageScrollViewOffsetY = pageScrollView.contentOffset.y;
        }
        return;
    }else if (pageScrollView.contentOffset.y >= -(pageTabbarHeight + _pageTabBarStopOnTopHeight) && translatedPoint.y < 0) {
        if (pageScrollView.contentOffset.y != -(pageTabbarHeight + _pageTabBarStopOnTopHeight)) {
            pageScrollView.contentOffset =  CGPointMake(pageScrollView.contentOffset.x,-(pageTabbarHeight + _pageTabBarStopOnTopHeight));
            _pageScrollViewOffsetY = pageScrollView.contentOffset.y;
        }
        return;
    }
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _pageScrollViewOffsetY = pageScrollView.contentOffset.y;
    }else if(recognizer.state == UIGestureRecognizerStateChanged) {
        pageScrollView.contentOffset = CGPointMake(pageScrollView.contentOffset.x, _pageScrollViewOffsetY-translatedPoint.y);
    }
}

#pragma mark - delegate
// horizen scrollView
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_delegateFlags.horizenScrollViewWillBeginDragging) {
        [_delegate slidePageScrollView:self horizenScrollViewWillBeginDragging:scrollView];
    }
    
    [self pageScrollViewDidScroll:_pageViewArray[_curPageIndex] changeOtherPageViews:YES];
}

// horizen scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_delegateFlags.horizenScrollViewDidScroll) {
        [_delegate slidePageScrollView:self horizenScrollViewDidScroll:_horScrollView];
    }
    
    NSInteger index = (NSInteger)(scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame) + _changeToNextIndexWhenScrollToWidthOfPercent);
    
    if (_curPageIndex != index) {
        if (index >= _pageViewArray.count) {
            index = _pageViewArray.count-1;
        }
        if (index < 0) {
            index = 0;
        }
        
        [self addPageViewKeyPathOffsetWithOldIndex:_curPageIndex newIndex:index];
        _curPageIndex = index;
        
        if (_pageTabBar) {
            [_pageTabBar switchToPageIndex:_curPageIndex];
        }
        if (_delegateFlags.horizenScrollToPageIndex) {
            [_delegate slidePageScrollView:self horizenScrollToPageIndex:_curPageIndex];
        }
    }
}

// page scrollView
- (void)pageScrollViewDidScroll:(UIScrollView *)pageScrollView changeOtherPageViews:(BOOL)isNeedChange
{
    if (_delegateFlags.verticalScrollViewDidScroll) {
        [_delegate slidePageScrollView:self verticalScrollViewDidScroll:pageScrollView];
    }

    CGFloat pageTabBarHieght = CGRectGetHeight(_pageTabBar.frame);
    
    NSInteger pageTabBarIsStopOnTop = _pageTabBarStopOnTopHeight;
    if (!_pageTabBarIsStopOnTop) {
        pageTabBarIsStopOnTop = - pageTabBarHieght;
    }
    
    CGFloat offsetY = pageScrollView.contentOffset.y;
    if (offsetY <= -_headerContentViewHeight) {
        // headerContentView full show
        if (_headerContentYConstraint.constant != 0) {
            _headerContentYConstraint.constant = 0;
            if (_delegateFlags.pageTabBarScrollOffset) {
                [_delegate slidePageScrollView:self pageTabBarScrollOffset:offsetY state:TYPageTabBarStateStopOnButtom];
            }
        }
        if (_parallaxHeaderEffect) {
            _headerContentHeightConstraint.constant = -offsetY;
        }
        
        if (isNeedChange) {
            [self changeAllPageScrollViewOffsetY:-_headerContentViewHeight isOnTop:NO];
        }
    }else if (offsetY < -pageTabBarHieght - pageTabBarIsStopOnTop) {
        // scroll headerContentView
        if (_parallaxHeaderEffect && _headerContentHeightConstraint.constant != _headerContentViewHeight) {
            _headerContentHeightConstraint.constant = _headerContentViewHeight;
        }
        _headerContentYConstraint.constant = -(offsetY+_headerContentViewHeight);
        
        if (_delegateFlags.pageTabBarScrollOffset) {
            [_delegate slidePageScrollView:self pageTabBarScrollOffset:offsetY state:TYPageTabBarStateScrolling];
        }
        
        if (isNeedChange) {
            [self changeAllPageScrollViewOffsetY:pageScrollView.contentOffset.y isOnTop:NO];
        }
        
    }else {
        // pageTabBar on the top
        if (_parallaxHeaderEffect && _headerContentHeightConstraint.constant != _headerContentViewHeight) {
            _headerContentHeightConstraint.constant = _headerContentViewHeight;
        }
        
        if (_headerContentYConstraint.constant != -_headerContentViewHeight+pageTabBarHieght + pageTabBarIsStopOnTop) {
            _headerContentYConstraint.constant = -_headerContentViewHeight+pageTabBarHieght + pageTabBarIsStopOnTop;

            if (_delegateFlags.pageTabBarScrollOffset) {
                [_delegate slidePageScrollView:self pageTabBarScrollOffset:offsetY state:TYPageTabBarStateStopOnTop];
            }
        }
        
        if (isNeedChange) {
            [self changeAllPageScrollViewOffsetY:-pageTabBarHieght-pageTabBarIsStopOnTop isOnTop:YES];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_delegateFlags.horizenScrollViewDidEndDecelerating) {
        [_delegate slidePageScrollView:self horizenScrollViewDidEndDecelerating:_horScrollView];
    }
}

- (void)basePageTabBar:(TYBasePageTabBar *)basePageTabBar clickedPageTabBarAtIndex:(NSInteger)index
{
    [self scrollToPageIndex:index animated:NO];
}

-(void)dealloc
{
    //[self resetPropertys];
    [self addPageViewKeyPathOffsetWithOldIndex:_curPageIndex newIndex:-1];
    NSLog(@"TYSlidePageScrollView dealloc");
}

@end
