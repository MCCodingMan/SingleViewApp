//
//  MCQueryCategoriesBooksListRequest.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/14.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCQueryCategoriesBooksListRequest.h"

@implementation MCQueryCategoriesBooksListRequest

- (instancetype)init {
    if (self = [super init]) {
        self.methodURL = @"http://novel.juhe.im/category-info";
        self.type = @"hot";
        self.start = 0;
        self.limit = 20;
        self.minor = @"";
    }
    return self;
}

@end
