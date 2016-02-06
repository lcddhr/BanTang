//
//  UIImageView+SDWebImage_M13ProgressSuite.h
//  testSDWebImageWithProgress
//
//  Created by Jowyer on 14-6-3.
//  Copyright (c) 2014年 jo2studio. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "M13ProgressViewRing.h"

@interface UIImageView (SDWebImage_M13ProgressSuite)

- (void)setImageUsingProgressViewRingWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock ProgressPrimaryColor:(UIColor *)pColor ProgressSecondaryColor:(UIColor *)sColor Diameter:(float)diameter;
//- (void)removeProgressViewRing;

@end
