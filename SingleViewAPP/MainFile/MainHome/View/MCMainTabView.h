//
//  MCMainTabView.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/2.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMainHomeViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCMainTabView : UIView

//点击事件代理
@property (nonatomic, weak) id<MCMainTabViewDelegate>delegate;

/**
 初始化tabBarView
 */
- (void)initTabBarView;

@end

NS_ASSUME_NONNULL_END
