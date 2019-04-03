//
//  MCBaseRequest.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/2.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCBaseRequest : NSObject
//请求URL
@property (nonatomic, strong) NSString *methodURL;
//请求方法
@property (nonatomic, strong) NSString *method;
//超时时间
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
//跳过自动报错提示
@property (nonatomic, assign) BOOL skipErrorAlert;

- (NSMutableDictionary *)encodeUpperFirstLetter:(BOOL)isUpper;

@end
