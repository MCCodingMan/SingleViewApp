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
        [self initSomeSetting];
        [self initDataModel];
        [self initTableView];
        [self initNotification];
    }
    return self;
}

/**
 初始化设置
 */
- (void)initSomeSetting {
    self.backGroundImage = MC_ImageWithName(@"bg_pic_001");
}

/**
 初始化ViewModel
 */
- (void)initDataModel {
    _dataModel = [[MCJockesViewModel alloc] init];
    [self refreshData];
}

/**
 初始化tableView
 */
- (void)initTableView {
    [self addSubview:self.textTableView];
    [self.textTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}

/**
 注册通知
 */
- (void)initNotification {
    [MC_NotificationCenter addObserver:self selector:@selector(refreshData) name:@"MCRefreshTableView" object:nil];
}

#pragma mark -- 懒加载

/**
 懒加载

 @return textTableView
 */
- (UITableView *)textTableView {
    if (!_textTableView) {
        _textTableView = [[UITableView alloc] init];
        _textTableView.backgroundColor = [UIColor clearColor];
        _textTableView.estimatedRowHeight = 80;
        _textTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _textTableView.delegate = _dataModel;
        _textTableView.dataSource = _dataModel;
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:_dataModel refreshingAction:@selector(headerRefresh)];
        [header setImages:@[MC_ImageWithName(@"icon_pic_015"),
                            MC_ImageWithName(@"icon_pic_016"),
                            MC_ImageWithName(@"icon_pic_017"),
                            MC_ImageWithName(@"icon_pic_018"),
                            MC_ImageWithName(@"icon_pic_019")] forState:MJRefreshStateRefreshing];
        _textTableView.mj_header = header;
        MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:_dataModel refreshingAction:@selector(footerRefresh)];
        [footer setImages:@[MC_ImageWithName(@"icon_pic_006"),
                            MC_ImageWithName(@"icon_pic_007"),
                            MC_ImageWithName(@"icon_pic_008"),
                            MC_ImageWithName(@"icon_pic_009"),
                            MC_ImageWithName(@"icon_pic_010")] forState:MJRefreshStateRefreshing];
        _textTableView.mj_footer = footer;
    }
    return _textTableView;
}


/**
 刷新
 */
- (void)refreshData {
    MC_Weak_Self(self);
    [_dataModel queryJockesWithType:2 page:1 success:^{
        [weakself.textTableView.mj_header endRefreshing];
        [weakself.textTableView.mj_footer endRefreshing];
        [weakself.textTableView reloadData];
    } faile:^{
        
    }];
}

/**
 释放
 */
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"MCRefreshTableView"];
}


@end
