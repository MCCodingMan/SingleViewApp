//
//  UIView+Warning.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/2.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "UIView+Warning.h"

@implementation UIView (Warning)

/**
 提示⚠️框

 @param warningString 警告文案
 */
+ (void)showWarningMessageWithString:(NSString *)warningString {
    UILabel *warningLabel = [[UILabel alloc] init];
    warningLabel.backgroundColor = [UIColor blackColor];
    warningLabel.textColor = [UIColor whiteColor];
    warningLabel.text = MC_String_StringFormat(@"   %@   ",warningString);
    warningLabel.font = MC_UIFont(14);
    warningLabel.alpha = 0;
    MC_ViewRadius(warningLabel, 12.5);
    [MC_KeyWindow addSubview:warningLabel];
    [warningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(MC_KeyWindow);
        make.height.mas_equalTo(25);
        make.bottom.equalTo(MC_KeyWindow).offset(-50);
    }];
    [UIView animateWithDuration:1 animations:^{
        warningLabel.alpha = 1;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1 animations:^{
                warningLabel.alpha = 0;
            } completion:^(BOOL finished) {
                [warningLabel removeFromSuperview];
            }];
        });
    }];
}

@end
