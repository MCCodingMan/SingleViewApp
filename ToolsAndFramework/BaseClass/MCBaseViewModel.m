//
//  MCBaseViewModel.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/4.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseViewModel.h"

@implementation MCBaseViewModel {
    float currentContentOffsetY;
    NSString *mainTabBarStatus;
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < currentContentOffsetY) {
        if (![mainTabBarStatus isEqualToString:@"DOWN"] && mainTabBarStatus) {
            MC_PostNotification(@"MCTabBarIsHidden", nil, @{@"MCDownOrUp":mainTabBarStatus});
        }
        mainTabBarStatus = @"DOWN";
    }else{
        if (![mainTabBarStatus isEqualToString:@"UP"] && mainTabBarStatus) {
            MC_PostNotification(@"MCTabBarIsHidden", nil, @{@"MCDownOrUp":mainTabBarStatus});
        }
        mainTabBarStatus = @"UP";
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    currentContentOffsetY = scrollView.contentOffset.y;
}

@end
