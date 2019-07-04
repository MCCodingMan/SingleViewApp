//
//  MCPlayView.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/8.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCPlayView : UIView

@property (nonatomic, strong, readonly) UIImageView *coverImageView;
@property (nonatomic, strong, readonly) UIButton *playButton;
@property (nonatomic, copy, nullable) void(^clickedPlayButtonExeBlock)(MCPlayView *view);

@end

NS_ASSUME_NONNULL_END
