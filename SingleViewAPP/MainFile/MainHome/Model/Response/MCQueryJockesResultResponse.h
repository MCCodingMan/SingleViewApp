//
//  MCQueryJockesResultResponse.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseResponse.h"
#import "MCQueryJockesResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCQueryJockesResultResponse : MCBaseResponse

@property (nonatomic, strong) NSMutableArray<MCQueryJockesResponse *> *data;

@end

NS_ASSUME_NONNULL_END
