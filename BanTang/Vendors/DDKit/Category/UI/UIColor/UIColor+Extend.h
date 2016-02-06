//
//  UIColor+Extend.h
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DDRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.]
@interface UIColor (Extend)

+ (UIColor *)dd_hexFloatColor:(NSString *)hexStr;
@end
