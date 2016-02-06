//
//  TYSlidePageScrollViewController.m
//  TYSlidePageScrollViewDemo
//
//  Created by SunYong on 15/7/17.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "TYSlidePageScrollViewController.h"

@interface TYSlidePageScrollViewController ()
@property (nonatomic, weak) TYSlidePageScrollView *slidePageScrollView;
@end

@implementation TYSlidePageScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addSlidePageScrollView];
    
    [self layoutSlidePageScrollView];
}

- (void)addSlidePageScrollView
{
    TYSlidePageScrollView *slidePageScrollView = [[TYSlidePageScrollView alloc]initWithFrame:self.view.bounds];
    slidePageScrollView.dataSource = self;
    slidePageScrollView.delegate = self;
    [self.view addSubview:slidePageScrollView];
    _slidePageScrollView = slidePageScrollView;
}

- (void)layoutSlidePageScrollView
{
    _slidePageScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_slidePageScrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_slidePageScrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_slidePageScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_slidePageScrollView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
}

#pragma mark - TYSlidePageScrollViewDataSource

// if you want to deal with dataSource , you can override
- (NSInteger)numberOfPageViewOnSlidePageScrollView
{
    return _viewControllers.count;
}

- (UIScrollView *)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index
{
    UIViewController<UIViewControllerDisplayViewDelegate> *viewController = _viewControllers[index];

    if (![self.childViewControllers containsObject:viewController]) {
        // don't forget set frame and addChildViewController
        viewController.view.frame = self.view.frame;
        [self addChildViewController:viewController];
    }
    
    if ([viewController conformsToProtocol:@protocol(UIViewControllerDisplayViewDelegate)]) {
        return [viewController displayView];
    }else if([viewController isKindOfClass:[UITableViewController class]]){
        return ((UITableViewController *)viewController).tableView;
    }else if ([viewController isKindOfClass:[UICollectionViewController class]]){
        return ((UICollectionViewController *)viewController).collectionView;
    }else if ([viewController.view isKindOfClass:[UIScrollView class]]) {
        return (UIScrollView *)viewController.view;
    }
    NSLog(@"you don't implemente UIViewControllerDisplayViewDelegate ,I don't konw need display View");
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
