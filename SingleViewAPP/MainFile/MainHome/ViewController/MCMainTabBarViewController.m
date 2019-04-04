//
//  MCMainTabBarViewController.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/2.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCMainTabBarViewController.h"
#import "MCTextViewController.h"
#import "MCImageViewController.h"
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
    MCImageViewController *vc2 = [[MCImageViewController alloc] init];
    UIViewController *vc3 = [[UIViewController alloc] init];
    UIViewController *vc4 = [[UIViewController alloc] init];
    [self setViewControllers:@[vc1,vc2,vc3,vc4] animated:NO];
}

#pragma mark -- MCMainTabViewDelegate

/**
 按钮点击事件代理

 @param selectItem 点击的index
 */
- (void)clickTabButtonChangeViewControllerWithTag:(NSInteger)selectItem {
    [self setSelectedIndex:selectItem];
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
