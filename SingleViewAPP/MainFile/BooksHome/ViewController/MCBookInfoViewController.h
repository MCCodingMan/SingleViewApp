//
//  MCBookInfoViewController.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/20.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookBaseViewController.h"
#import "MCBookInfoViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookInfoViewController : MCBookBaseViewController

@property (nonatomic, strong) MCBookInfoViewModel *dataInfoModel;

@property (nonatomic, strong) UITableView *bookInfoTableView;

@property (nonatomic, copy) NSString *bookID;

@end

NS_ASSUME_NONNULL_END
