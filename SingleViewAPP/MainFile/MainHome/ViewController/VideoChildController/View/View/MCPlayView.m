//
//  MCPlayView.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/8.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCPlayView.h"

@implementation MCPlayView

@synthesize coverImageView = _coverImageView;
@synthesize playButton = _playButton;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) return nil;
    [self _setupViews];
    return self;
}

- (void)userClickedPlayButton {
    if ( _clickedPlayButtonExeBlock ) _clickedPlayButtonExeBlock(self);
}

- (void)_setupViews {
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.coverImageView];
    [self.coverImageView addSubview:self.playButton];
    
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.offset(0);
        make.bottom.offset(-8);
    }];
    
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (UIImageView *)coverImageView {
    if ( _coverImageView ) return _coverImageView;
    _coverImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"video_pic_bg"]];
    _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    _coverImageView.clipsToBounds = YES;
    _coverImageView.userInteractionEnabled = YES;
    _coverImageView.tag = 101;
    return _coverImageView;
}

- (UIButton *)playButton {
    if ( _playButton ) return _playButton;
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playButton setImage:[UIImage imageNamed:@"db_play_big"] forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(userClickedPlayButton) forControlEvents:UIControlEventTouchUpInside];
    return _playButton;
}


@end
