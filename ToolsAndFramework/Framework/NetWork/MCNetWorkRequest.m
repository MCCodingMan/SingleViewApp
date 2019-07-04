//
//  MCNetWorkRequest.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCNetWorkRequest.h"
#import "MCQueryJockesRequest.h"
#import "MCBookSourceRequest.h"
#import "MCBookCompleteRequest.h"
#import "MCBookSearchRequest.h"

#define MC_NetWork [MCHttpManager shareManager]

@implementation MCNetWorkRequest

static MCNetWorkRequest *networkManager;

/**
 请求单列

 @return 单列对象
 */
+ (instancetype)shareRequest {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[MCNetWorkRequest alloc] init];
    });
    return networkManager;
}

/**
 2019.4.3 段子网络请求

 @param type 类型
 @param page 页数
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryJockesWithType:(int)type page:(int)page completionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock {
    MCQueryJockesRequest *request = [[MCQueryJockesRequest alloc] init];
    request.type = type;
    request.page = page;
    [MC_NetWork getNetworkWithRequest:request completeBlock:^(id  _Nonnull result) {
        successBlock(result);
    } errorBlock:^(NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

/**
 2019.5.13 请求小说分类

 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryCategoriesWithCompletionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock {
    MCQueryCategoriesRequest *request = [[MCQueryCategoriesRequest alloc] init];
    [MC_NetWork getNetworkWithRequest:request completeBlock:^(id  _Nonnull result) {
        successBlock(result);
    } errorBlock:^(NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

/**
 2019.5.15 请求分类小说列表
 
 @param request 小说分类请求model
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryCategoriesBookListWithRequst:(MCQueryCategoriesBooksListRequest *)request CompletionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock {
    [MC_NetWork getNetworkWithRequest:request completeBlock:^(id  _Nonnull result) {
        successBlock(result);
    } errorBlock:^(NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

/**
 2019.5.20 请求小说详情
 
 @param bookId 小说ID
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryBookInfoWithBookID:(NSString *)bookId CompletionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock {
    MCBaseRequest *request = [[MCBaseRequest alloc] init];
    request.methodURL = [NSString stringWithFormat:@"http://novel.juhe.im/book-info/%@",bookId];
    [MC_NetWork getNetworkWithRequest:request completeBlock:^(id  _Nonnull result) {
        successBlock(result);
    } errorBlock:^(NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

/**
 2019.5.20 请求小说书籍源
 
 @param bookId 小说ID
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryBookSourceWithBookID:(NSString *)bookId CompletionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock {
    MCBookSourceRequest *request = [[MCBookSourceRequest alloc] init];
    request.book = bookId;
    [MC_NetWork getNetworkWithRequest:request completeBlock:^(id  _Nonnull result) {
        successBlock(result);
    } errorBlock:^(NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

/**
 2019.5.20 请求小说章节
 
 @param sourceID 资源ID
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryBookChapterWithSourceID:(NSString *)sourceID CompletionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock {
    MCBaseRequest *request = [[MCBaseRequest alloc] init];
    request.methodURL = [NSString stringWithFormat:@"http://novel.juhe.im/book-chapters/%@",sourceID];
    [MC_NetWork getNetworkWithRequest:request completeBlock:^(id  _Nonnull result) {
        successBlock(result);
    } errorBlock:^(NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

/**
 2019.5.21 请求小说章节内容
 
 @param chapterLink 资源Link
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryBookChapterInfoWithChapterLink:(NSString *)chapterLink CompletionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock {
    MCBaseRequest *request = [[MCBaseRequest alloc] init];
    NSString *charactersToEscape = @":/&?=";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    /**
     使用预置的，如果不能满足要求，则使用自定义characterSetWithCharactersInString
     NSCharacterSet *allowedCharacters = [NSCharacterSet URLHostAllowedCharacterSet];
     URLHostAllowedCharacterSet      "#%/<>?@\^`{|}
     URLFragmentAllowedCharacterSet  "#%<>[\]^`{|}
     URLPasswordAllowedCharacterSet  "#%/:<>?@[\]^`{|}
     URLPathAllowedCharacterSet      "#%;<>?[\]^`{|}
     URLQueryAllowedCharacterSet     "#%<>[\]^`{|}
     URLUserAllowedCharacterSet      "#%/:<>?@[\]^`
     **/
    request.methodURL = [NSString stringWithFormat:@"http://novel.juhe.im/chapters/%@",[chapterLink stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters]];
    [MC_NetWork getNetworkWithRequest:request completeBlock:^(id  _Nonnull result) {
        successBlock(result);
    } errorBlock:^(NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

/**
 2019.5.28 请求文字补全
 
 @param keyWord 关键字
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)queryCompleteNameWithKeyWord:(NSString *)keyWord CompletionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock {
    MCBookCompleteRequest *request = [[MCBookCompleteRequest alloc] init];
    request.query = keyWord;
    [MC_NetWork getNetworkWithRequest:request completeBlock:^(id  _Nonnull result) {
        successBlock(result);
    } errorBlock:^(NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

/**
 2019.5.28 搜索小说
 
 @param keyWord 关键字
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)querySearchNameWithKeyWord:(NSString *)keyWord CompletionBlock:(CompletionBlock)successBlock faileBlock:(ErrorBlock)errorBlock {
    MCBookSearchRequest *request = [[MCBookSearchRequest alloc] init];
    request.keyword = keyWord;
    [MC_NetWork getNetworkWithRequest:request completeBlock:^(id  _Nonnull result) {
        successBlock(result);
    } errorBlock:^(NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

@end
