//
//  MCQueryCategoriesBooksResponse.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/15.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseResponse.h"
#import "MCCategoriesBooksList.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCQueryCategoriesBooksResponse : MCBaseResponse

@property (nonatomic, assign) double total;

@property (nonatomic, strong) NSMutableArray<MCCategoriesBooksList *> *books;

@end

NS_ASSUME_NONNULL_END
