//
//  UILabel+Extend.m
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "UILabel+Extend.h"

@implementation UILabel (Extend)

- (CGFloat)YXY_labelHeightWithString:(NSString *)content {
    
    CGSize maximumLabelSize = CGSizeMake(self.bounds.size.width, CGFLOAT_MAX);
    
    CGSize size = [content boundingRectWithSize:maximumLabelSize
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{
                                                  NSFontAttributeName : [self font]
                                                  }
                                        context:nil].size;
    
    return size.height;
}
@end
