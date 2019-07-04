//
//  MCBookListViewController.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/17.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookBaseViewController.h"
#import "MCQueryCategoriesBooksListRequest.h"
#import "MCBookListViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookListViewController : MCBookBaseViewController

@property (nonatomic, strong) MCBookListViewModel *baseDataModel;

@property (nonatomic, strong) UITableView *bookListTableView;

@end

NS_ASSUME_NONNULL_END
