//
//  MCBookReadViewModel.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/29.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookBaseViewModel.h"
#import "MCBookChapterResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookReadViewModel : MCBookBaseViewModel

@property (nonatomic, strong) RACCommand *forwordTurnPage;

@property (nonatomic, strong) RACCommand *backwardTurnPage;

@property (nonatomic, strong) RACSignal *receiveSignal;

@property (nonatomic, strong) MCBookChapterResponse *chapterResponse;

@property (nonatomic, assign) NSInteger chapterIndex;

@end

NS_ASSUME_NONNULL_END
