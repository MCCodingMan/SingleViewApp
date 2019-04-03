//
//  MCHttpManager.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/2.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CompletionBlock)(id result);
typedef void(^ErrorBlock)(NSError *error);

@interface MCHttpManager : NSObject

@property (nonatomic, assign) NSInteger postCount;

@property (nonatomic, assign) NSInteger lastPostCount;

/**
 网络请求管理单例
 
 @return 单例
 */
+ (instancetype)shareManager;

/**
 GET请求
 
 @param request 请求入参
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getNetworkWithRequest:(MCBaseRequest *)request completeBlock:(CompletionBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/**
 POST请求
 
 @param request 请求入参
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)postNetworkWithRequest:(MCBaseRequest *)request completeBlock:(CompletionBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/**
 取消网络请求
 */
- (void)cancelNetwork;

@end

NS_ASSUME_NONNULL_END
