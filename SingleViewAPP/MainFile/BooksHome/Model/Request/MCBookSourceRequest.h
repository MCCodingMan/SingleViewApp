//
//  MCBookSourceRequest.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/20.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookSourceRequest : MCBaseRequest

@property (nonatomic, copy) NSString *view;

@property (nonatomic, copy) NSString *book;

@end

NS_ASSUME_NONNULL_END
