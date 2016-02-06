//
//  BTBaseTableViewCell.m
//  BanTang
//
//  Created by lovelydd on 16/2/5.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTBaseTableViewCell.h"

@implementation BTBaseTableViewCell


+ (NSString *)cellIdentifier {
    
    return [NSString stringWithFormat:@"%@Identifier",NSStringFromClass(self)];
}

+ (NSString *)nibName {
    
    return NSStringFromClass(self);
}

- (void)awakeFromNib {
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
