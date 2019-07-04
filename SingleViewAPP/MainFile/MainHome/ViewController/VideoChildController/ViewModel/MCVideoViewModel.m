//
//  MCVideoViewModel.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/8.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCVideoViewModel.h"
#import "MCVideoTableViewCell.h"
#import "SJVideoPlayer.h"

@interface MCVideoViewModel()

@property (nonatomic, strong) SJVideoPlayer *player;

@end

@implementation MCVideoViewModel {
    NSMutableArray<NSMutableArray<MCQueryJockesResponse *> *> *dataArr;
    
}

- (instancetype)init {
    if ( self = [super init]) {
        [self initDataArr];
    }
    return self;
}

- (void)initDataArr {
    dataArr = [[NSMutableArray alloc] init];
}

/**
 查询段子网络请求
 
 @param type 类型 1:全部 2:text 3：图片 4:GIF 5:Video
 @param page 页数
 @param complete 成功回调
 @param fail 失败回调
 */
- (void)queryJockesWithType:(int)type page:(int)page success:(void(^)(void))complete faile:(void(^)(void))fail {
    MC_Weak_Self(self);
    [MC_NetWorkRequest queryJockesWithType:type page:page completionBlock:^(id  _Nonnull result) {
        weakself.jockeResponse = [[MCQueryJockesResultResponse alloc] init];
        [weakself.jockeResponse decode:result];
        [self->dataArr addObject:weakself.jockeResponse.data];
        complete();
    } faileBlock:^(NSError * _Nonnull error) {
        NSLog(@"请求失败");
        fail();
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MCVideoTableViewCell cellWithTableView:tableView data:dataArr[indexPath.section][indexPath.row]];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    MC_Weak_Self(self);
    ((MCVideoTableViewCell *)cell).view.clickedPlayButtonExeBlock = ^(MCPlayView * _Nonnull view) {
        MC_Strong_Self(weakself);
        if ( !self ) return;
        [self.player stopAndFadeOut];
        
        // create new player
        self.player = [SJVideoPlayer player];
        //        self.player.needPresentModalViewControlller = YES;
        [view.coverImageView addSubview:self.player.view];
        [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        
        self.player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:self->dataArr[indexPath.section][indexPath.row].video] playModel:[SJPlayModel UITableViewCellPlayModelWithPlayerSuperviewTag:view.coverImageView.tag atIndexPath:indexPath tableView:tableView]];
        self.player.URLAsset.title = self->dataArr[indexPath.section][indexPath.row].text;
    };
}

- (void)headerRefresh {
    [dataArr removeAllObjects];
    MC_PostNotification(@"MCVideoRefresh", nil, nil);
}

- (void)footerRefresh {
    MC_PostNotification(@"MCVideoRefresh", nil, nil);
}

@end
