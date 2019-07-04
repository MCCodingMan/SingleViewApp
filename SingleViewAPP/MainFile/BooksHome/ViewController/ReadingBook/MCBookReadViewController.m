//
//  MCBookReadViewController.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/21.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookReadViewController.h"
#import "MCBookTextViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BackViewController : UIViewController
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIImageView *imageView;

- (UIImage *)captureView:(UIView *)view;

@end

@implementation BackViewController

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)initImageView {
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.imageView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [_imageView setImage:_backgroundImage];
    [_imageView setAlpha:0.5];
}

- (void)updateWithViewController:(UIViewController *)viewController {
    self.backgroundImage = [self captureView:viewController.view];
}

- (UIImage *)captureView:(UIView *)view {
    CGRect rect = view.bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGAffineTransform transform = CGAffineTransformMake(-1.0, 0.0, 0.0, 1.0, rect.size.width, 0.0);
    CGContextConcatCTM(context,transform);
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@interface MCBookReadViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) UIViewController *currentViewController;

@end

@implementation MCBookReadViewController

- (instancetype)init {
    if (self = [super init]) {
        _readViewModel = [[MCBookReadViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubView];
    [self initRACEvent];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)initSubView {
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

- (void)initRACEvent {
    MC_Weak_Self(self);
    _readViewModel.jumpCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [weakself.navigationController popViewControllerAnimated:YES];
        return [RACSignal empty];
    }];
}

-(UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        MCBookTextViewController *readText = [[MCBookTextViewController alloc] init];
        readText.dataModel.chapterResponse = _readViewModel.chapterResponse;
        readText.dataModel.chapterIndex = _readViewModel.chapterIndex;
        self.title = readText.dataModel.chapterResponse.chapters[readText.dataModel.chapterIndex].title;
        [_pageViewController setViewControllers:@[readText] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    return _pageViewController;
}

//向前翻页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    MCBookTextViewController *readText = [[MCBookTextViewController alloc] init];
    readText.dataModel.chapterResponse = _readViewModel.chapterResponse;
    if (_readViewModel.chapterIndex - 1 >= 0) {
        _readViewModel.chapterIndex = _readViewModel.chapterIndex - 1;
    }else{
        _readViewModel.chapterIndex = 0;
    }
    readText.dataModel.chapterIndex = _readViewModel.chapterIndex;
    self.title = readText.dataModel.chapterResponse.chapters[readText.dataModel.chapterIndex].title;
    return readText;
}

//向后翻页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
//    if([viewController isKindOfClass:[MCBookTextViewController class]]) {
//        self.currentViewController = viewController;
//        BackViewController *backViewController = [BackViewController new];
//        [backViewController updateWithViewController:viewController];
//        return backViewController;
//    }
//    /**
//     *  重新加载新的一章或一页到lzbooktextcontroller上 并返回给pageviewcontroller
//     */
//    BackViewController *showVc =  (BackViewController *)self.currentViewController;
//    return showVc;
    MCBookTextViewController *readText = [[MCBookTextViewController alloc] init];
    readText.dataModel.chapterResponse = _readViewModel.chapterResponse;
    if (_readViewModel.chapterIndex + 1 <= _readViewModel.chapterResponse.chapters.count - 1) {
        _readViewModel.chapterIndex = _readViewModel.chapterIndex + 1;
    }else{
        _readViewModel.chapterIndex = _readViewModel.chapterResponse.chapters.count - 1;
    }
    readText.dataModel.chapterIndex = _readViewModel.chapterIndex;
    self.title = readText.dataModel.chapterResponse.chapters[readText.dataModel.chapterIndex].title;
    return readText;
}


@end
