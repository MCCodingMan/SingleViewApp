//
//  MCBookChapterCell.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/20.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookChapterCell.h"

@interface MCBookChapterCell()

@end

@implementation MCBookChapterCell

- (UILabel *)sourceName {
    if (!_sourceName) {
        _sourceName = [[UILabel alloc] init];
        _sourceName.font = [UIFont systemFontOfSize:14];
        _sourceName.textColor = MC_COLOR_HEX(0x119DEE);
        [self.contentView addSubview:_sourceName];
        MC_Weak_Self(self);
        [_sourceName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself);
            make.left.equalTo(weakself.contentView).offset(20);
            make.height.mas_equalTo(27);
            make.width.mas_equalTo(MC_SCREEN_WIDTH - 40);
        }];
    }
    return _sourceName;
}

@end
