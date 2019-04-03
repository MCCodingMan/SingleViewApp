//
//  MCMainTabBarViewController.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/2.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCMainTabBarViewController.h"
#import "MCTextViewController.h"
#import "MCMainTabView.h"

@interface MCMainTabBarViewController ()

@end

@implementation MCMainTabBarViewController {
    MCMainTabView *mainTab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self injected];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MC_NotificationCenter addObserver:self selector:@selector(mainTabBarMoveDownOrUp:) name:@"MCTabBarIsHidden" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [MC_NotificationCenter removeObserver:self];
}

- (void)injected {
    [self addChildSubviews];
}

- (void)addChildSubviews {
    MCTextViewController *vc1 = [[MCTextViewController alloc] init];
    UIViewController *vc2 = [[UIViewController alloc] init];
    UIViewController *vc3 = [[UIViewController alloc] init];
    UIViewController *vc4 = [[UIViewController alloc] init];
    [self setViewControllers:@[vc1,vc2,vc3,vc4] animated:NO];
    self.tabBar.hidden = YES;
    mainTab = [[MCMainTabView alloc] init];
    mainTab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mainTab];
    [mainTab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideBottom);
        make.height.mas_equalTo(50);
    }];
    [mainTab initTabBarView];
}

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
