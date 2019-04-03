//
//  MCHttpManager.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/2.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCHttpManager.h"
#import "AFHTTPSessionManager.h"

@implementation MCHttpManager {
    AFHTTPSessionManager *afHttpManager;
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
 初始化方法，配置AF属性
 */
- (id)init {
    if (self = [super init]) {
        afHttpManager = [AFHTTPSessionManager manager];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        [securityPolicy setValidatesDomainName:NO];
        securityPolicy.allowInvalidCertificates = YES;
        afHttpManager.securityPolicy = securityPolicy;
        afHttpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        afHttpManager.requestSerializer = [AFJSONRequestSerializer serializer];
        afHttpManager.requestSerializer.timeoutInterval = 120;
        afHttpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    }
    return self;
}

/**
 取消网络请求
 */
- (void)cancelNetwork {
    for (NSURLSessionDataTask *task in afHttpManager.dataTasks) {
        task.taskDescription = [NSString stringWithFormat:@"取消%ld",(long)self.lastPostCount];
    }
}

/**
 POST请求

 @param request 请求入参
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)postNetworkWithRequest:(MCBaseRequest *)request completeBlock:(CompletionBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    //组装网络请求param
    NSMutableDictionary *paramDic = [self dealWithRequestToJson:request];
    //设置超时时间
    afHttpManager.requestSerializer.timeoutInterval = request.timeoutInterval;
    [afHttpManager POST:request.methodURL parameters:paramDic headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([task.taskDescription isEqualToString:[NSString stringWithFormat:@"取消%ld",(long)self.postCount]]) {
            return;
        }
        //返回参数解析
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        successBlock(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSData *receiveData = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString *receiveStr = [[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
        NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"请求失败:%@",jsonDict);
        errorBlock(error);
    }];
}

/**
 GET请求

 @param request 请求入参
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getNetworkWithRequest:(MCBaseRequest *)request completeBlock:(CompletionBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    //组装网络请求param
    NSMutableDictionary *paramDic = [self dealWithRequestToJson:request];
    //设置超时时间
    afHttpManager.requestSerializer.timeoutInterval = request.timeoutInterval;
    [afHttpManager GET:request.methodURL parameters:paramDic headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([task.taskDescription isEqualToString:[NSString stringWithFormat:@"取消%ld",(long)self.postCount]]) {
            return;
        }
        //返回参数解析
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        successBlock(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSData *receiveData = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString *receiveStr = [[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
        NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"请求失败:%@",jsonDict);
        errorBlock(error);
    }];
}

/**
 处理网络请求参数

 @param request 入参Model
 @return 字典
 */
- (NSMutableDictionary *)dealWithRequestToJson:(MCBaseRequest *)request {
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    requestDic = [request encodeUpperFirstLetter:NO];
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestDic options:0 error:&parseError];
    if (!jsonData) {
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"\n=================================\n网络请求地址:%@\n网络请求入参:%@\n=================================",request.methodURL,jsonString);
    return requestDic;
}

@end
