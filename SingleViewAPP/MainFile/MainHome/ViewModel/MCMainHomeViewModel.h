//
//  MCMainHomeViewModel.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/4.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MCMainTabViewDelegate <NSObject>

/**
 点击事件代理方法

 @param selectItem 跳转的item
 */
- (void)clickTabButtonChangeViewControllerWithTag:(NSInteger)selectItem;

@end

@interface MCMainHomeViewModel : NSObject

@end

NS_ASSUME_NONNULL_END
