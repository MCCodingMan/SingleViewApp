//
//  MCBookListViewController.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/17.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookListViewController.h"
#import "MCBookListCell.h"
#import "MCBookInfoViewController.h"

@interface MCBookListViewController ()

@end

@implementation MCBookListViewController

- (instancetype)init {
    if (self = [super init]) {
        _baseDataModel = [[MCBookListViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSomeSetting];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)initSomeSetting {
    self.backGroundImage = MC_ImageWithName(@"bg_pic_001");
    self.title = @"列表";
    MC_Weak_Self(self);
    _baseDataModel.jumpCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *input) {
        [weakself jumpToBookInfoController:input];
        return [RACSignal empty];
    }];
    _baseDataModel.refreshCellCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [weakself.bookListTableView reloadData];
        return [RACSignal empty];
    }];
    [self initTabelView];
    [self initDataModel];
}

- (void)initDataModel {
    MC_Weak_Self(self);
    [self startLoadingView];
    [UIView showWarningMessageWithString:@"正在获取书籍列表..."];
    [_baseDataModel queryCategoriesBooksList:^{
        [self stopLoadingView];
        [weakself.bookListTableView reloadData];
    } faile:^{
        [self stopLoadingView];
        [UIView showWarningMessageWithString:@"获取书籍列表失败"];
    }];
}

- (void)initTabelView {
    MC_Weak_Self(self);
    [self.view addSubview:self.bookListTableView];
    [self.bookListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(weakself.view);
        make.left.equalTo(weakself.view);
    }];
}

-(UITableView *)bookListTableView {
    if (!_bookListTableView) {
        _bookListTableView = [[UITableView alloc] init];
        _bookListTableView.delegate = _baseDataModel;
        _bookListTableView.dataSource = _baseDataModel;
        _bookListTableView.estimatedRowHeight = 180;
        _bookListTableView.rowHeight = UITableViewAutomaticDimension;
        _bookListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bookListTableView.backgroundColor = [UIColor clearColor];
        _bookListTableView.tableFooterView = [[UIView alloc] init];
        MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:_baseDataModel refreshingAction:@selector(footerRefresh)];
        [footer setImages:@[MC_ImageWithName(@"icon_pic_006"),
                            MC_ImageWithName(@"icon_pic_007"),
                            MC_ImageWithName(@"icon_pic_008"),
                            MC_ImageWithName(@"icon_pic_009"),
                            MC_ImageWithName(@"icon_pic_010")] forState:MJRefreshStateRefreshing];
        _bookListTableView.mj_footer = footer;
        [_bookListTableView registerClass:[MCBookListCell class] forCellReuseIdentifier:NSStringFromClass([MCBookListCell class])];
    }
    return _bookListTableView;
}

- (void)jumpToBookInfoController:(NSString *)bookID {
    MCBookInfoViewController *bookInfoVC = [[MCBookInfoViewController alloc] init];
    bookInfoVC.bookID = bookID;
    [self.navigationController pushViewController:bookInfoVC animated:YES];
}

@end
