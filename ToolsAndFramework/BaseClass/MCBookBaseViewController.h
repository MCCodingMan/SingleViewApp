//
//  MCBookBaseViewController.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/17.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCBookBaseViewController : UIViewController

@property (nonatomic, strong) UIImage *backGroundImage;

- (void)startLoadingView;

- (void)stopLoadingView;

@end

NS_ASSUME_NONNULL_END
