//
//  MCBookSearchRequest.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/28.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookSearchRequest.h"

@implementation MCBookSearchRequest

-(instancetype)init {
    if (self = [super init]) {
        self.methodURL = @"http://novel.juhe.im/search";
    }
    return self;
}

@end
