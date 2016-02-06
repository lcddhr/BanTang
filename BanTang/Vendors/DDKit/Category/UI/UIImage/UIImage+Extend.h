//
//  UIImage+Extend.h
//  BanTang
//
//  Created by lovelydd on 16/2/2.
//  Copyright © 2016年 xiaomutou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extend)



/**
 *  根据颜色生成对应颜色的图片,默认是1*1
 *
 *  @param color 颜色
 *
 *  @return 处理后的图片
 */
+ (UIImage *)dd_imageWithColor:(UIColor *)color;



+ (UIImage *)dd_imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 *  把图片缩放到指定的大小
 *
 *  @param size 图片的大小
 *
 *  @return 处理后的图片
 */
+ (UIImage *)dd_scaleToSize:(CGSize)size;


/**
 *  生成屏幕的快照
 *
 *  @return 处理后的图片
 */
+ (UIImage *)dd_screenshot;




- (UIImage *)dd_cutImageWithRadius:(CGFloat)radius;

- (UIImage *)antiAlias;
@end
