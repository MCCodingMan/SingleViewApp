//
//  MCImageTableViewCell.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/4.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCImageTableViewCell.h"

@implementation MCImageTableViewCell {
    UIImageView *_headerImageView;
    UILabel *_namelabel;
    UILabel *_passtimeLabel;
    UILabel *_lineLabel;
    UILabel *_textLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    MC_Weak_Self(self);
    UIView *bgView = [[UIView alloc] init];
    MC_ViewRadius(bgView, 6);
    bgView.backgroundColor = MC_COLOR_RGBA(255, 255, 255, 0.7);
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakself.contentView).offset(8);
        make.right.bottom.equalTo(weakself.contentView).offset(-8);
    }];
    _headerImageView = [[UIImageView alloc] init];
    MC_ViewRadius(_headerImageView, 25);
    [bgView addSubview:_headerImageView];
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(8);
        make.left.equalTo(bgView).offset(12);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    _namelabel = [[UILabel alloc] init];
    _namelabel.font = MC_UIFont(16);
    [bgView addSubview:_namelabel];
    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self->_headerImageView);
        make.left.equalTo(self->_headerImageView.mas_right).offset(12);
    }];
    _passtimeLabel = [[UILabel alloc] init];
    _passtimeLabel.font = MC_UIFont(14);
    _passtimeLabel.textColor = MC_COLOR_RGB(53, 53, 53);
    [bgView addSubview:_passtimeLabel];
    [_passtimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-12);
        make.bottom.equalTo(self->_headerImageView);
    }];
    _lineLabel = [[UILabel alloc] init];
    _lineLabel.backgroundColor = MC_COLOR_RGB(240, 240, 240);
    [bgView addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.equalTo(self->_passtimeLabel.mas_bottom).offset(8);
        make.left.equalTo(bgView).offset(12);
        make.right.equalTo(bgView).offset(-12);
    }];
    _textLabel = [[UILabel alloc] init];
    _textLabel.font = MC_UIFont(16);
    [bgView addSubview:_textLabel];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_lineLabel.mas_bottom).offset(8);
        make.left.equalTo(bgView).offset(12);
        make.right.equalTo(bgView).offset(-12);
    }];
    self.contentImageView = [[UIImageView alloc] init];
    MC_ViewRadius(self.contentImageView, 3);
    [bgView addSubview:_contentImageView];
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_textLabel.mas_bottom).offset(8);
        make.left.equalTo(bgView).offset(12);
        make.right.equalTo(bgView).offset(-12);
        make.bottom.equalTo(bgView).offset(8);
    }];
}

- (void)setCellData:(MCQueryJockesResponse *)cellData {
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:cellData.header]];
    _namelabel.text = cellData.username;
    _passtimeLabel.text = cellData.passtime;
    _textLabel.text = cellData.text;
}

@end
