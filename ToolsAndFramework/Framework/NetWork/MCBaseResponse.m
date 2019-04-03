//
//  MCBaseResponse.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBaseResponse.h"
#import "MCObjectToDic.h"
#import <objc/runtime.h>


#define INDENT(x) for (int i = 0; i < (x); ++i) { [descriptions appendString:@"\t"]; }

@implementation MCBaseResponse

#pragma mark - Decode Methods

- (void)decode:(NSDictionary *)jsonData {
    @try{
        if (jsonData && ![jsonData isKindOfClass:[NSNull class]]) {
            [self setValuesForKeysWithDictionary:jsonData];
        }
    }@catch(NSException *e){
        NSLog(@"字典解析失败！");
    }
}

- (NSMutableDictionary *)encode {
    NSMutableDictionary *dic = [MCObjectToDic getObjectData:self upperFirstLetter:NO];
    return dic;
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key {
    if ([[self valueForKey:key] isKindOfClass:[MCBaseResponse class]]) {
        MCBaseResponse *response = [[[[self valueForKey:key] class] alloc] init];
        [response decode:value];
        value = response;
    }
    if ([value isKindOfClass:[NSArray class]]) {
        if ([[self class] objectClassInArray]) {
            if ([[[self class] objectClassInArray][key] isSubclassOfClass:[MCBaseResponse class]]) {
                //重新给数组赋值
                NSMutableArray *dataList = [[NSMutableArray alloc] init];
                for (NSMutableDictionary *dic in value) {
                    MCBaseResponse *response = [[[[[self class] objectClassInArray][key] class] alloc] init];
                    [response decode:dic];
                    [dataList addObject:response];
                }
                value = dataList;
            }
        }
    }
    //避免关键词
    if ([key isEqualToString:@"description"]) {
        key = @"Description";
    }else if([key isEqualToString:@"id"]){
        key = @"ID";
    }else if(key.length >= 3){
        if([[key substringToIndex:3] isEqualToString:@"new"]){
            key = [NSString stringWithFormat:@"NEW%@",[key substringFromIndex:3]];
        }
    }
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}

- (void)setNilValueForKey:(NSString *)key {
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([self class], &propsCount);
    for(int i = 0;i < propsCount; i++) {
        objc_property_t prop = props[i];
        id value = nil;
        NSString *key = [NSString stringWithUTF8String:property_getName(prop)];
        value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int propsCount;
        objc_property_t *props = class_copyPropertyList([self class], &propsCount);
        for (int i = 0;i < propsCount; i++) {
            objc_property_t prop = props[i];
            NSString *key = [NSString stringWithUTF8String:property_getName(prop)];
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
    }
    return self;
}

#pragma mark - Description

- (NSString *)descriptions {
    return [self descriptionFromPropertyList:0];
}

- (NSString *)descriptionFromPropertyList:(NSInteger)indent {
    NSMutableString *descriptions = [[NSMutableString alloc] init];
    unsigned int count = 0;
    objc_objectptr_t *pList = (objc_objectptr_t *)class_copyPropertyList([self class], &count);
    INDENT(indent);
    [descriptions appendFormat:@"%@ {\n", [self class]];
    for (int i = 0; i < count; ++i) {
        NSString *key = [NSString stringWithFormat:@"%s", property_getName((objc_property_t)pList[i])];
        id value = [self valueForKey:key];
        INDENT(indent + 1);
        if ([value isKindOfClass:[NSArray class]]) {
            [descriptions appendString:@"Array [\n"];
            [descriptions appendFormat:@"%@", [self descriptionFromArray:value indent:indent + 1]];
            INDENT(indent + 1);
            [descriptions appendString:@"]\n"];
        } else if ([value isKindOfClass:[NSString class]]) {
            [descriptions appendFormat:@"%@:%@\n", key, value];
        } else {
            [descriptions appendFormat:@"%@:%@\n",key, [value descriptions]];
        }
    }
    INDENT(indent);
    [descriptions appendString:@"}\n"];
    return descriptions;
}

- (NSString *)descriptionFromArray:(NSArray *)array indent:(NSInteger)indent {
    NSMutableString *descriptions = [[NSMutableString alloc] init];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[MCBaseResponse class]]) {
            [descriptions appendFormat:@"%@", [obj descriptionFromPropertyList:indent]];
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            [descriptions appendFormat:@"%@", [self descriptionFromDictionary:obj indent:indent + 1]];
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            INDENT(indent + 1);
            [descriptions appendFormat:@"%@\n", [obj descriptions]];
        } else {
            [descriptions appendFormat:@"%@", [obj descriptions]];
        }
    }];
    return descriptions;
}

- (NSString *)descriptionFromDictionary:(NSDictionary *)dictionary indent:(NSInteger)indent {
    NSMutableString *descriptions = [[NSMutableString alloc] init];
    NSArray *keys = [dictionary allKeys];
    INDENT(indent);
    [descriptions appendString:@"{"];
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [descriptions appendFormat:@"%@:%@ ", obj, dictionary[obj]];
    }];
    [descriptions appendString:@"}\n"];
    return descriptions;
}

+ (NSDictionary *)objectClassInArray {
    return [NSDictionary new];
}

@end

