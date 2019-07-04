//
//  MCBookInfoViewController.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/20.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookInfoViewController.h"
#import "MCBookChapterListViewController.h"

@interface MCBookInfoViewController ()

@end

@implementation MCBookInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.title = @"详情";
    [self initTabelView];
    [self initDataModel];
    
}

- (void)initDataModel {
    MC_Weak_Self(self);
    [_dataInfoModel queryBookInfoWithBookId:_bookID success:^{
        [weakself.bookInfoTableView reloadData];
    } faile:^{
        
    }];
    [self startLoadingView];
    [UIView showWarningMessageWithString:@"正在获取书籍详情..."];
    [_dataInfoModel queryBookSourceWithBookId:_bookID success:^{
        [self stopLoadingView];
        [weakself.bookInfoTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    } faile:^{
        [self stopLoadingView];
        [UIView showWarningMessageWithString:@"获取书籍信息失败"];
    }];
}

- (void)initTabelView {
    MC_Weak_Self(self);
    _dataInfoModel = [[MCBookInfoViewModel alloc] init];
    _dataInfoModel.jumpCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *input) {
        [weakself jumpToBookInfoController:input];
        return [RACSignal empty];
    }];
    [self.view addSubview:self.bookInfoTableView];
    [self.bookInfoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(weakself.view);
        make.left.equalTo(weakself.view);
    }];
}

-(UITableView *)bookInfoTableView {
    if (!_bookInfoTableView) {
        _bookInfoTableView = [[UITableView alloc] init];
        _bookInfoTableView.delegate = _dataInfoModel;
        _bookInfoTableView.dataSource = _dataInfoModel;
        _bookInfoTableView.estimatedRowHeight = 33;
        _bookInfoTableView.rowHeight = UITableViewAutomaticDimension;
        _bookInfoTableView.backgroundColor = [UIColor clearColor];
    }
    return _bookInfoTableView;
}

- (void)jumpToBookInfoController:(NSString *)sourceID {
    MCBookChapterListViewController *chapterInfoVC = [[MCBookChapterListViewController alloc] init];
    chapterInfoVC.sourceID = sourceID;
    [self.navigationController pushViewController:chapterInfoVC animated:YES];
}

@end
