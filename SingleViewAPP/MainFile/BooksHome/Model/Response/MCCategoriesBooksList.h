//
//  MCCategoriesBooksList.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/15.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCCategoriesBooksList : MCBaseResponse

@property (nonatomic, copy) NSString *_id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *majorCate;

@property (nonatomic, copy) NSString *shortIntro;

@property (nonatomic, copy) NSString *minorCate;

@property (nonatomic, copy) NSString *site;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, assign) NSInteger sizetype;

@property (nonatomic, copy) NSString *superscript;

@property (nonatomic, copy) NSString *contentType;

@property (nonatomic, assign) BOOL allowMonthly;

@property (nonatomic, assign) float banned;

@property (nonatomic, assign) double latelyFollower;

@property (nonatomic, assign) float retentionRatio;

@property (nonatomic, copy) NSString *lastChapter;

@property (nonatomic, strong) NSMutableArray<NSString *> *tags;

@end

NS_ASSUME_NONNULL_END
