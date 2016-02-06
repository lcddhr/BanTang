//
//  UIFont+Extend.m
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import "UIFont+Extend.h"

static NSString * const  kDDDefaultFontName = @"HelveticaNeue-Light";
static CGFloat kDDDefaultFontSize = 12.0f;

@implementation UIFont (Extend)

+(UIFont *)dd_defaultFont {
    
    
    return [UIFont fontWithName:kDDDefaultFontName size:kDDDefaultFontSize];
}

+(UIFont *)dd_fontName:(NSString *)name size:(CGFloat)size {
    
    return [UIFont fontWithName:name size:size];
}
@end
