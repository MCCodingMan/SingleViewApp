//
//  MCBookListCell.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/17.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookListCell.h"

@interface MCBookListCell()
@property (nonatomic, strong) UIImageView *bookCover;
@property (nonatomic, strong) UILabel *bookTitle;
@property (nonatomic, strong) UILabel *bookAuthor;
@property (nonatomic, strong) UILabel *bookCate;
@property (nonatomic, strong) UILabel *bookLastChapter;
@property (nonatomic, strong) UILabel *bookLatelyFollower;
@property (nonatomic, strong) UILabel *bookRetentionRatio;
@end

@implementation MCBookListCell

-(UIImageView *)bookCover {
    if (!_bookCover) {
        _bookCover = [[UIImageView alloc] init];
        _bookCover.contentMode = UIViewContentModeScaleAspectFit;
        _bookCover.layer.cornerRadius = 8;
        _bookCover.layer.masksToBounds = YES;
        [self.contentView addSubview:_bookCover];
        MC_Weak_Self(self);
        [_bookCover mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.contentView).offset(12);
            make.top.equalTo(weakself.contentView).offset(8);
            make.bottom.equalTo(weakself.contentView).offset(-8).priority(999);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(164);
        }];
    }
    return _bookCover;
}

- (UILabel *)bookTitle {
    if (!_bookTitle) {
        _bookTitle = [[UILabel alloc] init];
        _bookTitle.font = [UIFont systemFontOfSize:14];
        _bookTitle.textColor = MC_COLOR_HEX(0x333333);
        [self.contentView addSubview:_bookTitle];
        MC_Weak_Self(self);
        [_bookTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.bookCover);
            make.left.equalTo(weakself.bookCover.mas_right).offset(10);
            make.right.equalTo(weakself.contentView);
            make.height.mas_equalTo(27);
        }];
    }
    return _bookTitle;
}

-(UILabel *)bookAuthor {
    if (!_bookAuthor) {
        _bookAuthor = [[UILabel alloc] init];
        _bookAuthor.font = [UIFont systemFontOfSize:14];
        _bookAuthor.textColor = MC_COLOR_HEX(0x333333);
        [self.contentView addSubview:_bookAuthor];
        MC_Weak_Self(self);
        [_bookAuthor mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.bookTitle.mas_bottom);
            make.left.equalTo(weakself.bookCover.mas_right).offset(10);
            make.right.equalTo(weakself.contentView);
            make.height.mas_equalTo(27);
        }];
    }
    return _bookAuthor;
}

-(UILabel *)bookCate {
    if (!_bookCate) {
        _bookCate = [[UILabel alloc] init];
        _bookCate.font = [UIFont systemFontOfSize:14];
        _bookCate.textColor = MC_COLOR_HEX(0x333333);
        [self.contentView addSubview:_bookCate];
        MC_Weak_Self(self);
        [_bookCate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.bookAuthor.mas_bottom);
            make.left.equalTo(weakself.bookCover.mas_right).offset(10);
            make.right.equalTo(weakself.contentView).offset(-8);
            make.height.mas_equalTo(27);
        }];
    }
    return _bookCate;
}

-(UILabel *)bookLastChapter {
    if (!_bookLastChapter) {
        _bookLastChapter = [[UILabel alloc] init];
        _bookLastChapter.font = [UIFont systemFontOfSize:14];
        _bookLastChapter.textColor = MC_COLOR_HEX(0x333333);
        [self.contentView addSubview:_bookLastChapter];
        MC_Weak_Self(self);
        [_bookLastChapter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.bookCate.mas_bottom);
            make.left.equalTo(weakself.bookCover.mas_right).offset(10);
            make.right.equalTo(weakself.contentView).offset(-8);
            make.height.mas_equalTo(27);
        }];
    }
    return _bookLastChapter;
}

-(UILabel *)bookLatelyFollower {
    if (!_bookLatelyFollower) {
        _bookLatelyFollower = [[UILabel alloc] init];
        _bookLatelyFollower.font = [UIFont systemFontOfSize:14];
        _bookLatelyFollower.textColor = MC_COLOR_HEX(0x333333);
        [self.contentView addSubview:_bookLatelyFollower];
        MC_Weak_Self(self);
        [_bookLatelyFollower mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.bookLastChapter.mas_bottom);
            make.left.equalTo(weakself.bookCover.mas_right).offset(10);
            make.right.equalTo(weakself.contentView).offset(-8);
            make.height.mas_equalTo(27);
        }];
    }
    return _bookLatelyFollower;
}

-(UILabel *)bookRetentionRatio {
    if (!_bookRetentionRatio) {
        _bookRetentionRatio = [[UILabel alloc] init];
        _bookRetentionRatio.font = [UIFont systemFontOfSize:14];
        _bookRetentionRatio.textColor = MC_COLOR_HEX(0x333333);
        [self.contentView addSubview:_bookRetentionRatio];
        MC_Weak_Self(self);
        [_bookRetentionRatio mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.bookLatelyFollower.mas_bottom);
            make.left.equalTo(weakself.bookCover.mas_right).offset(10);
            make.right.equalTo(weakself.contentView).offset(-8);
            make.height.mas_equalTo(27);
        }];
    }
    return _bookRetentionRatio;
}

- (void)initBookListInfoWithModel:(MCCategoriesBooksList *)bookModel {
    [self.bookCover sd_setImageWithURL:[NSURL URLWithString:[bookModel.cover substringFromIndex:7].stringByRemovingPercentEncoding] placeholderImage:MC_ImageWithName(@"") options:SDWebImageRetryFailed];
    self.bookTitle.text = [NSString stringWithFormat:@"书名：《%@》",bookModel.title];
    self.bookAuthor.text = [NSString stringWithFormat:@"作者：%@",bookModel.author];
    self.bookCate.text = [NSString stringWithFormat:@"分类：%@-%@",bookModel.majorCate,bookModel.minorCate];
    self.bookLastChapter.text = [NSString stringWithFormat:@"最新：%@",bookModel.lastChapter];
    self.bookLatelyFollower.text = [NSString stringWithFormat:@"%g人在读",bookModel.latelyFollower];
    self.bookRetentionRatio.text = [NSString stringWithFormat:@"%g%%追更",bookModel.retentionRatio];
}

- (void)initBookChapterInfoWithModel:(MCBookInfoResponse *)bookModel {
    [self.bookCover sd_setImageWithURL:[NSURL URLWithString:[bookModel.cover substringFromIndex:7].stringByRemovingPercentEncoding] placeholderImage:MC_ImageWithName(@"") options:SDWebImageRetryFailed];
    self.bookTitle.text = [NSString stringWithFormat:@"书名：《%@》",bookModel.title];
    self.bookAuthor.text = [NSString stringWithFormat:@"作者：%@",bookModel.author];
    self.bookCate.text = [NSString stringWithFormat:@"分类：%@-%@",bookModel.majorCateV2,bookModel.minorCateV2];
    self.bookLastChapter.text = [NSString stringWithFormat:@"最新：%@",bookModel.lastChapter];
    self.bookLatelyFollower.text = [NSString stringWithFormat:@"%g人在读",bookModel.latelyFollower];
    self.bookRetentionRatio.text = [NSString stringWithFormat:@"%g%%追更",[bookModel.retentionRatio doubleValue]];
}

- (void)initBookSearchInfoWithModel:(MCBookSearchListResponse *)bookModel {
    [self.bookCover sd_setImageWithURL:[NSURL URLWithString:[bookModel.cover substringFromIndex:7].stringByRemovingPercentEncoding] placeholderImage:MC_ImageWithName(@"") options:SDWebImageRetryFailed];
    self.bookTitle.text = [NSString stringWithFormat:@"书名：《%@》",bookModel.title];
    self.bookAuthor.text = [NSString stringWithFormat:@"作者：%@",bookModel.author];
    self.bookCate.text = [NSString stringWithFormat:@"分类：%@",bookModel.cat];
    self.bookLastChapter.text = [NSString stringWithFormat:@"最新：%@",bookModel.lastChapter];
    self.bookLatelyFollower.text = [NSString stringWithFormat:@"%g人在读",bookModel.latelyFollower];
    self.bookRetentionRatio.text = [NSString stringWithFormat:@"%g%%追更",bookModel.retentionRatio];
}
@end
