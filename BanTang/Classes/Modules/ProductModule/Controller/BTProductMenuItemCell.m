//
//  BTProductMenuItemCell.m
//  BanTang
//
//  Created by lovelydd on 16/2/15.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTProductMenuItemCell.h"

@implementation BTProductMenuItemCell

-(void)awakeFromNib {
    
    [super awakeFromNib];

    _itemImageView.layer.cornerRadius = 30;
    _itemImageView.layer.masksToBounds = YES;
}

+ (NSString *)cellIdentifier {
    
    return [NSString stringWithFormat:@"%@Identifier",NSStringFromClass(self)];
}
+ (NSString *)nibName {
    
    return NSStringFromClass(self);
}

+ (BTProductMenuItemCell *)createMenuItemCell {
    
    BTProductMenuItemCell *item = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
    return item;
}
@end
