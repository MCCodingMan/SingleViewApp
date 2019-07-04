//
//  MCBookChapterResponse.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/20.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookChapterResponse.h"

@implementation MCBookChapterResponse

-(void)decode:(NSDictionary *)jsonData {
    _chapters = [[NSMutableArray alloc] init];
    [super decode:jsonData];
}

+(NSDictionary *)objectClassInArray {
    return @{@"chapters":[MCBookChapterList class]};
}

@end
