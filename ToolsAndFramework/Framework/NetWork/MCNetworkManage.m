//
//  MCNetworkManage.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/5.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCNetworkManage.h"

@interface MCNetworkManage()<NSURLSessionDataDelegate>

/**
 接受响应体信息
 */
@property (nonatomic, strong) NSMutableData *mc_responseData;

@property (nonatomic, strong) NSProgress *mc_dataTaskProgress;

@property (nonatomic, copy)  ProgressBlock taskProgressBlock;

@property (nonatomic, copy)  CompleteBlock taskCompleteBlock;

@property (nonatomic, copy)  ErrorBlock taskErrorBlock;

@property (nonatomic, strong) NSMutableArray<NSURLSessionTask *> *dataTaskArray;

@end

@implementation MCNetworkManage

static MCNetworkManage *mc_networkManager;

+ (MCNetworkManage *)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mc_networkManager = [[MCNetworkManage alloc] init];
    });
    return mc_networkManager;
}

- (void)mc_postRequest:(MCBaseRequest *)request progressBlock:(ProgressBlock)progressBlock completeBlock:(CompleteBlock)completeBlock errorBlock:(ErrorBlock)errorBlock {
    NSMutableURLRequest *mc_urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:request.methodURL]];
    [mc_urlRequest setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [mc_urlRequest setTimeoutInterval:request.timeoutInterval];
    [mc_urlRequest setHTTPMethod:@"POST"];
    [mc_urlRequest setHTTPBody:[self dealWithRequestToJson:request]];
    NSURLSession *mc_urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *mc_postDataTask = [mc_urlSession dataTaskWithRequest:mc_urlRequest];
    [self.dataTaskArray addObject:mc_postDataTask];
    self.taskProgressBlock = progressBlock;
    self.taskCompleteBlock = completeBlock;
    self.taskErrorBlock = errorBlock;
    [mc_postDataTask resume];
}

- (void)mc_getRequest:(MCBaseRequest *)request progressBlock:(ProgressBlock)progressBlock completeBlock:(CompleteBlock)completeBlock errorBlock:(ErrorBlock)errorBlock {
    NSString *urlString = request.methodURL;
    NSString *paramsString = @"";
    NSMutableDictionary *requestDic = [request encodeUpperFirstLetter:NO];
    for (int i = 0; i < requestDic.allKeys.count; i++) {
        if (![requestDic.allKeys[i] isEqualToString:@"methodURL"] && ![requestDic.allKeys[i] isEqualToString:@"timeoutInterval"]) {
            if (![paramsString containsString:@"?"]) {
                paramsString = [NSString stringWithFormat:@"%@?%@=%@",paramsString,requestDic.allKeys[i],[requestDic valueForKey:requestDic.allKeys[i]]];
            }else{
                paramsString = [NSString stringWithFormat:@"%@&%@=%@",paramsString,requestDic.allKeys[i],[requestDic valueForKey:requestDic.allKeys[i]]];
            }
        }
    }
    if (paramsString.length > 0) {
        urlString = [NSString stringWithFormat:@"%@%@",urlString,paramsString];
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    NSMutableURLRequest *mc_urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [mc_urlRequest setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [mc_urlRequest setTimeoutInterval:request.timeoutInterval];
    [mc_urlRequest setHTTPMethod:@"GET"];
    NSURLSession *mc_urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *mc_getDataTask = [mc_urlSession dataTaskWithRequest:mc_urlRequest];
    [self.dataTaskArray addObject:mc_getDataTask];
    self.taskProgressBlock = progressBlock;
    self.taskCompleteBlock = completeBlock;
    self.taskErrorBlock = errorBlock;
    [mc_getDataTask resume];
}

/**
 *  请求结束或者是失败的时候调用
 *
 *  @param session           会话对象
 *  @param task              请求任务
 *  @param error             错误信息
 */
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if ([self.dataTaskArray containsObject:task]) {
        [self.dataTaskArray removeObject:task];
        if (error) {
            self.taskErrorBlock(error);
        }else{
            NSError *jsonError = nil;
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:self.mc_responseData options:NSJSONReadingAllowFragments error:&error];
            if (jsonError) {
                self.taskErrorBlock(jsonError);
            }else{
                self.taskCompleteBlock(responseDic);
            }
        }
    }
}

/**
 *  接收到服务器返回的数据 调用多次
 *
 *  @param session           会话对象
 *  @param dataTask          请求任务
 *  @param data              本次下载的数据
 */
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    if ([self.dataTaskArray containsObject:dataTask]) {
        [self.mc_responseData appendData:data];
        self.mc_dataTaskProgress.completedUnitCount = dataTask.countOfBytesReceived;
        self.taskProgressBlock(self.mc_dataTaskProgress);
    }
}

/**
 *  1.接收到服务器的响应 它默认会取消该请求
 *
 *  @param session           会话对象
 *  @param dataTask          请求任务
 *  @param response          响应头信息
 *  @param completionHandler 回调 传给系统
 */
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    /*
     NSURLSessionResponseCancel = 0,取消 默认
     NSURLSessionResponseAllow = 1, 接收
     NSURLSessionResponseBecomeDownload = 2, 变成下载任务
     NSURLSessionResponseBecomeStream        变成流
     */
    self.mc_responseData = nil;
    if (![self.dataTaskArray containsObject:dataTask]) {
        completionHandler(NSURLSessionResponseCancel);
    }else{
        completionHandler(NSURLSessionResponseAllow);
        self.mc_dataTaskProgress.totalUnitCount = dataTask.countOfBytesExpectedToReceive;
        self.taskProgressBlock(self.mc_dataTaskProgress);
    }
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

-(NSMutableData *)mc_responseData {
    if (!_mc_responseData) {
        _mc_responseData = [[NSMutableData alloc] init];
    }
    return _mc_responseData;
}

-(NSProgress *)mc_dataTaskProgress {
    if (!_mc_responseData) {
        _mc_dataTaskProgress = [[NSProgress alloc] init];
        _mc_dataTaskProgress.totalUnitCount = 0;
        _mc_dataTaskProgress.completedUnitCount = 0;
    }
    return _mc_dataTaskProgress;
}

-(NSMutableArray<NSURLSessionTask *> *)dataTaskArray {
    if (!_dataTaskArray) {
        _dataTaskArray = [[NSMutableArray alloc] init];
    }
    return _dataTaskArray;
}

@end
