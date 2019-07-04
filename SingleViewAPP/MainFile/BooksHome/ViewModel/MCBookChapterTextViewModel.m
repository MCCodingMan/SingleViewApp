//
//  MCBookChapterTextViewModel.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/21.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookChapterTextViewModel.h"
#import "MCBookChapterTextResponse.h"

@interface MCBookChapterTextViewModel()

@property (nonatomic, strong) MCBookChapterTextResponse *chapterTextResponse;

@end

@implementation MCBookChapterTextViewModel

- (void)queryChapterInfoWithLink:(NSString *)chapterLink complete:(void(^)(void))complete faile:(void(^)(void))faile {
    MC_Weak_Self(self);
    [MC_NetWorkRequest queryBookChapterInfoWithChapterLink:chapterLink CompletionBlock:^(id  _Nonnull result) {
        weakself.chapterTextResponse = [[MCBookChapterTextResponse alloc] init];
        [weakself.chapterTextResponse decode:result[@"chapter"]];
        complete();
    } faileBlock:^(NSError * _Nonnull error) {
        faile();
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.chapterTextResponse) {
        return 1;
    }else{
        return 0;
    }
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 20;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UILabel *chapterTitleLabel = [[UILabel alloc] init];
//    chapterTitleLabel.text = self.chapterTextResponse.title;
//    chapterTitleLabel.font = [UIFont systemFontOfSize:12];
//    chapterTitleLabel.backgroundColor = MC_COLOR_RGBA(1, 1, 1, 0.3);
//    chapterTitleLabel.textAlignment = NSTextAlignmentCenter;
//    return chapterTitleLabel;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired =2;
    doubleTapGesture.numberOfTouchesRequired =1;
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    [cell.contentView addGestureRecognizer:doubleTapGesture];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.numberOfLines = 0;
    textLabel.font = [UIFont systemFontOfSize:14];
    textLabel.text = [self.chapterTextResponse.cpContent stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
    [cell addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell).offset(8);
        make.top.equalTo(cell).offset(8);
        make.width.mas_equalTo(MC_SCREEN_WIDTH - 16);
        make.bottom.equalTo(cell).offset(-8);
    }];
    return cell;
}

-(void)handleDoubleTap:(UIGestureRecognizer *)sender{
    [self.jumpCommand execute:nil];
}


@end
