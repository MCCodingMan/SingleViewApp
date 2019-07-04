//
//  MCBookTextViewController.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/21.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookBaseViewController.h"
#import "MCBookChapterTextViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MCBookTextViewController : MCBookBaseViewController

@property (nonatomic, strong) MCBookChapterTextViewModel *dataModel;

@property (nonatomic, strong) UITableView *chapterInfoTableView;

@end

NS_ASSUME_NONNULL_END
