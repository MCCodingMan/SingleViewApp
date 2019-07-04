//
//  MCQueryCategoriesList.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/13.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCQueryCategoriesList : MCBaseResponse

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) double bookCount;
@property (nonatomic, assign) double monthlyCount;
@property (nonatomic, copy) NSString *icon;

@end

NS_ASSUME_NONNULL_END
