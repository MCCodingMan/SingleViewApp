//
//  MCLoadingView.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/22.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCLoadingView.h"

@interface MCLoadingView()

@property (nonatomic, strong) NSMutableArray<UIImageView *> *imageArr;

@end

@implementation MCLoadingView {
    NSTimer *timer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backGroundImage = MC_ImageWithName(@"bg_pic_002");
        
    }
    return self;
}

- (void)initImageArr {
    MC_Weak_Self(self);
    self.imageArr = [[NSMutableArray alloc] init];
    for (int i = 1; i < 6; i ++) {
        NSString *imageString = [NSString stringWithFormat:@"icon_pic_01%d",i];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:MC_ImageWithName(imageString)];
        imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:imageView];
        [self.imageArr addObject:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself);
            make.centerX.equalTo(weakself).offset(60 * (i - 3));
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
    }
}

- (void)startLoadingAnimation {
    [self initImageArr];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->timer = [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(loadingAnimation) userInfo:nil repeats:YES];
        [self->timer setFireDate:[NSDate distantPast]];
    });
}

- (void)loadingAnimation {
    MC_Weak_Self(self);
    [UIView animateWithDuration:0.65 animations:^{
        weakself.imageArr[0].image = MC_ImageWithName(@"icon_pic_006");
        [weakself.imageArr[0] mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself).offset(-20);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.65 animations:^{
            [weakself.imageArr[0] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(weakself);
            }];
            weakself.imageArr[0].image = MC_ImageWithName(@"icon_pic_011");
            weakself.imageArr[1].image = MC_ImageWithName(@"icon_pic_007");
            [UIView animateWithDuration:0.65 animations:^{
                [weakself.imageArr[1] mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(weakself).offset(-20);
                }];
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.65 animations:^{
                    [weakself.imageArr[1] mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.centerY.equalTo(weakself);
                    }];
                    weakself.imageArr[1].image = MC_ImageWithName(@"icon_pic_012");
                    weakself.imageArr[2].image = MC_ImageWithName(@"icon_pic_008");
                    [UIView animateWithDuration:0.65 animations:^{
                        [weakself.imageArr[2] mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.centerY.equalTo(weakself).offset(-20);
                        }];
                        [self layoutIfNeeded];
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.65 animations:^{
                            [weakself.imageArr[2] mas_updateConstraints:^(MASConstraintMaker *make) {
                                make.centerY.equalTo(weakself);
                            }];
                            weakself.imageArr[2].image = MC_ImageWithName(@"icon_pic_013");
                            weakself.imageArr[3].image = MC_ImageWithName(@"icon_pic_009");
                            [UIView animateWithDuration:0.65 animations:^{
                                [weakself.imageArr[3] mas_updateConstraints:^(MASConstraintMaker *make) {
                                    make.centerY.equalTo(weakself).offset(-20);
                                }];
                                [self layoutIfNeeded];
                            } completion:^(BOOL finished) {
                                [UIView animateWithDuration:0.65 animations:^{
                                    [weakself.imageArr[3] mas_updateConstraints:^(MASConstraintMaker *make) {
                                        make.centerY.equalTo(weakself);
                                    }];
                                    weakself.imageArr[3].image = MC_ImageWithName(@"icon_pic_014");
                                    weakself.imageArr[4].image = MC_ImageWithName(@"icon_pic_010");
                                    [UIView animateWithDuration:0.65 animations:^{
                                        [weakself.imageArr[4] mas_updateConstraints:^(MASConstraintMaker *make) {
                                            make.centerY.equalTo(weakself).offset(-20);
                                        }];
                                        [self layoutIfNeeded];
                                    } completion:^(BOOL finished) {
                                        [UIView animateWithDuration:0.65 animations:^{
                                            weakself.imageArr[4].image = MC_ImageWithName(@"icon_pic_015");
                                            [weakself.imageArr[4] mas_updateConstraints:^(MASConstraintMaker *make) {
                                                make.centerY.equalTo(weakself);
                                            }];
                                            [self layoutIfNeeded];
                                        } completion:^(BOOL finished) {
                                            
                                        }];
                                    }];
                                    [self layoutIfNeeded];
                                } completion:^(BOOL finished) {
                                    
                                }];
                            }];
                            [self layoutIfNeeded];
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                    [self layoutIfNeeded];
                } completion:^(BOOL finished) {
                    
                }];
            }];
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)stopLoadingAnimation {
    [timer invalidate];
    timer = nil;
}

@end
