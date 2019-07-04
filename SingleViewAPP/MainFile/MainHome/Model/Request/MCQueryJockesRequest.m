//
//  MCQueryJockesRequest.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCQueryJockesRequest.h"

@implementation MCQueryJockesRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodURL = @"https://www.apiopen.top/satinGodApi";
    }
    return self;
}

@end
