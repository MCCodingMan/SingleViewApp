//
//  MCVideoContentView.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/8.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCVideoContentView.h"
#import "MCVideoViewModel.h"

@implementation MCVideoContentView {
    MCVideoViewModel *_dataModel;
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

- (void)initSomeSetting {
    self.backGroundImage = MC_ImageWithName(@"bg_pic_001");
}

- (void)initDataModel{
    _dataModel = [[MCVideoViewModel alloc] init];
    [self queryData];
}

- (void)initTableView{
    [self addSubview:self.videoPlayTableView];
    [self.videoPlayTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self);
    }];
}

- (void)initNotificaion {
    [MC_NotificationCenter addObserver:self selector:@selector(queryData) name:@"MCVideoRefresh" object:nil];
}

- (void)queryData {
    MC_Weak_Self(self);
    [_dataModel queryJockesWithType:5 page:1 success:^{
        [weakself.videoPlayTableView.mj_header endRefreshing];
        [weakself.videoPlayTableView.mj_footer endRefreshing];
        [weakself.videoPlayTableView reloadData];
    } faile:^{
        
    }];
}

- (UITableView *)videoPlayTableView {
    if (!_videoPlayTableView) {
        _videoPlayTableView = [[UITableView alloc] init];
        _videoPlayTableView.backgroundColor = [UIColor clearColor];
        _videoPlayTableView.estimatedRowHeight = 150;
        _videoPlayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _videoPlayTableView.delegate = _dataModel;
        _videoPlayTableView.dataSource = _dataModel;
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:_dataModel refreshingAction:@selector(headerRefresh)];
        [header setImages:@[MC_ImageWithName(@"icon_pic_015"),
                            MC_ImageWithName(@"icon_pic_016"),
                            MC_ImageWithName(@"icon_pic_017"),
                            MC_ImageWithName(@"icon_pic_018"),
                            MC_ImageWithName(@"icon_pic_019")] forState:MJRefreshStateRefreshing];
        _videoPlayTableView.mj_header = header;
        MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:_dataModel refreshingAction:@selector(footerRefresh)];
        [footer setImages:@[MC_ImageWithName(@"icon_pic_006"),
                            MC_ImageWithName(@"icon_pic_007"),
                            MC_ImageWithName(@"icon_pic_008"),
                            MC_ImageWithName(@"icon_pic_009"),
                            MC_ImageWithName(@"icon_pic_010")] forState:MJRefreshStateRefreshing];
        _videoPlayTableView.mj_footer = footer;
    }
    return _videoPlayTableView;
}

-(void)dealloc {
    [MC_NotificationCenter removeObserver:self forKeyPath:@"MCVideoRefresh"];
}

@end
