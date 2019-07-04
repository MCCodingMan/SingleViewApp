//
//  MCBookBaseViewController.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/17.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookBaseViewController.h"
#import "MCLoadingView.h"
#import "MCBookSearchViewController.h"

@interface MCBookBaseViewController ()

@property (nonatomic, strong) MCLoadingView *loadBagroundView;

@end

@implementation MCBookBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigatiionRightItem];
    // Do any additional setup after loading the view.
}

- (void)initNavigatiionRightItem {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:MC_ImageWithName(@"icon_sousuo") forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightButtonClick {
    MCBookSearchViewController *searchVC = [[MCBookSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

/**
 设置背景图片
 
 @param backGroundImage 背景图片
 */
- (void)setBackGroundImage:(UIImage *)backGroundImage {
    UIImageView *backGroundImageView = [[UIImageView alloc] initWithImage:backGroundImage];
    backGroundImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:backGroundImageView];
    [self.view sendSubviewToBack:backGroundImageView];
}

- (MCLoadingView *)loadBagroundView {
    if (!_loadBagroundView) {
        _loadBagroundView = [[MCLoadingView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_loadBagroundView];
    }
    return _loadBagroundView;
}

- (void)startLoadingView {
    [self.loadBagroundView startLoadingAnimation];
}

- (void)stopLoadingView {
    [self.loadBagroundView stopLoadingAnimation];
    [self.loadBagroundView removeFromSuperview];
}

@end
