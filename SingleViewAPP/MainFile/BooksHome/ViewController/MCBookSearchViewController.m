//
//  MCBookSearchViewController.m
//  SingleViewAPP
//
//  Created by wr on 2019/5/28.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "MCBookSearchViewController.h"
#import "MCBookSearchViewModel.h"
#import "MCBookListCell.h"
#import "MCBookInfoViewController.h"

@interface MCBookSearchViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) MCBookSearchViewModel *searchViewModel;

@property (nonatomic, strong) UITableView *searchFullTableView;

@property (nonatomic, strong) UITableView *searchListTableView;

@property (nonatomic, strong) UIImage *backGroundImage;

@end

@implementation MCBookSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataModelAndTableView];
    [self initNavigationTitle];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initNotice];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MC_NotificationCenter removeObserver:self];
}

- (void)initDataModelAndTableView {
    self.backGroundImage = MC_ImageWithName(@"bg_pic_001");
    self.searchViewModel = [[MCBookSearchViewModel alloc] init];
    [self.view addSubview:self.searchListTableView];
    [self.searchListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
    [self.view addSubview:self.searchFullTableView];
    [self.searchFullTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
    
}

- (void)initNotice {
    [MC_NotificationCenter addObserver:self selector:@selector(reloadSearchFullTableView) name:@"RefreshSearchFullTabelView" object:nil];
    [MC_NotificationCenter addObserver:self selector:@selector(reloadSearchListTableView) name:@"RefreshSearchListTabelView" object:nil];
    [MC_NotificationCenter addObserver:self selector:@selector(jumpToBookInfoController:) name:@"JumpToBookInfoController" object:nil];
}

- (void)reloadSearchFullTableView {
    [self.searchFullTableView reloadData];
}

- (void)reloadSearchListTableView{
    [self.searchListTableView reloadData];
    self.searchFullTableView.hidden = YES;
}

- (void)initNavigationTitle {
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MC_SCREEN_WIDTH - 100, 30)];
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, MC_SCREEN_WIDTH - 100, 30)];
    searchBar.placeholder = @"请输入";
//    searchBar.layer.cornerRadius = 15;
//    searchBar.layer.masksToBounds = YES;
//    设置背景图是为了去掉上下黑线
//    searchBar.backgroundImage = [[UIImage alloc] init];
//    设置SearchBar的主题颜色
//    searchBar.barTintColor = MC_COLOR_RGB(111/255.0, 212/255.0, 163/255.0);
//    设置背景色
//    searchBar.backgroundColor = MC_COLOR_RGBA(0, 0, 0, 0.1);
//    修改cancel
    searchBar.showsCancelButton = NO;
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.keyboardType = UIKeyboardTypeDefault;
//    searchBar.searchBarStyle = UISearchBarStyleMinimal;
//    没有背影，透明样式
    searchBar.delegate = _searchViewModel;
//  修改cancel
    searchBar.showsSearchResultsButton = NO;
    //5. 设置搜索Icon
    [searchBar setImage:MC_ImageWithName(@"icon_sousuo") forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    /*这段代码有个特别的地方就是通过KVC获得到UISearchBar的私有变量
              searchField（类型为UITextField），
         设置SearchBar的边框颜色和圆角实际上也就变成了设置searchField的边框颜色和圆角，
         你可以试试直接设置SearchBar.layer.borderColor和cornerRadius，会发现这样做是有问题的。
     */
    //一下代码为修改placeholder字体的颜色和大小
    UITextField *searchField = [searchBar valueForKey:@"_searchField"];
    //2. 设置圆角和边框颜色
    if(searchField) {
//        [searchField setBackgroundColor:[UIColor clearColor]];
//        MC_ViewBorder(searchField, 1, MC_COLOR_RGB(49/255.0f, 193/255.0f, 123/255.0f));
        MC_ViewRadius(searchField, 3);
        // 根据@"_placeholderLabel.textColor" 找到placeholder的字体颜色
//        [searchField setValue:MC_COLOR_RGB(200/255.0, 200/255.0, 200/255.0) forKeyPath:@"_placeholderLabel.textColor"];
    }
    // 输入文本颜色
    searchField.textColor = [UIColor redColor];
    searchField.font = MC_UIFont(15);
    // 默认文本大小
    [searchField setValue:MC_UIBoldFont(13) forKeyPath:@"_placeholderLabel.font"];
    //只有编辑时出现出现那个叉叉
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [titleView addSubview:searchBar];
    //Set to titleView
    self.navigationItem.titleView = titleView;
    [MC_NotificationCenter addObserver:searchBar selector:@selector(resignFirstResponder) name:@"RecyclingKeyBoard" object:nil];
}

- (void)jumpToBookInfoController:(NSNotification *)notice {
    MCBookInfoViewController *bookInfoVC = [[MCBookInfoViewController alloc] init];
    bookInfoVC.bookID = notice.userInfo[@"bookID"];
    [self.navigationController pushViewController:bookInfoVC animated:YES];
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

- (UITableView *)searchFullTableView {
    if (!_searchFullTableView) {
        _searchFullTableView = [[UITableView alloc] init];
        _searchFullTableView.tag = 101;
        _searchFullTableView.dataSource = _searchViewModel;
        _searchFullTableView.delegate = _searchViewModel;
        _searchFullTableView.rowHeight = 50;
    }
    return _searchFullTableView;
}

- (UITableView *)searchListTableView {
    if (!_searchListTableView) {
        _searchListTableView = [[UITableView alloc] init];
        _searchListTableView.tag = 102;
        _searchListTableView.dataSource = _searchViewModel;
        _searchListTableView.delegate = _searchViewModel;
        _searchListTableView.estimatedRowHeight = 180;
        _searchListTableView.rowHeight = UITableViewAutomaticDimension;
        _searchListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _searchListTableView.backgroundColor = [UIColor clearColor];
        _searchListTableView.tableFooterView = [[UIView alloc] init];
        [_searchListTableView registerClass:[MCBookListCell class] forCellReuseIdentifier:NSStringFromClass([MCBookListCell class])];
    }
    return _searchListTableView;
}


@end
