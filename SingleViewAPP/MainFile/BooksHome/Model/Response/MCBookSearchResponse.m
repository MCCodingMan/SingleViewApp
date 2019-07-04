//
//  MCBookSearchResponse.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/28.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookSearchResponse.h"

@implementation MCBookSearchListResponse

@end

@implementation MCBookSearchResponse

- (void)decode:(NSDictionary *)jsonData {
    _books = [[NSMutableArray alloc] init];
    [super decode:jsonData];
}

+ (NSDictionary *)objectClassInArray {
    return @{@"books":[MCBookSearchListResponse class]};
}

@end
