//
//  MCJockesViewModel.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCQueryJockesResultResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCJockesViewModel : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) MCQueryJockesResultResponse *jockeResponse;

- (void)queryJockes:(void(^)(void))complete faile:(void(^)(void))fail;

@end

NS_ASSUME_NONNULL_END
