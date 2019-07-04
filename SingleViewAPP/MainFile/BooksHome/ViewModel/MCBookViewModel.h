//
//  MCBookViewModel.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/13.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookBaseViewModel.h"
#import "MCQueryCategoriesBooksListRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookViewModel : MCBookBaseViewModel<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MCQueryCategoriesBooksListRequest *listRequest;

@property (nonatomic, strong) RACCommand *selectCellCommand;

- (void)queryCategories:(void(^)(void))complete faile:(void(^)(void))faile;

@end

NS_ASSUME_NONNULL_END
