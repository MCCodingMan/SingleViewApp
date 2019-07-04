//
//  MCBookChapterListViewController.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/20.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookBaseViewController.h"
#import "MCBookChapterViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookChapterListViewController : MCBookBaseViewController

@property (nonatomic, strong) MCBookChapterViewModel *chapterModel;

@property (nonatomic, strong) UITableView *bookChapterTableView;

@property (nonatomic, copy) NSString *sourceID;

@end

NS_ASSUME_NONNULL_END
