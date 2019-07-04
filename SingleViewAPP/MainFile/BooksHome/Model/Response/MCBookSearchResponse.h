//
//  MCBookSearchResponse.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/28.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookSearchListResponse : MCBaseResponse

@property (nonatomic, copy) NSString *_id;

@property (nonatomic, assign) BOOL hasCp;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *aliases;

@property (nonatomic, copy) NSString *cat;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *site;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *shortIntro;

@property (nonatomic, copy) NSString *lastChapter;

@property (nonatomic, assign) double retentionRatio;

@property (nonatomic, assign) double banned;

@property (nonatomic, assign) BOOL allowMonthly;

@property (nonatomic, assign) double latelyFollower;

@property (nonatomic, assign) double wordCount;

@property (nonatomic, copy) NSString *contentType;

@end

@interface MCBookSearchResponse : MCBaseResponse

@property (nonatomic, strong) NSMutableArray<MCBookSearchListResponse *> *books;

@end

NS_ASSUME_NONNULL_END
