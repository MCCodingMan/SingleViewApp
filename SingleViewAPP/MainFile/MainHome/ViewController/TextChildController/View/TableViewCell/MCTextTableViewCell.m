//
//  MCTextTableViewCell.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCTextTableViewCell.h"

@implementation MCTextTableViewCell {
    UIView *_mainContentView;
    UIImageView *_headerImageView;
    UILabel *_nameLabel;
    UILabel *_passTimeLabel;
    UILabel *_topLineLabel;
    UILabel *_textLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    MC_Weak_Self(self);
    _mainContentView = [[UIView alloc] init];
    MC_ViewRadius(_mainContentView, 6);
    _mainContentView.backgroundColor = MC_COLOR_RGBA(255, 255, 255, 0.7);
    [self.contentView addSubview:_mainContentView];
    [_mainContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakself.contentView).offset(8);
        make.right.bottom.equalTo(weakself.contentView).offset(-8);
    }];
    
    _headerImageView = [[UIImageView alloc] init];
    MC_ViewRadius(_headerImageView, 25);
    [_mainContentView addSubview:_headerImageView];
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_mainContentView).offset(8);
        make.left.equalTo(self->_mainContentView).offset(12);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = MC_UIFont(16);
    [_mainContentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_headerImageView.mas_right).offset(12);
        make.centerY.equalTo(self->_headerImageView);
    }];
    
    _passTimeLabel = [[UILabel alloc] init];
    _passTimeLabel.font = MC_UIFont(14);
    _passTimeLabel.textColor = MC_COLOR_RGB(53, 53, 53);
    [_mainContentView addSubview:_passTimeLabel];
    [_passTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self->_mainContentView).offset(-12);
        make.bottom.equalTo(self->_headerImageView.mas_bottom);
    }];
    
    _topLineLabel = [[UILabel alloc] init];
    _topLineLabel.backgroundColor = MC_COLOR_RGB(240, 240, 240);
    [_mainContentView addSubview:_topLineLabel];
    [_topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_passTimeLabel.mas_bottom).offset(8);
        make.left.equalTo(self->_mainContentView).offset(12);
        make.right.equalTo(self->_mainContentView).offset(-12);
        make.height.mas_equalTo(1);
    }];
    
    _textLabel = [[UILabel alloc] init];
    _textLabel.numberOfLines = 0;
    _textLabel.font = MC_UIFont(16);
    [_mainContentView addSubview:_textLabel];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_mainContentView).offset(12);
        make.right.equalTo(self->_mainContentView).offset(-12);
        make.top.equalTo(self->_topLineLabel.mas_bottom).offset(8);
        make.bottom.equalTo(self->_mainContentView).offset(-8);
    }];
}

- (void)setDataModel:(MCQueryJockesResponse *)dataModel {
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.header]];
    _nameLabel.text = dataModel.username;
    _passTimeLabel.text = dataModel.passtime;
    _textLabel.text = dataModel.text;
}
@end
