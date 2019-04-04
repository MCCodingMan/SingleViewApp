//
//  MCQueryJockesResultResponse.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCQueryJockesResultResponse.h"

@implementation MCQueryJockesResultResponse

- (void)decode:(NSDictionary *)jsonData {
    _data = [[NSMutableArray alloc] init];
    [super decode:jsonData];
}

+ (NSDictionary *)objectClassInArray {
    return @{@"data":[MCQueryJockesResponse class]};
}


@end
