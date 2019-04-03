//
//  MCJockesViewModel.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCJockesViewModel.h"
#import "MCTextTableViewCell.h"

@implementation MCJockesViewModel {
    float currentContentOffsetY;
    NSString *mainTabBarStatus;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.jockeResponse.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MCTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MCTextTableViewCell class])];
    if (!cell) {
        cell = [[MCTextTableViewCell alloc] init];
    }
    cell.dataModel = self.jockeResponse.data[indexPath.row];
    return cell;
}

- (void)queryJockes:(void(^)(void))complete faile:(void(^)(void))fail {
    MC_Weak_Self(self);
    [MC_NetWorkRequest queryJockesWithType:2 page:1 completionBlock:^(id  _Nonnull result) {
        weakself.jockeResponse = [[MCQueryJockesResultResponse alloc] init];
        [weakself.jockeResponse decode:result];
        complete();
    } faileBlock:^(NSError * _Nonnull error) {
        NSLog(@"请求失败");
        fail();
    }];
}

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
