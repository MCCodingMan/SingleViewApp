//
//  MCBookSourceRequest.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/20.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookSourceRequest.h"

@implementation MCBookSourceRequest

-(instancetype)init {
    if (self = [super init]) {
        self.view = @"summary";
        self.methodURL = @"http://novel.juhe.im/book-sources";
    }
    return self;
}


@end
