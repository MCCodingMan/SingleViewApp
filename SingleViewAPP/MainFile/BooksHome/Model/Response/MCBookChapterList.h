//
//  MCBookChapterList.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/20.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookChapterList : MCBaseResponse

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, assign) int time;
@property (nonatomic, copy) NSString *chapterCover;
@property (nonatomic, assign) int totalpage;
@property (nonatomic, assign) int partsize;
@property (nonatomic, assign) int order;
@property (nonatomic, assign) int currency;
@property (nonatomic, assign) BOOL unreadble;
@property (nonatomic, assign) BOOL isVip;
@end

NS_ASSUME_NONNULL_END
