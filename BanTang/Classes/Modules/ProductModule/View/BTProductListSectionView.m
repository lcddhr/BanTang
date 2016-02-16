//
//  BTProductListSectionView.m
//  BanTang
//
//  Created by lovelydd on 16/2/16.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "BTProductListSectionView.h"
#import "BTDefaultConfig.h"

@interface BTProductListSectionView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy) NSString *title;
@end



@implementation BTProductListSectionView

-(void)awakeFromNib {
    
    [super awakeFromNib];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.bounds = CGRectMake(0, 0, kBTScreenWidth, 44);
}

+ (BTProductListSectionView *)createSectionViewWithTitle:(NSString *)title {
    
    BTProductListSectionView *item = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
    item.titleLabel.text = title;
    return item;
}

@end
