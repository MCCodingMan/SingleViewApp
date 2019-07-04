//
//  MCBooksHomeViewController.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/13.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBooksHomeViewController.h"
#import "MCBookViewModel.h"
#import "MCBookListViewController.h"

@interface MCBooksHomeViewController ()

@end

@implementation MCBooksHomeViewController {
    MCBookViewModel *_baseDataModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMainView];
    [self initNavigation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)addMainView {
    self.title = @"分类";
    [self initSomeSetting];
}

- (void)initSomeSetting {
    MC_Weak_Self(self);
    self.backGroundImage = MC_ImageWithName(@"bg_pic_001");
    _baseDataModel = [[MCBookViewModel alloc] init];
    _baseDataModel.selectCellCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [weakself.mainLeftTableView reloadData];
        [weakself.mainRightTableView reloadData];
        return [RACSignal empty];
    }];
    _baseDataModel.jumpCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [weakself jumpToBookListViewController];
        return [RACSignal empty];
    }];
    [self initTabelView];
    [self initDataModel];
}

- (void)initDataModel {
    MC_Weak_Self(self);
    [self startLoadingView];
    [UIView showWarningMessageWithString:@"正在获取分类详情..."];
    [_baseDataModel queryCategories:^{
        [weakself stopLoadingView];
        [weakself.mainLeftTableView reloadData];
        [weakself.mainRightTableView reloadData];
    } faile:^{
        [weakself stopLoadingView];
        [UIView showWarningMessageWithString:@"获取分类详情失败"];
    }];
}

- (void)initTabelView {
    MC_Weak_Self(self);
    [self.view addSubview:self.mainLeftTableView];
    [self.mainLeftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(weakself.view);
        make.width.mas_equalTo(MC_SCREEN_WIDTH * 0.4);
    }];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = MC_COLOR_HEX(0xF5F5F5);
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mainLeftTableView.mas_right);
        make.top.bottom.equalTo(weakself.view);
        make.width.mas_equalTo(1);
    }];
    [self.view addSubview:self.mainRightTableView];
    [self.mainRightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(weakself.view);
        make.left.equalTo(lineView.mas_right);
    }];
}

- (UITableView *)mainLeftTableView {
    if (!_mainLeftTableView) {
        _mainLeftTableView = [[UITableView alloc] init];
        _mainLeftTableView.delegate = _baseDataModel;
        _mainLeftTableView.dataSource = _baseDataModel;
        _mainLeftTableView.tag = 101;
        _mainLeftTableView.rowHeight = 60;
        _mainLeftTableView.backgroundColor = [UIColor whiteColor];
        _mainLeftTableView.tableFooterView = [[UIView alloc] init];
    }
    return  _mainLeftTableView;
}

-(UITableView *)mainRightTableView {
    if (!_mainRightTableView) {
        _mainRightTableView = [[UITableView alloc] init];
        _mainRightTableView.delegate = _baseDataModel;
        _mainRightTableView.dataSource = _baseDataModel;
        _mainRightTableView.tag = 102;
        _mainRightTableView.rowHeight = 60;
        _mainRightTableView.backgroundColor = [UIColor whiteColor];
        _mainRightTableView.tableFooterView = [[UIView alloc] init];
    }
    return _mainRightTableView;
}

- (void)initNavigation {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"icon_pic_jock"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)jumpToBookListViewController {
    MCBookListViewController *listVC = [[MCBookListViewController alloc] init];
    listVC.baseDataModel.listRequest = _baseDataModel.listRequest;
    [self.navigationController pushViewController:listVC animated:YES];
}


@end
