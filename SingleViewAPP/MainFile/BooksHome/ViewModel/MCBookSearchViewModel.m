//
//  MCBookSearchViewModel.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/28.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookSearchViewModel.h"
#import "MCBookCompleteResponse.h"
#import "MCBookSearchResponse.h"
#import "MCBookListCell.h"

@interface MCBookSearchViewModel()

@property (nonatomic, strong) MCBookCompleteResponse *completeResponse;

@property (nonatomic, strong) MCBookSearchResponse *searchBookResponse;

@end

@implementation MCBookSearchViewModel

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    MC_Weak_Self(self);
    [MC_NetWorkRequest queryCompleteNameWithKeyWord:searchText CompletionBlock:^(id  _Nonnull result) {
        weakself.completeResponse = [[MCBookCompleteResponse alloc] init];
        [weakself.completeResponse decode:result];
        MC_PostNotification(@"RefreshSearchFullTabelView", nil, nil);
    } faileBlock:^(NSError * _Nonnull error) {
        
    }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self querySearchBookNetwork:searchBar.text];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self querySearchBookNetwork:searchBar.text];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 101) {
        return self.completeResponse.keywords.count;
    }else{
        return self.searchBookResponse.books.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 101) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
        UILabel *descpriteLabel = [[UILabel alloc] init];
        descpriteLabel.text = self.completeResponse.keywords[indexPath.row];
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
    }else{
        MCBookListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MCBookListCell class])];
        if (!cell) {
            cell = [[MCBookListCell alloc] init];
        }
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
        [cell initBookSearchInfoWithModel:self.searchBookResponse.books[indexPath.row]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (tableView.tag == 101) {
        MC_PostNotification(@"RecyclingKeyBoard", nil, nil);
        [self querySearchBookNetwork:self.completeResponse.keywords[indexPath.row]];
    }else{
        MC_PostNotification(@"JumpToBookInfoController", nil, @{@"bookID":self.searchBookResponse.books[indexPath.row]._id});
    }
}

- (void)querySearchBookNetwork:(NSString *)searchText {
    MC_Weak_Self(self);
    [MC_NetWorkRequest querySearchNameWithKeyWord:searchText CompletionBlock:^(id  _Nonnull result) {
        weakself.searchBookResponse = [[MCBookSearchResponse alloc] init];
        [weakself.searchBookResponse decode:result];
        MC_PostNotification(@"RefreshSearchListTabelView", nil, nil);
    } faileBlock:^(NSError * _Nonnull error) {
        
    }];
}

@end
