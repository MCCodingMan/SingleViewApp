//
//  MCGifContentView.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/8.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCGifContentView.h"
#import "MCGifViewModel.h"

@implementation MCGifContentView {
    MCGifViewModel *_dataModel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSomeSetting];
        [self initDataModel];
        [self initTableView];
        [self initNotificaion];
    }
    return self;
}

/**
 初始化设置
 */
- (void)initSomeSetting {
    self.backGroundImage = MC_ImageWithName(@"bg_pic_001");
}

- (void)initDataModel {
    _dataModel = [[MCGifViewModel alloc] init];
    [self queryData];
}

- (void)initTableView {
    [self addSubview:self.gifTableView];
    [self.gifTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self);
    }];
}

- (void)queryData {
    MC_Weak_Self(self);
    [_dataModel queryJockesWithType:4 page:1 success:^{
        [weakself.gifTableView.mj_header endRefreshing];
        [weakself.gifTableView.mj_footer endRefreshing];
        [weakself.gifTableView reloadData];
    } faile:^{
        
    }];
}

- (void)initNotificaion {
    [MC_NotificationCenter addObserver:self selector:@selector(queryData) name:@"MCGifRefresh" object:nil];
}

- (UITableView *)gifTableView {
    if (!_gifTableView) {
        _gifTableView = [[UITableView alloc] init];
        _gifTableView.backgroundColor = [UIColor clearColor];
        _gifTableView.estimatedRowHeight = 150;
        _gifTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _gifTableView.delegate = _dataModel;
        _gifTableView.dataSource = _dataModel;
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:_dataModel refreshingAction:@selector(headerRefresh)];
        [header setImages:@[MC_ImageWithName(@"icon_pic_015"),
                            MC_ImageWithName(@"icon_pic_016"),
                            MC_ImageWithName(@"icon_pic_017"),
                            MC_ImageWithName(@"icon_pic_018"),
                            MC_ImageWithName(@"icon_pic_019")] forState:MJRefreshStateRefreshing];
        _gifTableView.mj_header = header;
        MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:_dataModel refreshingAction:@selector(footerRefresh)];
        [footer setImages:@[MC_ImageWithName(@"icon_pic_006"),
                            MC_ImageWithName(@"icon_pic_007"),
                            MC_ImageWithName(@"icon_pic_008"),
                            MC_ImageWithName(@"icon_pic_009"),
                            MC_ImageWithName(@"icon_pic_010")] forState:MJRefreshStateRefreshing];
        _gifTableView.mj_footer = footer;
    }
    return _gifTableView;
}

- (void)dealloc {
    [MC_NotificationCenter removeObserver:self forKeyPath:@"MCGifRefresh"];
}

@end
