//
//  BTPageMenuController.h
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTViewController.h"

@class BTPageMenuController;
@protocol BTPageMenuControllerDelegate <NSObject>


- (void)pageMenuController:(BTPageMenuController *)pageMenuController selectedAtIndex:(NSInteger)index;

@end

@interface BTPageMenuController : BTViewController


@property (nonatomic, weak) id<BTPageMenuControllerDelegate> delegate;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *controllers;

@property (nonatomic, strong) NSArray *footView;

@property (nonatomic, assign) BOOL parallaxHeaderEffect;

@property (nonatomic, assign) BOOL showTitleLabel;

- (void)reloadData;

@end
