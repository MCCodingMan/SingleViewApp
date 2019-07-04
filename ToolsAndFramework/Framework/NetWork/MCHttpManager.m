//
//  MCHttpManager.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/2.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCHttpManager.h"
#import "MCNetworkManage.h"

@implementation MCHttpManager {
//    AFHTTPSessionManager *afHttpManager;
}

static MCHttpManager *httpManager;

/**
 网络请求管理单例

 @return 单例
 */
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpManager = [[MCHttpManager alloc] init];
    });
    return httpManager;
}

/**
 取消网络请求
 */
- (void)cancelNetwork {
//    for (NSURLSessionDataTask *task in afHttpManager.dataTasks) {
//        task.taskDescription = [NSString stringWithFormat:@"取消%ld",(long)self.lastPostCount];
//    }
}

/**
 初始化方法，配置AF属性
 */
- (id)init {
    if (self = [super init]) {
//        afHttpManager = [AFHTTPSessionManager manager];
//        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//        [securityPolicy setValidatesDomainName:NO];
//        securityPolicy.allowInvalidCertificates = YES;
//        afHttpManager.securityPolicy = securityPolicy;
//        afHttpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        afHttpManager.requestSerializer = [AFJSONRequestSerializer serializer];
//        afHttpManager.requestSerializer.timeoutInterval = 120;
//        afHttpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    }
    return self;
}

/**
 POST请求

 @param request 请求入参
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)postNetworkWithRequest:(MCBaseRequest *)request completeBlock:(CompletionBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [[[MCNetworkManage alloc] init] mc_postRequest:request progressBlock:^(NSProgress *dataTaskProgress) {
        NSLog(@"当前进度:%lld/%lld",dataTaskProgress.completedUnitCount,dataTaskProgress.totalUnitCount);
    } completeBlock:^(NSDictionary *dataTaskResult) {
        //解析返参
//        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        successBlock(dataTaskResult);
    } errorBlock:^(NSError *error) {
        NSData *receiveData = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString *receiveStr = [[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
        NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"请求失败:%@",jsonDict);
        errorBlock(error);
    }];
//    [[MCNetworkManage alloc] init] POST:request.methodURL parameters:[request encodeUpperFirstLetter:NO] headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"当前进度:%lld/%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        //如果取消了网络请求，则直接忽略请求结果
//        if ([task.taskDescription isEqualToString:[NSString stringWithFormat:@"取消%ld",(long)self.postCount]]) {
//            return ;
//        }
//        //解析返参
//        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
//        successBlock(dic);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSData *receiveData = error.userInfo[@"com.alamofire.serialization.response.error.data"];
//        NSString *receiveStr = [[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
//        NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"请求失败:%@",jsonDict);
//        errorBlock(error);
//    }];
    
}

/**
 GET请求

 @param request 请求入参
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getNetworkWithRequest:(MCBaseRequest *)request completeBlock:(CompletionBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [[[MCNetworkManage alloc] init] mc_getRequest:request progressBlock:^(NSProgress *dataTaskProgress) {
        NSLog(@"当前进度:%lld/%lld",dataTaskProgress.completedUnitCount,dataTaskProgress.totalUnitCount);
    } completeBlock:^(NSDictionary *dataTaskResult) {
        successBlock(dataTaskResult);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
//    [afHttpManager GET:request.methodURL parameters:[request encodeUpperFirstLetter:NO] headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"当前进度:%lld/%lld",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        //如果取消了网络请求，则直接忽略请求结果
//        if ([task.taskDescription isEqualToString:[NSString stringWithFormat:@"取消%ld",(long)self.postCount]]) {
//            return ;
//        }
//        //解析返参
//        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
//        successBlock(dic);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        errorBlock(error);
//    }];
}

/**
 处理网络请求参数
 
 @param request 入参Model
 @return 字典
 */
- (NSData *)dealWithRequestToJson:(MCBaseRequest *)request {
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    requestDic = [request encodeUpperFirstLetter:NO];
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestDic options:0 error:&parseError];
    if (!jsonData) {
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"\n网络请求地址:%@\n网络请求入参:%@\n",request.methodURL,jsonString);
    return jsonData;
}

@end
