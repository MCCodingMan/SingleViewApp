//
//  MCBookCompleteRequest.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/28.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookCompleteRequest.h"

@implementation MCBookCompleteRequest

-(instancetype)init {
    if (self = [super init]) {
        self.methodURL = @"http://novel.juhe.im/auto-complete";
    }
    return self;
}

@end
