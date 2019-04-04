//
//  MCImageViewController.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/4.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCImageViewController.h"
#import "MCImageContentView.h"

@interface MCImageViewController ()

@end

@implementation MCImageViewController {
    MCImageContentView *contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
    // Do any additional setup after loading the view.
}

- (void)initContentView {
    contentView = [[MCImageContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:contentView];
}

@end
