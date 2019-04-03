//
//  MCTextViewController.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCTextViewController.h"
#import "MCTextContentView.h"

@interface MCTextViewController ()

@end

@implementation MCTextViewController {
    MCTextContentView *mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self injected];
    // Do any additional setup after loading the view.
}

- (void)injected {
    [self initMainContentView];
}

- (void)initMainContentView {
    mainView = [[MCTextContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:mainView];
}


@end
