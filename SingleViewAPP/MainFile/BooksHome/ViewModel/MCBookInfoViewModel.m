//
//  MCBookInfoViewModel.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/20.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookInfoViewModel.h"
#import "MCBookInfoResponse.h"
#import "MCBookChapterResponse.h"
#import "MCBookListCell.h"
#import "MCBookSourceCell.h"
#import "MCBookSourceList.h"

@interface MCBookInfoViewModel()

@property (nonatomic, strong) MCBookInfoResponse *bookInfoResponse;

@property (nonatomic, strong) NSMutableArray<MCBookSourceList *> *bookSourceArr;

@end

@implementation MCBookInfoViewModel

- (void)queryBookInfoWithBookId:(NSString *)bookId success:(void(^)(void))complete faile:(void(^)(void))faile {
    MC_Weak_Self(self);
    [MC_NetWorkRequest queryBookInfoWithBookID:bookId CompletionBlock:^(id  _Nonnull result) {
        weakself.bookInfoResponse = [[MCBookInfoResponse alloc] init];
        [weakself.bookInfoResponse decode:result];
        complete();
    } faileBlock:^(NSError * _Nonnull error) {
        faile();
    }];
}

- (void)queryBookSourceWithBookId:(NSString *)bookId success:(void(^)(void))complete faile:(void(^)(void))faile {
    MC_Weak_Self(self);
    [MC_NetWorkRequest queryBookSourceWithBookID:bookId CompletionBlock:^(id  _Nonnull result) {
        weakself.bookSourceArr = [[NSMutableArray alloc] init];
        NSArray *resultArr = [NSArray arrayWithArray:result];
        for (int i = 0; i < resultArr.count; i++) {
            MCBookSourceList *sourceList = [[MCBookSourceList alloc] init];
            [sourceList decode:resultArr[i]];
            [weakself.bookSourceArr addObject:sourceList];
        }
        complete();
    } faileBlock:^(NSError * _Nonnull error) {
        faile();
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 8;
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 30;
    }else{
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UILabel *title = [[UILabel alloc] init];
        title.text = @"书籍来源";
        title.font = [UIFont systemFontOfSize:16];
        title.textAlignment = NSTextAlignmentCenter;
        title.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
        return title;
    }else{
        return [[UIView alloc] init];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return self.bookSourceArr.count;
            break;
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MCBookListCell *cell = [[MCBookListCell alloc] init];
            cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
            if (self.bookInfoResponse) {
                [cell initBookChapterInfoWithModel:self.bookInfoResponse];
            }
            return cell;
        }else{
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
            UILabel *descpriteLabel = [[UILabel alloc] init];
            descpriteLabel.text = self.bookInfoResponse.longIntro;
            descpriteLabel.font = [UIFont systemFontOfSize:14];
            descpriteLabel.numberOfLines = 0;
            [cell addSubview:descpriteLabel];
            [descpriteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell).offset(20);
                make.right.equalTo(cell).offset(-20);
                make.top.equalTo(cell).offset(8);
                make.bottom.equalTo(cell).offset(-8);
            }];
            return cell;
        }
    }else if (indexPath.section == 1) {
        MCBookSourceCell *cell = [[MCBookSourceCell alloc] init];
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
        [cell initDataWithSourceModel:self.bookSourceArr[indexPath.row]];
        return cell;
    }else{
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 1) {
        [self.jumpCommand execute:self.bookSourceArr[indexPath.row]._id];
    }
}

@end
