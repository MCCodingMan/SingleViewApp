//
//  MCTextContentView.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCTextContentView.h"
#import "MCJockesViewModel.h"

@interface MCTextContentView()

@end

@implementation MCTextContentView {
    MCJockesViewModel *_dataModel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initDataModel];
        [self initTableView];
    }
    return self;
}

- (void)initDataModel {
    MC_Weak_Self(self);
    _dataModel = [[MCJockesViewModel alloc] init];
    [_dataModel queryJockes:^{
        [weakself.textTableView reloadData];
    } faile:^{
        
    }];
}

- (void)initTableView {
    [self addSubview:self.textTableView];
    [self.textTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}

- (UITableView *)textTableView {
    if (!_textTableView) {
        _textTableView = [[UITableView alloc] init];
        _textTableView.estimatedRowHeight = 80;
        _textTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _textTableView.delegate = _dataModel;
        _textTableView.dataSource = _dataModel;
    }
    return _textTableView;
}



@end
