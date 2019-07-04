//
//  MCQueryCategoriesRequest.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/13.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCQueryCategoriesRequest.h"

@implementation MCQueryCategoriesRequest

- (instancetype)init {
    if (self = [super init]) {
        self.methodURL = @"http://novel.juhe.im/categories";
    }
    return self;
}

@end
