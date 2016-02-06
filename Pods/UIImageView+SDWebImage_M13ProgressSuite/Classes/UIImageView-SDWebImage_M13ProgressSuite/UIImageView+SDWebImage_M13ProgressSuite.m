//
//  UIImageView+SDWebImage_M13ProgressSuite.m
//  testSDWebImageWithProgress
//
//  Created by Jowyer on 14-6-3.
//  Copyright (c) 2014年 jo2studio. All rights reserved.
//

#import "UIImageView+SDWebImage_M13ProgressSuite.h"

#define TAG_PROGRESS_VIEW_RING 258369

@implementation UIImageView (SDWebImage_M13ProgressSuite)
#pragma mark- Private Methods
- (void)addProgressViewRingWithPrimaryColor:(UIColor *)pColor SecondaryColor:(UIColor *)sColor Diameter:(float)diameter
{
    M13ProgressViewRing *progressView = [[M13ProgressViewRing alloc] initWithFrame:CGRectMake((self.frame.size.width / 2.) - diameter / 2., (self.frame.size.height / 2.0) - diameter / 2., diameter, diameter)];
    progressView.primaryColor = pColor;
    progressView.secondaryColor = sColor;
    progressView.tag = TAG_PROGRESS_VIEW_RING;
    [self addSubview:progressView];
}

- (void)updateProgressViewRing:(CGFloat)progress
{
    M13ProgressViewRing *progressView = (M13ProgressViewRing *)[self viewWithTag:TAG_PROGRESS_VIEW_RING];
    if (progressView)
    {
        [progressView setProgress:progress animated:YES];
    }
}

- (void)removeProgressViewRing
{
    M13ProgressViewRing *progressView = (M13ProgressViewRing *)[self viewWithTag:TAG_PROGRESS_VIEW_RING];
    if (progressView)
    {
        [progressView removeFromSuperview];
    }
}

#pragma mark- Public Methods
- (void)setImageUsingProgressViewRingWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock ProgressPrimaryColor:(UIColor *)pColor ProgressSecondaryColor:(UIColor *)sColor Diameter:(float)diameter
{
    [self addProgressViewRingWithPrimaryColor:pColor SecondaryColor:sColor Diameter:diameter];
    
    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:url
            placeholderImage:placeholder
                     options:options
                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = ((CGFloat)receivedSize / (CGFloat)expectedSize);
        [weakSelf updateProgressViewRing:progress];
        if (progressBlock) {
            progressBlock(receivedSize, expectedSize);
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [weakSelf removeProgressViewRing];
        if (completedBlock) {
            completedBlock(image, error, cacheType, imageURL);
        }
    }];
}

@end
