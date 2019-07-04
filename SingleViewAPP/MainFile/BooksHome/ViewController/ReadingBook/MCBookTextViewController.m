//
//  MCBookTextViewController.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/21.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookTextViewController.h"


@interface MCBookTextViewController ()



@end

@implementation MCBookTextViewController

-(instancetype)init {
    if (self = [super init]) {
        _dataModel = [[MCBookChapterTextViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSomeSetting];
    // Do any additional setup after loading the view.
}

- (void)initSomeSetting {
    self.backGroundImage = MC_ImageWithName(@"bg_pic_001");
    [self initTabelView];
    [self initDataModel];
    
}

- (void)initDataModel {
    MC_Weak_Self(self);
    [UIView showWarningMessageWithString:@"正在获取章节信息..."];
    [_dataModel queryChapterInfoWithLink:self.dataModel.chapterResponse.chapters[self.dataModel.chapterIndex].link complete:^{
//        [self.navigationController setNavigationBarHidden:YES];
        [weakself.chapterInfoTableView reloadData];
    } faile:^{
//        [self.navigationController setNavigationBarHidden:NO];
        [UIView showWarningMessageWithString:@"获取章节信息失败"];
    }];
}

- (void)initTabelView {
    MC_Weak_Self(self);
    _dataModel.jumpCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [self.navigationController popViewControllerAnimated:YES];
        return [RACSignal empty];
    }];
    [self.view addSubview:self.chapterInfoTableView];
    [self.chapterInfoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(weakself.view);
        make.top.equalTo(weakself.view).offset(20);
        make.left.equalTo(weakself.view);
    }];
}

-(UITableView *)chapterInfoTableView {
    if (!_chapterInfoTableView) {
        _chapterInfoTableView = [[UITableView alloc] init];
        _chapterInfoTableView.delegate = _dataModel;
        _chapterInfoTableView.dataSource = _dataModel;
        _chapterInfoTableView.estimatedRowHeight = MC_SCREEN_HEIGHT;
        _chapterInfoTableView.rowHeight = UITableViewAutomaticDimension;
        _chapterInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _chapterInfoTableView.backgroundColor = [UIColor clearColor];
    }
    return _chapterInfoTableView;
}


@end
