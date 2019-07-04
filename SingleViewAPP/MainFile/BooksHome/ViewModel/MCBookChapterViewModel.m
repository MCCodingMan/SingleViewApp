//
//  MCBookChapterViewModel.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/20.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookChapterViewModel.h"
#import "MCBookChapterResponse.h"
#import "MCBookChapterCell.h"

@interface MCBookChapterViewModel()

@property (nonatomic, strong) MCBookChapterResponse *chapterResponse;

@end

@implementation MCBookChapterViewModel

- (void)queryBookChapterWithBookId:(NSString *)sourceId success:(void(^)(void))complete faile:(void(^)(void))faile {
    MC_Weak_Self(self);
    [MC_NetWorkRequest queryBookChapterWithSourceID:sourceId CompletionBlock:^(id  _Nonnull result) {
        weakself.chapterResponse = [[MCBookChapterResponse alloc] init];
        [weakself.chapterResponse decode:result];
        complete();
    } faileBlock:^(NSError * _Nonnull error) {
        faile();
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chapterResponse.chapters.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MCBookChapterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MCBookChapterCell class])];
    if (!cell) {
        cell = [[MCBookChapterCell alloc] init];
    }
    cell.sourceName.text = self.chapterResponse.chapters[indexPath.row].title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[self.chapterResponse,@(indexPath.row)]];
    [self.jumpCommand execute:tuple];
}

@end
