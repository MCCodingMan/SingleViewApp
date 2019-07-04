//
//  MCQueryCategoriesBooksResponse.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/15.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCQueryCategoriesBooksResponse.h"

@implementation MCQueryCategoriesBooksResponse

- (void)decode:(NSDictionary *)jsonData {
    _books = [[NSMutableArray alloc] init];
    [super decode:jsonData];
}

+(NSDictionary *)objectClassInArray {
    return @{@"books":[MCCategoriesBooksList class]};
}

@end
