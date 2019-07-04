//
//  MCMainTabBarViewController.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/2.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCMainTabBarViewController.h"
#import "MCBooksHomeViewController.h"
#import "MCTextViewController.h"
#import "MCImageViewController.h"
#import "MCGifViewController.h"
#import "MCVideoViewController.h"
#import "MCAllViewController.h"
#import "MCMainTabView.h"

@interface MCMainTabBarViewController ()<MCMainTabViewDelegate>

@end

@implementation MCMainTabBarViewController {
    MCMainTabView *mainTab;
}

#pragma mark --Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self injected];
    [self initNavigation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [MC_NotificationCenter addObserver:self selector:@selector(mainTabBarMoveDownOrUp:) name:@"MCTabBarIsHidden" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [MC_NotificationCenter removeObserver:self];
}
- (void)initNavigation {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"icon_pic_book"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightButtonClick {
    MCBooksHomeViewController *bookVC = [[MCBooksHomeViewController alloc] init];
    [self.navigationController pushViewController:bookVC animated:YES];
}
/**
 热跟新重载方法
 */
- (void)injected {
    [self initTabBar];
    [self addChildSubviews];
}

#pragma mark --initView

/**
 初始化tab
 */
- (void)initTabBar {
    self.tabBar.hidden = YES;
    mainTab = [[MCMainTabView alloc] init];
    mainTab.delegate = self;
    mainTab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mainTab];
    [mainTab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideBottom);
        make.height.mas_equalTo(50);
    }];
    [mainTab initTabBarView];
}

/**
 添加子视图
 */
- (void)addChildSubviews {
    MCTextViewController *vc1 = [[MCTextViewController alloc] init];
    vc1.title = @"文字";
    MCImageViewController *vc2 = [[MCImageViewController alloc] init];
    vc2.title = @"图片";
    MCGifViewController *vc3 = [[MCGifViewController alloc] init];
    vc3.title = @"动图";
    MCAllViewController *vc4 = [[MCAllViewController alloc] init];
    vc4.title = @"全部";
    MCVideoViewController *vc5 = [[MCVideoViewController alloc] init];
    vc5.title = @"视频";
    [self setViewControllers:@[vc4,vc1,vc2,vc3,vc5] animated:NO];
    self.title = self.selectedViewController.title;
}

#pragma mark -- MCMainTabViewDelegate

/**
 按钮点击事件代理

 @param selectItem 点击的index
 */
- (void)clickTabButtonChangeViewControllerWithTag:(NSInteger)selectItem {
    [self setSelectedIndex:selectItem];
    self.title = self.selectedViewController.title;
}

#pragma mark -- NSNotificationCenter

/**
 tabBar上移下移

 @param notification 通知
 */
- (void)mainTabBarMoveDownOrUp:(NSNotification *)notification {
    NSString *valueString = notification.userInfo[@"MCDownOrUp"];
    if ([valueString isEqualToString:@"DOWN"]) {
        [UIView animateWithDuration:0.5 animations:^{
            [self->mainTab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mas_bottomLayoutGuideBottom).offset(50);
            }];
            [self.view layoutIfNeeded];
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            [self->mainTab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mas_bottomLayoutGuideBottom);
            }];
            [self.view layoutIfNeeded];
        }];
    }
}

@end
