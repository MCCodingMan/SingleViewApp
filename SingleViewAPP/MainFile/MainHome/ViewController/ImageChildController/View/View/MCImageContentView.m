//
//  MCImageContentView.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/4.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCImageContentView.h"
#import "MCImageViewModel.h"

@implementation MCImageContentView {
    MCImageViewModel *_dataModel;
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
    _dataModel = [[MCImageViewModel alloc] init];
    [self queryData];
}

- (void)initTableView {
    [self addSubview:self.imageTableView];
    [self.imageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self);
    }];
}

- (void)queryData {
    MC_Weak_Self(self);
    [_dataModel queryJockesWithType:3 page:1 success:^{
        [weakself.imageTableView.mj_header endRefreshing];
        [weakself.imageTableView.mj_footer endRefreshing];
        [weakself.imageTableView reloadData];
    } faile:^{
        
    }];
}

- (void)initNotificaion {
    [MC_NotificationCenter addObserver:self selector:@selector(queryData) name:@"MCImageRefresh" object:nil];
}

- (UITableView *)imageTableView {
    if (!_imageTableView) {
        _imageTableView = [[UITableView alloc] init];
        _imageTableView.backgroundColor = [UIColor clearColor];
        _imageTableView.estimatedRowHeight = 150;
        _imageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _imageTableView.delegate = _dataModel;
        _imageTableView.dataSource = _dataModel;
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:_dataModel refreshingAction:@selector(headerRefresh)];
        [header setImages:@[MC_ImageWithName(@"icon_pic_015"),
                            MC_ImageWithName(@"icon_pic_016"),
                            MC_ImageWithName(@"icon_pic_017"),
                            MC_ImageWithName(@"icon_pic_018"),
                            MC_ImageWithName(@"icon_pic_019")] forState:MJRefreshStateRefreshing];
        _imageTableView.mj_header = header;
        MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:_dataModel refreshingAction:@selector(footerRefresh)];
        [footer setImages:@[MC_ImageWithName(@"icon_pic_006"),
                            MC_ImageWithName(@"icon_pic_007"),
                            MC_ImageWithName(@"icon_pic_008"),
                            MC_ImageWithName(@"icon_pic_009"),
                            MC_ImageWithName(@"icon_pic_010")] forState:MJRefreshStateRefreshing];
        _imageTableView.mj_footer = footer;
    }
    return _imageTableView;
}

-(void)dealloc {
    [self removeObserver:self forKeyPath:@"MCImageRefresh"];
}

@end
