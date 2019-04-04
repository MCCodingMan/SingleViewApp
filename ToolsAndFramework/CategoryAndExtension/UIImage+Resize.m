//
//  UIImage+Resize.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/4.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

- (UIImage *)resizableImageWithWidth:(float)width {
    CGFloat height = width * self.size.height / self.size.width;
    UIImage *newImage = nil;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = width;
    thumbnailRect.size.height = height;
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
