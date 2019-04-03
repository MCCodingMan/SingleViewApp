//
//  MCQueryJockesRequest.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCQueryJockesRequest : MCBaseRequest

@property (nonatomic, assign) int type;

@property (nonatomic, assign) int page;

@end

NS_ASSUME_NONNULL_END
