//
//  MCObjectToDic.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCObjectToDic.h"
#import <objc/runtime.h>

@implementation MCObjectToDic

BOOL isU;
NSMutableDictionary *zbjDic;

+ (NSMutableDictionary *)getObjectData:(id)obj upperFirstLetter:(BOOL)isUpper {
    isU = isUpper;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    if (!zbjDic) {
        zbjDic = [NSMutableDictionary dictionary];
    }
    for (int i = 0;i < propsCount; i++) {
        objc_property_t prop = props[i];
        id value = nil;
        @try {
            NSString *key = [NSString stringWithUTF8String:property_getName(prop)];
            NSString *keyAttribute = [NSString stringWithUTF8String:property_getAttributes(prop)];
            value = [self getObjectInternal:[obj valueForKey:key]];
            if (isUpper) {
                NSString *keyUpperString = [NSString stringWithFormat:@"%@%@",[[key substringToIndex:1] uppercaseString],[key substringFromIndex:1]];
                if ([[keyAttribute substringToIndex:2] isEqualToString:@"Tc"]) {
                    NSString *v = [NSString stringWithFormat:@"%@",value];
                    if ([v isEqualToString:@"0"]) {
                        [zbjDic setValue:[NSString stringWithFormat:@"\"%@\":false",keyUpperString] forKey:keyUpperString];
                    }else {
                        [zbjDic setValue:[NSString stringWithFormat:@"\"%@\":true",keyUpperString] forKey:keyUpperString];
                    }
                    [dic setValue:@"这是一个坑" forKey:keyUpperString];
                }else {
                    [dic setValue:value forKey:keyUpperString];
                }
            }else {
                if ([[keyAttribute substringToIndex:2] isEqualToString:@"Tc"]) {
                    NSString *v = [NSString stringWithFormat:@"%@",value];
                    if ([v isEqualToString:@"0"]) {
                        [zbjDic setValue:[NSString stringWithFormat:@"\"%@\":false",key] forKey:key];
                    }
                    else {
                        [zbjDic setValue:[NSString stringWithFormat:@"\"%@\":true",key] forKey:key];
                    }
                    [dic setValue:@"这是一个坑" forKey:key];
                }else {
                    //避免关键词
                    if ([key isEqualToString:@"Description"]) {
                        key = @"description";
                    }else if([key isEqualToString:@"ID"]){
                        key = @"id";
                    }else if(key.length >= 3){
                        if([[key substringToIndex:3] isEqualToString:@"NEW"]){
                            key = [NSString stringWithFormat:@"new%@",[key substringFromIndex:3]];
                        }
                    }
                    [dic setValue:value forKey:key];
                }
            }
        }
        @catch (NSException *exception) {
        }
    }
    [[NSUserDefaults standardUserDefaults]setObject:zbjDic forKey:@"kZBJDicForJson"];
    free(props);
    return dic;
}


+ (NSData *)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error {
    return [NSJSONSerialization dataWithJSONObject:[self getObjectData:obj upperFirstLetter:NO] options:options error:error];
}

+ (id)getObjectInternal:(id)obj {
    if(!obj
       || [obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]]) {
        return obj;
    }
    if([obj isKindOfClass:[NSArray class]]) {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for (int i = 0;i < objarr.count; i++) {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for (NSString *key in objdic.allKeys) {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj upperFirstLetter:isU];
}

@end

