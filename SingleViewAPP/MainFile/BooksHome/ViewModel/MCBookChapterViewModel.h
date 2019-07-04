//
//  MCBookChapterViewModel.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/20.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookChapterViewModel : MCBookBaseViewModel<UITableViewDelegate, UITableViewDataSource>

- (void)queryBookChapterWithBookId:(NSString *)sourceId success:(void(^)(void))complete faile:(void(^)(void))faile;

@end

NS_ASSUME_NONNULL_END
