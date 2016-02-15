//
//  BTProductMenuView.m
//  BanTang
//
//  Created by lovelydd on 16/2/15.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTProductMenuView.h"
#import "UIConfig.h"
#import "TYTitlePageTabBar.h"
#import "TYSlidePageScrollView.h"
#import "BTProductMenuController.h"
#import "BTProductMenuItemCell.h"

@interface TYBasePageTabBar ()
@property (nonatomic, weak) id<TYBasePageTabBarPrivateDelegate> praviteDelegate;
@end

@interface BTProductMenuView ()<TYSlidePageScrollViewDelegate,TYSlidePageScrollViewDataSource, UICollectionViewDataSource,UICollectionViewDelegate,TYBasePageTabBarPrivateDelegate>

@property (nonatomic, strong) NSArray *barTitles;
@property (nonatomic, strong) NSArray *menuItemTitles;
@property (nonatomic, weak) TYSlidePageScrollView *slidePageScrollView;
@property (nonatomic, weak) TYTitlePageTabBar *titlePageTabBar;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation BTProductMenuView


- (instancetype)initWithBarTitles:(NSArray *)barTitles menuItemTitles:(NSArray *)itemTitles {
    
    return [self initWithFrame:CGRectZero barTitles:barTitles menuItemTitles:itemTitles];
}

- (instancetype)initWithFrame:(CGRect)frame barTitles:(NSArray *)barTitles menuItemTitles:(NSArray *)menuItemTitles {
    
    
    self = [super initWithFrame:CGRectMake(0, 0, kBTScreenWidth, kBTProductMenuViewSizeHeight)];
    if (self) {
        _barTitles = barTitles;
        _menuItemTitles = menuItemTitles;
        _selectedIndex = 0;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    
    TYTitlePageTabBar *titlePageTabBar = [[TYTitlePageTabBar alloc]initWithTitleArray:_barTitles];
    titlePageTabBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 40);
    titlePageTabBar.backgroundColor = [UIColor whiteColor];
    titlePageTabBar.horIndicatorColor = kBTNavBarColor;
    titlePageTabBar.selectedTextFont = titlePageTabBar.textFont;
    titlePageTabBar.titleSpacing = 5;
    titlePageTabBar.textColor = [UIColor lightGrayColor];
    titlePageTabBar.horIndicatorSpacing = 10.0f;
    titlePageTabBar.selectedTextColor = kBTNavBarColor;
    titlePageTabBar.praviteDelegate = self;
    _titlePageTabBar = titlePageTabBar;
    [self addSubview:titlePageTabBar];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, kBTScreenWidth, kBTProductMenuViewSizeHeight - 40) collectionViewLayout:layout];
    [_collectionView registerNib:[UINib nibWithNibName:[BTProductMenuItemCell nibName] bundle:nil] forCellWithReuseIdentifier:[BTProductMenuItemCell cellIdentifier]];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.bounces = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_collectionView];
    
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    _titlePageTabBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 40);
    _collectionView.frame = CGRectMake(0, 40, self.frame.size.width, kBTProductMenuViewSizeHeight - 40);
    
}

#pragma mark - UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *titles = _menuItemTitles[section];
    
    return titles.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _menuItemTitles.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BTProductMenuItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[BTProductMenuItemCell cellIdentifier] forIndexPath:indexPath];
    
    if (_menuItemTitles.count > 0) {
         NSArray *titles = _menuItemTitles[indexPath.section];
        cell.itemTitle.text = titles[indexPath.row];
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(_collectionView.bounds) / 4.0, (kBTProductMenuViewSizeHeight - 40) / 2);
}

#pragma mark - 
- (void)basePageTabBar:(TYBasePageTabBar *)basePageTabBar clickedPageTabBarAtIndex:(NSInteger)index {
    
    
    if (_selectedIndex == index) {
        return;
    }
    
      _selectedIndex = index;
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [_collectionView setContentOffset:CGPointMake(_selectedIndex * _collectionView.bounds.size.width, 0.0f) animated:YES];
   [UIView commitAnimations];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / _collectionView.bounds.size.width;
    
    if (_selectedIndex == index) {
        return;
    }
    _selectedIndex = index;
    
    [_titlePageTabBar switchToPageIndex:_selectedIndex];
}

@end
