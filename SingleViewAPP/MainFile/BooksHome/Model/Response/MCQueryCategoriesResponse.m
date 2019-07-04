//
//  MCQueryCategoriesResponse.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/13.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCQueryCategoriesResponse.h"

@implementation MCQueryCategoriesResponse

- (void)decode:(NSDictionary *)jsonData {
    _male = [[NSMutableArray alloc] init];
    _female = [[NSMutableArray alloc] init];
    _picture = [[NSMutableArray alloc] init];
    _press = [[NSMutableArray alloc] init];
    [super decode:jsonData];
}

+(NSDictionary *)objectClassInArray {
    return @{@"male":[MCQueryCategoriesList class],
             @"female":[MCQueryCategoriesList class],
             @"picture":[MCQueryCategoriesList class],
             @"press":[MCQueryCategoriesList class]};
}

@end
