//
//  MCBaseViewModel.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/4.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCQueryJockesResultResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBaseViewModel : NSObject

//网络请求返参Model
@property (nonatomic, strong) MCQueryJockesResultResponse *jockeResponse;

/**
 查询段子网络请求
 
 @param type 类型 1:全部 2:text 3：图片 4:GIF 5:Video
 @param page 页数
 @param complete 成功回调
 @param fail 失败回调
 */
- (void)queryJockesWithType:(int)type page:(int)page success:(void(^)(void))complete faile:(void(^)(void))fail;

@end

NS_ASSUME_NONNULL_END
