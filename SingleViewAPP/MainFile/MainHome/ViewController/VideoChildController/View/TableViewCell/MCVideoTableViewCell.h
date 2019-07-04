//
//  MCVideoTableViewCell.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/8.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPlayView.h"
#import "MCQueryJockesResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCVideoTableViewCell : UITableViewCell

+ (MCVideoTableViewCell *)cellWithTableView:(UITableView *)tableView data:(MCQueryJockesResponse *)data;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(MCQueryJockesResponse *)data;

@property (nonatomic, strong, readonly) MCPlayView *view;

@end

NS_ASSUME_NONNULL_END
