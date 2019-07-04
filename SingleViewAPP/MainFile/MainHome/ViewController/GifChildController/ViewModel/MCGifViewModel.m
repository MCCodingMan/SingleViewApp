//
//  MCGifViewModel.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/8.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCGifViewModel.h"
#import "UIImage+Resize.h"
#import "MCImageTableViewCell.h"
#import "FLAnimatedImage.h"

@implementation MCGifViewModel {
    NSMutableArray<NSMutableArray<MCQueryJockesResponse *> *> *dataArr;
    NSMutableArray<NSMutableArray<NSData *> *> *imageDataArr;
    NSData *imageData;
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
    UIImage *newImage = [MC_ImageWithName(@"image_pic_default") resizableImageWithWidth:MC_SCREEN_WIDTH - 40];
    imageData = UIImageJPEGRepresentation(newImage,1.0f);
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
        __block NSInteger imageLoadCout = 0;
        NSMutableArray<NSData *> *dataArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < weakself.jockeResponse.data.count; i++) {
            [dataArr addObject:self->imageData];
            [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:weakself.jockeResponse.data[i].gif] options:SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                imageLoadCout++;
                if (data) {
                    [dataArr replaceObjectAtIndex:i withObject:data];
                }
                if (imageLoadCout == weakself.jockeResponse.data.count) {
                    [self->imageDataArr addObject:dataArr];
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
    NSData *tempImageData = imageDataArr[indexPath.section][indexPath.row];
    if ([tempImageData isEqualToData:imageData]) {
        cell.contentImageView.image = [UIImage imageWithData:tempImageData];
    }else{
      cell.gifImageView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageDataArr[indexPath.section][indexPath.row]];
    }
    return cell;
}

- (void)headerRefresh {
    [dataArr removeAllObjects];
    [imageDataArr removeAllObjects];
    [[SDImageCache sharedImageCache] clearMemory];
    MC_PostNotification(@"MCGifRefresh", nil, nil);
}

- (void)footerRefresh {
    MC_PostNotification(@"MCGifRefresh", nil, nil);
}

@end
