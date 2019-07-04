//
//  MCBookChapterListViewController.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/20.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookChapterListViewController.h"
#import "MCBookChapterCell.h"
#import "MCBookReadViewController.h"

@interface MCBookChapterListViewController ()

@end

@implementation MCBookChapterListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSomeSetting];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MC_NotificationCenter removeObserver:self];
}

- (void)initSomeSetting {
    self.backGroundImage = MC_ImageWithName(@"bg_pic_001");
    self.title = @"详情";
    [self initTabelView];
    [self initDataModel];
}

- (void)initDataModel {
    MC_Weak_Self(self);
    [self startLoadingView];
    [UIView showWarningMessageWithString:@"正在获取章节列表..."];
    [_chapterModel queryBookChapterWithBookId:_sourceID success:^{
        [self stopLoadingView];
        [weakself.bookChapterTableView reloadData];
    } faile:^{
        [self stopLoadingView];
        [UIView showWarningMessageWithString:@"获取章节信息失败"];
    }];
}

- (void)initTabelView {
    MC_Weak_Self(self);
    _chapterModel = [[MCBookChapterViewModel alloc] init];
    _chapterModel.jumpCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(RACTuple *input) {
        [self jumpToBookInfoController:input];
        return [RACSignal empty];
    }];
    [self.view addSubview:self.bookChapterTableView];
    [self.bookChapterTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(weakself.view);
        make.left.equalTo(weakself.view);
    }];
}

- (void)jumpToBookInfoController:(RACTuple *)tuple {
    MCBookReadViewController *chapterInfoVC = [[MCBookReadViewController alloc] init];
    chapterInfoVC.readViewModel.chapterResponse = tuple[0];
    chapterInfoVC.readViewModel.chapterIndex = [tuple[1] intValue];
    [self.navigationController pushViewController:chapterInfoVC animated:YES];
}

-(UITableView *)bookChapterTableView {
    if (!_bookChapterTableView) {
        _bookChapterTableView = [[UITableView alloc] init];
        _bookChapterTableView.delegate = _chapterModel;
        _bookChapterTableView.dataSource = _chapterModel;
        _bookChapterTableView.estimatedRowHeight = 27;
        _bookChapterTableView.rowHeight = UITableViewAutomaticDimension;
        _bookChapterTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bookChapterTableView.backgroundColor = [UIColor clearColor];
        [_bookChapterTableView registerClass:[MCBookChapterCell class] forCellReuseIdentifier:NSStringFromClass([MCBookChapterCell class])];
    }
    return _bookChapterTableView;
}


@end
