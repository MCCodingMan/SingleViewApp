//
//  MCBookViewModel.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/13.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookViewModel.h"
#import "MCQueryCategoriesResponse.h"

@interface MCBookViewModel()
@property (nonatomic, assign) NSInteger selectIndex;
@end

@implementation MCBookViewModel {
    MCQueryCategoriesResponse *_categoriesResponse;
}

-(instancetype)init {
    if (self = [super init]) {
        _listRequest = [[MCQueryCategoriesBooksListRequest alloc] init];
        [self RACSelectIndexObserve];
    }
    return self;
}

- (void)queryCategories:(void(^)(void))complete faile:(void(^)(void))faile {
    self.selectIndex = 0;
    [MC_NetWorkRequest queryCategoriesWithCompletionBlock:^(id  _Nonnull result) {
        self->_categoriesResponse = [[MCQueryCategoriesResponse alloc] init];
        [self->_categoriesResponse decode:result];
        NSLog(@"请求成功");
        complete();
    } faileBlock:^(NSError * _Nonnull error) {
        NSLog(@"请求失败");
        faile();
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (tableView.tag) {
        case 101:
            return 4;
            break;
        default:
            switch (_selectIndex) {
                case 0:
                    return _categoriesResponse.male.count;
                    break;
                case 1:
                    return _categoriesResponse.female.count;
                    break;
                case 2:
                    return _categoriesResponse.picture.count;
                    break;
                default:
                    return _categoriesResponse.press.count;
                    break;
            }
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14];
    if (tableView.tag == 101) {
        switch (indexPath.row) {
            case 0:
                titleLabel.text = @"男生";
                break;
            case 1:
                titleLabel.text = @"女生";
                break;
            case 2:
                titleLabel.text = @"图书";
                break;
            default:
                titleLabel.text = @"新闻";
                break;
        }
        if (_selectIndex == indexPath.row) {
            titleLabel.textColor = [UIColor blueColor];
        }
    }else{
        switch (_selectIndex) {
            case 0:
                titleLabel.text = _categoriesResponse.male[indexPath.row].name;
                break;
            case 1:
                titleLabel.text = _categoriesResponse.female[indexPath.row].name;
                break;
            case 2:
                titleLabel.text = _categoriesResponse.picture[indexPath.row].name;
                break;
            default:
                titleLabel.text = _categoriesResponse.press[indexPath.row].name;
                break;
        }
    }
    [cell addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(cell);
    }];
    return cell;
}

- (void)RACSelectIndexObserve {
    [[self rac_valuesAndChangesForKeyPath:@"selectIndex" options:NSKeyValueObservingOptionNew observer:self] subscribeNext:^(RACTuple *x) {
        switch ([x[1][@"new"] intValue]) {
            case 0:
                self.listRequest.gender = @"male";
                break;
            case 1:
                self.listRequest.gender = @"female";
                break;
            case 2:
                self.listRequest.gender = @"picture";
                break;
            default:
                self.listRequest.gender = @"press";
                break;
        }
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (tableView.tag == 101) {
        self.selectIndex = indexPath.row;
        [self.selectCellCommand execute:nil];
    }else{
        switch (_selectIndex) {
            case 0:
                self.listRequest.major = _categoriesResponse.male[indexPath.row].name;
                break;
            case 1:
                self.listRequest.major = _categoriesResponse.female[indexPath.row].name;
                break;
            case 2:
                self.listRequest.major = _categoriesResponse.picture[indexPath.row].name;
                break;
            default:
                self.listRequest.major = _categoriesResponse.press[indexPath.row].name;
                break;
        }
        [self.jumpCommand execute:nil];
    }
}

@end
