//
//  UITabBarController+Extend.m
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "UITabBarController+Extend.h"

@implementation UITabBarController (Extend)

- (void)dd_customTabbarItemFont:(CGFloat)fontSize {
    
    UIFont *tabBarFont = [UIFont systemFontOfSize:fontSize];
    NSDictionary *titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                         tabBarFont, NSFontAttributeName, nil];
    for(UIViewController *tab in self.viewControllers) {
        [tab.tabBarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
}
@end
