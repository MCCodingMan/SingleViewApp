//
//  MCBookSourceCell.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/20.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBookSourceList.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookSourceCell : UITableViewCell

- (void)initDataWithSourceModel:(MCBookSourceList *)sourceModel;

@end

NS_ASSUME_NONNULL_END
