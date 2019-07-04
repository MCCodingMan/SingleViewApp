//
//  MCNetworkManage.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/5.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCBaseRequest.h"

typedef void(^ProgressBlock)(NSProgress *dataTaskProgress);
typedef void(^CompleteBlock)(NSDictionary *dataTaskResult);
typedef void(^ErrorBlock)(NSError *error);

NS_ASSUME_NONNULL_BEGIN

@interface MCNetworkManage : NSObject

+ (MCNetworkManage *)shareManager;

- (void)mc_postRequest:(MCBaseRequest *)request progressBlock:(ProgressBlock)progressBlock completeBlock:(CompleteBlock)completeBlock errorBlock:(ErrorBlock)errorBlock;

- (void)mc_getRequest:(MCBaseRequest *)request progressBlock:(ProgressBlock)progressBlock completeBlock:(CompleteBlock)completeBlock errorBlock:(ErrorBlock)errorBlock;

@end

NS_ASSUME_NONNULL_END
