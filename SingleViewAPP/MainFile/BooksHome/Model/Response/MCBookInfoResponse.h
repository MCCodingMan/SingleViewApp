//
//  MCBookInfoResponse.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/20.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookInfoResponse : MCBaseResponse

@property (nonatomic, copy) NSString *_id;

@property (nonatomic, copy) NSString *longIntro;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *minorCateV2;

@property (nonatomic, copy) NSString *minorCate;

@property (nonatomic, copy) NSString *majorCate;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *creater;

@property (nonatomic, copy) NSString *majorCateV2;

@property (nonatomic, assign) BOOL isMakeMoneyLimit;

@property (nonatomic, assign) BOOL isFineBook;

@property (nonatomic, assign) int safelevel;

@property (nonatomic, assign) BOOL allowFree;

@property (nonatomic, copy) NSString *originalAuthor;

@property (nonatomic, strong) NSMutableArray *anchors;

@property (nonatomic, copy) NSString *authorDesc;

@property (nonatomic, strong) NSDictionary *rating;

@property (nonatomic, assign) BOOL hasCopyright;

@property (nonatomic, assign) int buytype;

@property (nonatomic, assign) double sizetype;

@property (nonatomic, copy) NSString *superscript;

@property (nonatomic, assign) double currency;

@property (nonatomic, copy) NSString *contentType;

@property (nonatomic, assign) BOOL _le;

@property (nonatomic, assign) BOOL allowMonthly;

@property (nonatomic, assign) BOOL allowVoucher;

@property (nonatomic, assign) BOOL allowBeanVoucher;

@property (nonatomic, assign) BOOL hasCp;

@property (nonatomic, assign) double banned;

@property (nonatomic, assign) double postCount;

@property (nonatomic, assign) double latelyFollower;

@property (nonatomic, assign) double followerCount;

@property (nonatomic, assign) double wordCount;

@property (nonatomic, assign) double serializeWordCount;

@property (nonatomic, copy) NSString *retentionRatio;

@property (nonatomic, copy) NSString *updated;

@property (nonatomic, assign) BOOL isSerial;

@property (nonatomic, assign) double chaptersCount;

@property (nonatomic, copy) NSString *lastChapter;

@property (nonatomic, strong) NSMutableArray *gender;

@property (nonatomic, strong) NSMutableArray *tags;

@property (nonatomic, assign) BOOL advertRead;

@property (nonatomic, copy) NSString *cat;

@property (nonatomic, assign) BOOL donate;

@property (nonatomic, assign) BOOL _gg;

@property (nonatomic, assign) BOOL isForbidForFreeApp;

@property (nonatomic, assign) BOOL isAllowNetSearch;

@property (nonatomic, assign) BOOL limit;

@property (nonatomic, copy) NSString *copyrightDesc;

@property (nonatomic, copy) NSString *discount;
@end

NS_ASSUME_NONNULL_END
