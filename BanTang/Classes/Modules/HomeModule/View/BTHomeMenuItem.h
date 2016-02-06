//
//  BTHomeMenuItem.h
//  BanTang
//
//  Created by lovelydd on 16/2/4.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTHomeMenuItem : UIView

@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UILabel *menuTitle;

+ (BTHomeMenuItem *)createMenuItem;
@end
