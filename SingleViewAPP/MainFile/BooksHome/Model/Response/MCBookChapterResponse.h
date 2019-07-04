//
//  MCBookChapterResponse.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/20.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseResponse.h"
#import "MCBookChapterList.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookChapterResponse : MCBaseResponse

@property (nonatomic, copy) NSString *_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *book;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, strong) NSMutableArray<MCBookChapterList *> *chapters;


@end

NS_ASSUME_NONNULL_END
