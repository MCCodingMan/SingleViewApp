//
//  MCQueryCategoriesResponse.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/13.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseResponse.h"
#import "MCQueryCategoriesList.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCQueryCategoriesResponse : MCBaseResponse

@property (nonatomic, strong) NSMutableArray<MCQueryCategoriesList *> *male;

@property (nonatomic, strong) NSMutableArray<MCQueryCategoriesList *> *female;

@property (nonatomic, strong) NSMutableArray<MCQueryCategoriesList *> *picture;

@property (nonatomic, strong) NSMutableArray<MCQueryCategoriesList *> *press;

@end

NS_ASSUME_NONNULL_END
