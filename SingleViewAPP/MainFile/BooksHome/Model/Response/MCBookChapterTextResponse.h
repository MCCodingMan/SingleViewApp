//
//  MCBookChapterTextResponse.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/21.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookChapterTextResponse : MCBaseResponse

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *cpContent;


@end

NS_ASSUME_NONNULL_END
