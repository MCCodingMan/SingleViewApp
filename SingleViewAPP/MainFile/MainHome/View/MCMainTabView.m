//
//  MCMainTabView.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/2.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCMainTabView.h"

@implementation MCMainTabView {
    //按钮数组
    NSMutableArray<UIButton *> *buttonArr;
}

/**
 初始化tabBarView
 */
- (void)initTabBarView {
    buttonArr = [[NSMutableArray alloc] init];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.selected = YES;
    btn1.tag = 101;
    [btn1 addTarget:self action:@selector(tabButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setImage:MC_ImageWithName(@"icon_pic_001") forState:UIControlStateNormal];
    [btn1 setImage:MC_ImageWithName(@"icon_pic_006") forState:UIControlStateSelected];
    [self addSubview:btn1];
    [buttonArr addObject:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(MC_SCREEN_WIDTH / 5);
    }];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.selected = NO;
    btn2.tag = 102;
    [btn2 addTarget:self action:@selector(tabButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setImage:MC_ImageWithName(@"icon_pic_002") forState:UIControlStateNormal];
    [btn2 setImage:MC_ImageWithName(@"icon_pic_010") forState:UIControlStateSelected];
    [self addSubview:btn2];
    [buttonArr addObject:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn1.mas_right);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(MC_SCREEN_WIDTH / 5);
    }];
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.selected = NO;
    btn3.tag = 103;
    [btn3 addTarget:self action:@selector(tabButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setImage:MC_ImageWithName(@"icon_pic_003") forState:UIControlStateNormal];
    [btn3 setImage:MC_ImageWithName(@"icon_pic_008") forState:UIControlStateSelected];
    [self addSubview:btn3];
    [buttonArr addObject:btn3];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn2.mas_right);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(MC_SCREEN_WIDTH / 5);
    }];
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.selected = NO;
    btn4.tag = 104;
    [btn4 addTarget:self action:@selector(tabButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 setImage:MC_ImageWithName(@"icon_pic_004") forState:UIControlStateNormal];
    [btn4 setImage:MC_ImageWithName(@"icon_pic_009") forState:UIControlStateSelected];
    [self addSubview:btn4];
    [buttonArr addObject:btn4];
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn3.mas_right);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(MC_SCREEN_WIDTH / 5);
    }];
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.selected = NO;
    btn5.tag = 105;
    [btn5 addTarget:self action:@selector(tabButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn5 setImage:MC_ImageWithName(@"icon_pic_005") forState:UIControlStateNormal];
    [btn5 setImage:MC_ImageWithName(@"icon_pic_010") forState:UIControlStateSelected];
    [self addSubview:btn5];
    [buttonArr addObject:btn5];
    [btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn4.mas_right);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(MC_SCREEN_WIDTH / 5);
    }];
}

/**
 tabBar按钮点击事件

 @param sender 点击的按钮
 */
- (void)tabButtonClick:(UIButton *)sender {
    for (UIButton *btn in buttonArr) {
        if (btn.tag == sender.tag) {
            btn.selected = YES;
            if (self.delegate && [self.delegate respondsToSelector:@selector(clickTabButtonChangeViewControllerWithTag:)]) {
                [self.delegate clickTabButtonChangeViewControllerWithTag:btn.tag - 101];
            }
        }else{
            btn.selected = NO;
        }
    }
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
