//
//  MCBookSourceList.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/20.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookSourceList : MCBaseResponse

@property (nonatomic, copy) NSString *_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *lastChapter;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, assign) BOOL isCharge;

@property (nonatomic, assign) double chaptersCount;

@property (nonatomic, copy) NSString *updated;

@property (nonatomic, assign) BOOL starting;

@property (nonatomic, copy) NSString *host;

@end

NS_ASSUME_NONNULL_END
