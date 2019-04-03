//
//  MCObjectToDic.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCObjectToDic : NSObject

//通过对象返回一个NSDictionary，键是属性名称，值是属性值。
+ (NSMutableDictionary *)getObjectData:(id)obj upperFirstLetter:(BOOL)isUpper;

//将getObjectData方法返回的NSDictionary转化成JSON
+ (NSData *)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error;

@end

NS_ASSUME_NONNULL_END
