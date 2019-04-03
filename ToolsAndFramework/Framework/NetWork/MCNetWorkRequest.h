//
//  MCNetWorkRequest.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCHttpManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCNetWorkRequest : NSObject

/**
 请求单列
 
 @return 单列对象
 */
+ (instancetype)shareRequest;

/**
 2019.4.3 段子网络请求
 
 @param type 类型
 @param page 页数
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryJockesWithType:(int)type page:(int)page completionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock;

@end

NS_ASSUME_NONNULL_END
