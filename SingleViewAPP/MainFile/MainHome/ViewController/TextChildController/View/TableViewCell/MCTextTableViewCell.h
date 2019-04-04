//
//  MCTextTableViewCell.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCQueryJockesResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCTextTableViewCell : UITableViewCell

@property (nonatomic, strong) MCQueryJockesResponse *dataModel;

@end

NS_ASSUME_NONNULL_END
