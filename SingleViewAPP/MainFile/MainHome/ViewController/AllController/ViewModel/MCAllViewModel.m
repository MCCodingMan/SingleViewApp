//
//  MCAllViewModel.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/8.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCAllViewModel.h"
#import "UIImage+Resize.h"
#import "MCImageTableViewCell.h"
#import "MCVideoTableViewCell.h"
#import "MCTextTableViewCell.h"
#import "FLAnimatedImage.h"
#import "SJVideoPlayer.h"

@interface MCAllViewModel()

@property (nonatomic, strong) SJVideoPlayer *player;

@end

@implementation MCAllViewModel {
    NSMutableArray<NSMutableArray<MCQueryJockesResponse *> *> *dataArr;
    NSMutableArray<NSMutableArray *> *imageArr;
    NSData *imageData;
}

- (instancetype)init{
    if (self = [super init]) {
        [self initDataArr];
    }
    return self;
}

- (void)initDataArr {
    dataArr = [[NSMutableArray alloc] init];
    imageArr = [[NSMutableArray alloc] init];
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
- (void)queryJockesWithType:(int)type page:(int)page success:(void (^)(void))complete faile:(void (^)(void))fail {
    MC_Weak_Self(self);
    [MC_NetWorkRequest queryJockesWithType:type page:page completionBlock:^(id  _Nonnull result) {
        if (![result[@"msg"] isEqualToString:@"服务器异常!"]) {
            weakself.jockeResponse = [[MCQueryJockesResultResponse alloc] init];
            [weakself.jockeResponse decode:result];
            [self->dataArr addObject:weakself.jockeResponse.data];
            __block NSInteger imageLoadCout = 0;
            NSMutableArray *imageDataArr = [[NSMutableArray alloc] init];
            for (int i = 0; i < weakself.jockeResponse.data.count; i++) {
                if ([weakself.jockeResponse.data[i].type isEqualToString:@"image"]) {
                    [imageDataArr addObject:[MC_ImageWithName(@"image_pic_default") resizableImageWithWidth:MC_SCREEN_WIDTH - 40]];
                    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:weakself.jockeResponse.data[i].image] options:SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                        
                    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                        imageLoadCout++;
                        if (image) {
                            UIImage *newImage = [image resizableImageWithWidth:MC_SCREEN_WIDTH - 40];
                            [imageDataArr replaceObjectAtIndex:i withObject:newImage];
                        }
                        if (imageLoadCout == weakself.jockeResponse.data.count) {
                            [self->imageArr addObject:imageDataArr];
                            complete();
                        }
                    }];
                }else if ([weakself.jockeResponse.data[i].type isEqualToString:@"gif"]) {
                    [imageDataArr addObject:self->imageData];
                    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:weakself.jockeResponse.data[i].gif] options:SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                        
                    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                        imageLoadCout++;
                        if (data) {
                            [imageDataArr replaceObjectAtIndex:i withObject:data];
                        }
                        if (imageLoadCout == weakself.jockeResponse.data.count) {
                            [self->imageArr addObject:imageDataArr];
                            complete();
                        }
                    }];
                }else{
                    [imageDataArr addObject:@"text"];
                    imageLoadCout++;
                    if (imageLoadCout == weakself.jockeResponse.data.count) {
                        [self->imageArr addObject:imageDataArr];
                        complete();
                    }
                }
            }
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
    if ([dataArr[indexPath.section][indexPath.row].type isEqualToString:@"image"]) {
        MCImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MCImageTableViewCell class])];
        if (!cell) {
            cell = [[MCImageTableViewCell alloc] init];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.cellData = dataArr[indexPath.section][indexPath.row];
        [cell.contentImageView setImage:imageArr[indexPath.section][indexPath.row]];
        return cell;
    }else if ([dataArr[indexPath.section][indexPath.row].type isEqualToString:@"gif"]) {
        MCImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MCImageTableViewCell class])];
        if (!cell) {
            cell = [[MCImageTableViewCell alloc] init];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.cellData = dataArr[indexPath.section][indexPath.row];
        NSData *tempImageData = imageArr[indexPath.section][indexPath.row];
        if ([tempImageData isEqualToData:imageData]) {
            cell.contentImageView.image = [UIImage imageWithData:tempImageData];
        }else{
            cell.gifImageView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageArr[indexPath.section][indexPath.row]];
        }
        return cell;
    }else if ([dataArr[indexPath.section][indexPath.row].type isEqualToString:@"text"]) {
        MCTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MCTextTableViewCell class])];
        if (!cell) {
            cell = [[MCTextTableViewCell alloc] init];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.dataModel = dataArr[indexPath.section][indexPath.row];
        return cell;
    }else{
        return [MCVideoTableViewCell cellWithTableView:tableView data:dataArr[indexPath.section][indexPath.row]];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([dataArr[indexPath.section][indexPath.row].type isEqualToString:@"video"]) {
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
}

- (void)headerRefresh {
    [dataArr removeAllObjects];
    [imageArr removeAllObjects];
    [[SDImageCache sharedImageCache] clearMemory];
    MC_PostNotification(@"MCAllRefresh", nil, nil);
}

- (void)footerRefresh {
    MC_PostNotification(@"MCAllRefresh", nil, nil);
}
     
@end
