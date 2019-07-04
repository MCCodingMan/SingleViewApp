//
//  MCQueryCategoriesBooksListRequest.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/14.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCQueryCategoriesBooksListRequest : MCBaseRequest

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *major;

@property (nonatomic, copy) NSString *minor;

@property (nonatomic, assign) int start;

@property (nonatomic, assign) int limit;
@end

NS_ASSUME_NONNULL_END
