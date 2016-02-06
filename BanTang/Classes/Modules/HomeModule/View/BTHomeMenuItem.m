//
//  BTHomeMenuItem.m
//  BanTang
//
//  Created by lovelydd on 16/2/4.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTHomeMenuItem.h"
#import "UIConfig.h"

@implementation BTHomeMenuItem




- (IBAction)tapMenuButtonAction:(id)sender {
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.bounds = CGRectMake(0, 0, kBTHomeHeadMenuItemWidth, kBTHomeHeadMenuItemHeight);
}

+ (BTHomeMenuItem *)createMenuItem {
    
    BTHomeMenuItem *item = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
    return item;
}
@end
