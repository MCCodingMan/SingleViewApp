//
//  MCImageViewModel.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/4.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCImageViewModel.h"
#import "UIImage+Resize.h"

@implementation MCImageViewModel {
    NSMutableArray<NSMutableArray *> *dataArr;
    NSMutableArray<UIImage *> *imageDataArr;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initDataArr];
    }
    return self;
}

- (void)initDataArr {
    dataArr = [[NSMutableArray alloc] init];
    imageDataArr = [[NSMutableArray alloc] init];
}

/**
 查询网络请求
 
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
        __block NSInteger imageLoadCout = 0;
        for (int i = 0; i < weakself.jockeResponse.data.count; i++) {
            [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:weakself.jockeResponse.data[i].image] options:SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                imageLoadCout++;
                if (image) {
                    UIImage *newImage = [image resizableImageWithWidth:MC_SCREEN_WIDTH - 40];
                    [self->imageDataArr addObject:newImage];
                }else{
                    UIImage *newImage = [MC_ImageWithName(@"image_pic_default") resizableImageWithWidth:MC_SCREEN_WIDTH - 40];
                    [self->imageDataArr addObject:newImage];
                }
                if (imageLoadCout == weakself.jockeResponse.data.count) {
                    complete();
                }
            }];
        }
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
    MCImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MCImageTableViewCell class])];
    if (!cell) {
        cell = [[MCImageTableViewCell alloc] init];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.cellData = dataArr[indexPath.section][indexPath.row];
    [cell.contentImageView setImage:imageDataArr[dataArr[indexPath.section].count * indexPath.section + indexPath.row]];
    return cell;
}

- (void)headerRefresh {
    [dataArr removeAllObjects];
    [imageDataArr removeAllObjects];
    [[SDImageCache sharedImageCache] clearMemory];
    MC_PostNotification(@"MCImageRefresh", nil, nil);
}

- (void)footerRefresh {
    MC_PostNotification(@"MCImageRefresh", nil, nil);
}


@end
