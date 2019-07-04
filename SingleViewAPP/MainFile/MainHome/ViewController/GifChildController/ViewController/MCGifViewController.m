//
//  MCGifViewController.m
//  SingleViewAPP
//
//  Created by wr on 2019/4/8.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCGifViewController.h"
#import "MCGifContentView.h"

@interface MCGifViewController ()

@end

@implementation MCGifViewController {
    MCGifContentView *contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
    // Do any additional setup after loading the view.
}

- (void)initContentView {
    contentView = [[MCGifContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:contentView];
}

@end
