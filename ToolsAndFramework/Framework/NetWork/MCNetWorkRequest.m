//
//  MCNetWorkRequest.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCNetWorkRequest.h"
#import "MCQueryJockesRequest.h"

#define MC_NetWork [MCHttpManager shareManager]

@implementation MCNetWorkRequest

static MCNetWorkRequest *networkManager;

/**
 请求单列

 @return 单列对象
 */
+ (instancetype)shareRequest {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[MCNetWorkRequest alloc] init];
    });
    return networkManager;
}

/**
 2019.4.3 段子网络请求

 @param type 类型
 @param page 页数
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryJockesWithType:(int)type page:(int)page completionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock {
    MCQueryJockesRequest *request = [[MCQueryJockesRequest alloc] init];
    request.type = type;
    request.page = page;
    [MC_NetWork getNetworkWithRequest:request completeBlock:^(id  _Nonnull result) {
        successBlock(result);
    } errorBlock:^(NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

@end
