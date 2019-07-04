//
//  MCBookSearchRequest.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/28.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookSearchRequest : MCBaseRequest

@property (nonatomic, copy) NSString *keyword;

@end

NS_ASSUME_NONNULL_END
