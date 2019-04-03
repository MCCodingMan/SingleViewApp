//
//  UIView+Warning.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/2.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Warning)

/**
 提示⚠️框
 
 @param warningString 警告文案
 */
+ (void)showWarningMessageWithString:(NSString *)warningString;

@end

NS_ASSUME_NONNULL_END
