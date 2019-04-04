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
    NSMutableArray<NSMutableArray *> *tableViewDataArr;
    NSString *mainTabBarStatus;
}

- (instancetype)init {
    if (self = [super init]) {
        tableViewDataArr = [[NSMutableArray alloc] init];
        mainTabBarStatus = @"";
    }
    return self;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableViewDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArr[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MCTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MCTextTableViewCell class])];
    if (!cell) {
        cell = [[MCTextTableViewCell alloc] init];
    }
    cell.backgroundColor = [UIColor clearColor];
    if (tableViewDataArr.count >= indexPath.section + 1 && tableViewDataArr[indexPath.section].count >= indexPath.row + 1) {
        cell.dataModel = tableViewDataArr[indexPath.section][indexPath.row];
    }
    return cell;
}

#pragma mark -- Network

/**
 查询网络请求

 @param type 类型 1:全部 2:text 3：图片 4:GIF 5:Video
 @param page 页数
 @param complete 成功回调
 @param fail 失败回调
 */
- (void)queryJockesWithType:(int)type page:(int)page success:(void(^)(void))complete faile:(void(^)(void))fail {
    MC_Weak_Self(self);
    [MC_NetWorkRequest queryJockesWithType:type page:page completionBlock:^(id  _Nonnull result) {
        weakself.jockeResponse = [[MCQueryJockesResultResponse alloc] init];
        [weakself.jockeResponse decode:result];
        [self->tableViewDataArr addObject:weakself.jockeResponse.data];
        complete();
    } faileBlock:^(NSError * _Nonnull error) {
        NSLog(@"请求失败");
        fail();
    }];
}

- (void)headerRefresh {
    [tableViewDataArr removeAllObjects];
    MC_PostNotification(@"MCRefreshTableView", nil, nil);
}

- (void)footerRefresh {
    MC_PostNotification(@"MCRefreshTableView", nil, nil);
}




@end
