//
//  MCAllContentView.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/8.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCAllContentView.h"
#import "MCAllViewModel.h"

@implementation MCAllContentView {
    MCAllViewModel *_dataModel;
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
    _dataModel = [[MCAllViewModel alloc] init];
    [self queryData];
}

- (void)initTableView {
    [self addSubview:self.allTableView];
    
    [self.allTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self);
    }];
}

- (void)queryData {
    MC_Weak_Self(self);
    [self startLoadingView];
    [_dataModel queryJockesWithType:1 page:1 success:^{
        [weakself.allTableView.mj_header endRefreshing];
        [weakself.allTableView.mj_footer endRefreshing];
        [weakself.allTableView reloadData];
        [self stopLoadingView];
    } faile:^{
        [self stopLoadingView];
    }];
}

- (void)initNotificaion {
    [MC_NotificationCenter addObserver:self selector:@selector(queryData) name:@"MCAllRefresh" object:nil];
}

- (UITableView *)allTableView {
    if (!_allTableView) {
        _allTableView = [[UITableView alloc] init];
        _allTableView.backgroundColor = [UIColor clearColor];
        _allTableView.estimatedRowHeight = 80;
        _allTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _allTableView.delegate = _dataModel;
        _allTableView.dataSource = _dataModel;
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:_dataModel refreshingAction:@selector(headerRefresh)];
        [header setImages:@[MC_ImageWithName(@"icon_pic_015"),
                            MC_ImageWithName(@"icon_pic_016"),
                            MC_ImageWithName(@"icon_pic_017"),
                            MC_ImageWithName(@"icon_pic_018"),
                            MC_ImageWithName(@"icon_pic_019")] forState:MJRefreshStateRefreshing];
        _allTableView.mj_header = header;
        MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:_dataModel refreshingAction:@selector(footerRefresh)];
        [footer setImages:@[MC_ImageWithName(@"icon_pic_006"),
                            MC_ImageWithName(@"icon_pic_007"),
                            MC_ImageWithName(@"icon_pic_008"),
                            MC_ImageWithName(@"icon_pic_009"),
                            MC_ImageWithName(@"icon_pic_010")] forState:MJRefreshStateRefreshing];
        _allTableView.mj_footer = footer;
    }
    return _allTableView;
}

- (void)dealloc {
    [MC_NotificationCenter removeObserver:self forKeyPath:@"MCAllRefresh"];
}

@end
