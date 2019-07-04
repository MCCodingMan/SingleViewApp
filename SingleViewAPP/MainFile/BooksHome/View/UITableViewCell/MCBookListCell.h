//
//  MCBookListCell.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/17.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseTableViewCell.h"
#import "MCCategoriesBooksList.h"
#import "MCBookInfoResponse.h"
#import "MCBookSearchResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCBookListCell : MCBaseTableViewCell

- (void)initBookListInfoWithModel:(MCCategoriesBooksList *)bookModel;

- (void)initBookChapterInfoWithModel:(MCBookInfoResponse *)bookModel;

- (void)initBookSearchInfoWithModel:(MCBookSearchListResponse *)bookModel;

@end

NS_ASSUME_NONNULL_END
