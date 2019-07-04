//
//  MCBookChapterTextViewModel.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/21.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookBaseViewModel.h"
#import "MCBookChapterResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookChapterTextViewModel : MCBookBaseViewModel<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MCBookChapterResponse *chapterResponse;

@property (nonatomic, assign) NSInteger chapterIndex;

- (void)queryChapterInfoWithLink:(NSString *)chapterLink complete:(void(^)(void))complete faile:(void(^)(void))faile;

@end

NS_ASSUME_NONNULL_END
