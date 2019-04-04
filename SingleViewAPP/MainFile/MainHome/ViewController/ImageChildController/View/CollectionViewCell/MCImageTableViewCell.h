//
//  MCImageCollectionViewCell.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/4.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCQueryJockesResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCImageTableViewCell : UITableViewCell

@property (nonatomic, strong) MCQueryJockesResponse *cellData;

@property (nonatomic, strong) UIImageView *contentImageView;

@end

NS_ASSUME_NONNULL_END
