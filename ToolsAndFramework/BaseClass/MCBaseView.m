//
//  MCBaseView.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/4.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseView.h"
#import "MCLoadingView.h"

@interface MCBaseView()
@property (nonatomic, strong) MCLoadingView *loadBagroundView;
@end

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

- (MCLoadingView *)loadBagroundView {
    if (!_loadBagroundView) {
        _loadBagroundView = [[MCLoadingView alloc] initWithFrame:self.frame];
        [self addSubview:_loadBagroundView];
    }
    return _loadBagroundView;
}

- (void)startLoadingView {
    [self.loadBagroundView startLoadingAnimation];
}

- (void)stopLoadingView {
    [self.loadBagroundView stopLoadingAnimation];
    [self.loadBagroundView removeFromSuperview];
}

@end
