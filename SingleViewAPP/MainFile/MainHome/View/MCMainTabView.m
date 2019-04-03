//
//  MCMainTabView.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/2.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCMainTabView.h"

@implementation MCMainTabView

- (void)initTabBarView {
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.backgroundColor = MC_COLOR_RANDOM;
    [self addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(MC_SCREEN_WIDTH / 5);
    }];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = MC_COLOR_RANDOM;
    [self addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn1.mas_right);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(MC_SCREEN_WIDTH / 5);
    }];
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.backgroundColor = MC_COLOR_RANDOM;
    [self addSubview:btn3];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn2.mas_right);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(MC_SCREEN_WIDTH / 5);
    }];
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.backgroundColor = MC_COLOR_RANDOM;
    [self addSubview:btn4];
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn3.mas_right);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(MC_SCREEN_WIDTH / 5);
    }];
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.backgroundColor = MC_COLOR_RANDOM;
    [self addSubview:btn5];
    [btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn4.mas_right);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(MC_SCREEN_WIDTH / 5);
    }];
}

- (void)drawRect:(CGRect)rect {
     [super drawRect:rect];
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [self createWave:contextRef];
}

/**
 创建波浪背景

 @param contextRef 上下文
 */
-(void)createWave:(CGContextRef)contextRef {
    //波浪宽度
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path ,nil, 0, self.frame.size.height);
    CGPathAddLineToPoint(path,nil, 0, self.frame.size.height / 3);
    for (float i = 0.0f; i < MC_SCREEN_WIDTH; i++) {
        float heght = self.frame.size.height / 3 + sinf(i * 0.03) * 5;
        CGPathAddLineToPoint(path,nil, i, heght);
    }
    CGPathAddLineToPoint(path,nil, MC_SCREEN_WIDTH, self.frame.size.height);
    CGPathCloseSubpath(path);
    CGContextSetFillColorWithColor(contextRef, [UIColor orangeColor].CGColor);
    CGContextSetLineWidth(contextRef, 0.5);
    CGContextAddPath(contextRef, path);
    CGContextFillPath(contextRef);
    CGPathRelease(path);
}



@end
