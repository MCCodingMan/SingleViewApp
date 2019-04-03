//
//  MCBaseResponse.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCBaseResponse : NSObject<NSCoding>

- (void)decode:(NSDictionary *)jsonData;

- (NSMutableDictionary *)encode;

+ (NSDictionary *)objectClassInArray;

@end

NS_ASSUME_NONNULL_END
