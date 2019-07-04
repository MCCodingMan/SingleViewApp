//
//  MCBookReadViewModel.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/29.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookReadViewModel.h"
#import "MCBookChapterTextViewModel.h"

@interface MCBookReadViewModel()

@property (nonatomic, strong) MCBookChapterTextViewModel *chapterViewModel;

@end

@implementation MCBookReadViewModel

- (instancetype)init {
    if (self = [super init]) {
        _chapterViewModel = [[MCBookChapterTextViewModel alloc] init];
    }
    return self;
}

@end
