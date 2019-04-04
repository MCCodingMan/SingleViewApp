//
//  MCBaseView.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/4.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseView.h"

@implementation MCBaseView

/**
 设置背景图片

 @param backGroundImage 背景图片
 */
- (void)setBackGroundImage:(UIImage *)backGroundImage {
    UIImageView *backGroundImageView = [[UIImageView alloc] initWithImage:backGroundImage];
    backGroundImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:backGroundImageView];
    [self sendSubviewToBack:backGroundImageView];
}

@end
