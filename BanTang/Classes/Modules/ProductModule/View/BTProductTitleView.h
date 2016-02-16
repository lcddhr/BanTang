//
//  BTProductTitleView.h
//  BanTang
//
//  Created by lovelydd on 16/2/16.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^BTProductTitleViewDidSelectedBlock)(NSInteger index);

@interface BTProductTitleView : UIView


- (instancetype)initWithTitles:(NSArray *)titles selectedBlock:(BTProductTitleViewDidSelectedBlock)block;

+ (instancetype)createTitleViewWithSelectedBlock:(BTProductTitleViewDidSelectedBlock)block;
@end
