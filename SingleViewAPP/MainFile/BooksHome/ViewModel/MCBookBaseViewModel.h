//
//  MCBookBaseViewModel.h
//  SingleViewAPP
//
//  Created by wr on 2019/5/16.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface MCBookBaseViewModel : NSObject

@property (nonatomic, strong) RACCommand *jumpCommand;

@end

NS_ASSUME_NONNULL_END
