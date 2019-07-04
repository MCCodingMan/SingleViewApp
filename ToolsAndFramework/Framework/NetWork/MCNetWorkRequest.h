//
//  MCNetWorkRequest.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCHttpManager.h"
#import "MCQueryCategoriesRequest.h"
#import "MCQueryCategoriesBooksListRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCNetWorkRequest : NSObject

/**
 请求单列
 
 @return 单列对象
 */
+ (instancetype)shareRequest;

/**
 2019.4.3 段子网络请求
 
 @param type 类型
 @param page 页数
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryJockesWithType:(int)type page:(int)page completionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock;

/**
 2019.5.13 请求小说分类
 
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryCategoriesWithCompletionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock;

/**
 2019.5.15 请求分类小说列表
 
 @param request 小说分类请求model
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryCategoriesBookListWithRequst:(MCQueryCategoriesBooksListRequest *)request CompletionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock;

/**
 2019.5.20 请求小说详情
 
 @param bookId 小说ID
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryBookInfoWithBookID:(NSString *)bookId CompletionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock;

/**
 2019.5.20 请求小说书籍源
 
 @param bookId 小说ID
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryBookSourceWithBookID:(NSString *)bookId CompletionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock;

/**
 2019.5.20 请求小说章节
 
 @param sourceID 资源ID
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryBookChapterWithSourceID:(NSString *)sourceID CompletionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock;

/**
 2019.5.21 请求小说章节内容
 
 @param chapterLink 资源Link
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryBookChapterInfoWithChapterLink:(NSString *)chapterLink CompletionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock;

/**
 2019.5.28 请求文字补全
 
 @param keyWord 关键字
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryCompleteNameWithKeyWord:(NSString *)keyWord CompletionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock;

/**
 2019.5.28 搜索小说
 
 @param keyWord 关键字
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)querySearchNameWithKeyWord:(NSString *)keyWord CompletionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock;

@end

NS_ASSUME_NONNULL_END
