//
//  MCQueryJockesResponse.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCQueryJockesResponse : MCBaseResponse

@property (nonatomic, copy) NSString *header;

@property (nonatomic, copy) NSString *passtime;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *video;

@property (nonatomic, copy) NSString *gif;

@end

NS_ASSUME_NONNULL_END
