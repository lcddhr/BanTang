//
//  BTProductMenuItemCell.h
//  BanTang
//
//  Created by lovelydd on 16/2/15.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTProductMenuItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *popularityCount;

+ (NSString *)cellIdentifier;

+ (NSString *)nibName;

+ (BTProductMenuItemCell *)createMenuItemCell;
@end
