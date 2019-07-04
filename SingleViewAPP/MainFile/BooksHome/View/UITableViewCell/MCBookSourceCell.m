//
//  MCBookSourceCell.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/20.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookSourceCell.h"

@interface MCBookSourceCell()

@property (nonatomic, strong) UILabel *sourceName;
@property (nonatomic, strong) UILabel *sourceChapterCount;
@property (nonatomic, strong) UILabel *sourceLastChapter;
@property (nonatomic, strong) UILabel *sourceUpdateTime;

@end

@implementation MCBookSourceCell

- (UILabel *)sourceName {
    if (!_sourceName) {
        _sourceName = [[UILabel alloc] init];
        _sourceName.font = [UIFont systemFontOfSize:14];
        _sourceName.textColor = MC_COLOR_HEX(0x333333);
        [self.contentView addSubview:_sourceName];
        MC_Weak_Self(self);
        [_sourceName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.contentView);
            make.left.equalTo(weakself.contentView).offset(20);
            make.height.mas_equalTo(27);
            make.width.mas_equalTo(MC_SCREEN_WIDTH - 40);
        }];
    }
    return _sourceName;
}

- (UILabel *)sourceChapterCount {
    if (!_sourceChapterCount) {
        _sourceChapterCount = [[UILabel alloc] init];
        _sourceChapterCount.font = [UIFont systemFontOfSize:14];
        _sourceChapterCount.textColor = MC_COLOR_HEX(0x333333);
        [self.contentView addSubview:_sourceChapterCount];
        MC_Weak_Self(self);
        [_sourceChapterCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.sourceName.mas_bottom);
            make.left.equalTo(weakself.contentView).offset(20);
            make.width.mas_equalTo(MC_SCREEN_WIDTH - 40);
            make.height.mas_equalTo(27);
        }];
    }
    return _sourceChapterCount;
}

- (UILabel *)sourceLastChapter {
    if (!_sourceLastChapter) {
        _sourceLastChapter = [[UILabel alloc] init];
        _sourceLastChapter.font = [UIFont systemFontOfSize:14];
        _sourceLastChapter.textColor = MC_COLOR_HEX(0x333333);
        [self.contentView addSubview:_sourceLastChapter];
        MC_Weak_Self(self);
        [_sourceLastChapter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.sourceChapterCount.mas_bottom);
            make.left.equalTo(weakself.contentView).offset(20);
            make.width.mas_equalTo(MC_SCREEN_WIDTH - 40);
            make.height.mas_equalTo(27);
        }];
    }
    return _sourceLastChapter;
}

- (UILabel *)sourceUpdateTime {
    if (!_sourceUpdateTime) {
        _sourceUpdateTime = [[UILabel alloc] init];
        _sourceUpdateTime.font = [UIFont systemFontOfSize:14];
        _sourceUpdateTime.textColor = MC_COLOR_HEX(0x333333);
        [self.contentView addSubview:_sourceUpdateTime];
        MC_Weak_Self(self);
        [_sourceUpdateTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.sourceLastChapter.mas_bottom);
            make.left.equalTo(weakself.contentView).offset(20);
            make.width.mas_equalTo(MC_SCREEN_WIDTH - 40);
            make.height.mas_equalTo(27);
            make.bottom.equalTo(weakself.contentView);
        }];
    }
    return _sourceUpdateTime;
}

- (void)initDataWithSourceModel:(MCBookSourceList *)sourceModel {
    self.sourceName.text = [NSString stringWithFormat:@"书籍来源:%@",sourceModel.name];
    self.sourceChapterCount.text = [NSString stringWithFormat:@"章节总数:%g",sourceModel.chaptersCount];
    self.sourceLastChapter.text = [NSString stringWithFormat:@"最新章节:%@",sourceModel.lastChapter];
    self.sourceUpdateTime.text = [NSString stringWithFormat:@"更新时间:%@",[[sourceModel.updated stringByReplacingOccurrencesOfString:@"T" withString:@" "] stringByReplacingOccurrencesOfString:@"Z" withString:@""]];
}

@end
