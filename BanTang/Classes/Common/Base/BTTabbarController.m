//
//  BTTabbarController.m
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTTabbarController.h"
#import "UIColor+Extend.h"

@implementation BTTabbarController

-(void)viewDidLoad {

    [super viewDidLoad];
    

    
}

-(void)awakeFromNib {
    
    [super awakeFromNib];
    [UITabBar appearance].tintColor = DDRGB(249, 115, 111);
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(-10, 0, 0, 0);
}

@end
