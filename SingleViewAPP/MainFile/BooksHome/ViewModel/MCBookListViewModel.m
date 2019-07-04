//
//  MCBookListViewModel.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/14.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookListViewModel.h"
#import "MCQueryCategoriesBooksResponse.h"
#import "MCBookListCell.h"

@interface MCBookListViewModel()

@property (nonatomic, strong) MCQueryCategoriesBooksResponse *bookListResponse;

@end

@implementation MCBookListViewModel

- (instancetype)init {
    if (self = [super init]) {
        _listRequest = [[MCQueryCategoriesBooksListRequest alloc] init];
    }
    return self;
}

- (void)queryCategoriesBooksList:(void(^)(void))complete faile:(void(^)(void))faile {
    [MC_NetWorkRequest queryCategoriesBookListWithRequst:self.listRequest CompletionBlock:^(id  _Nonnull result) {
        self.bookListResponse = [[MCQueryCategoriesBooksResponse alloc] init];
        [self.bookListResponse decode:result];
        complete();
    } faileBlock:^(NSError * _Nonnull error) {
        faile();
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookListResponse.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MCBookListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MCBookListCell class])];
    if (!cell) {
        cell = [[MCBookListCell alloc] init];
    }
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
    [cell initBookListInfoWithModel:self.bookListResponse.books[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.jumpCommand execute:self.bookListResponse.books[indexPath.row]._id];
}

- (void)footerRefresh {
    if (self.bookListResponse.books.count != _bookListResponse.total) {
        if (self.listRequest.limit + 20 >= _bookListResponse.total) {
            self.listRequest.limit += _bookListResponse.total;
        }else{
            self.listRequest.limit += 20;
        }
        [self queryCategoriesBooksList:^{
            [self.refreshCellCommand execute:nil];
        } faile:^{
            
        }];
    }
}

@end
