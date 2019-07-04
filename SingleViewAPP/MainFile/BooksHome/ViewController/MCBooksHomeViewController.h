//
//  MCBooksHomeViewController.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/13.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBooksHomeViewController : MCBookBaseViewController

@property (nonatomic, strong) UITableView *mainLeftTableView;

@property (nonatomic, strong) UITableView *mainRightTableView;

@end

NS_ASSUME_NONNULL_END
