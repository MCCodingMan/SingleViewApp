//
//  MCBookListViewModel.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/14.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookBaseViewModel.h"
#import "MCQueryCategoriesBooksListRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookListViewModel : MCBookBaseViewModel<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) MCQueryCategoriesBooksListRequest *listRequest;

@property (nonatomic, strong) RACCommand *refreshCellCommand;

- (void)queryCategoriesBooksList:(void(^)(void))complete faile:(void(^)(void))faile;

@end

NS_ASSUME_NONNULL_END
