//
//  MCBookCompleteResponse.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/28.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookCompleteResponse : MCBaseResponse

@property (nonatomic, copy) NSArray *keywords;

@property (nonatomic, assign) BOOL ok;

@end

NS_ASSUME_NONNULL_END
