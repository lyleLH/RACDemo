//
//  ViewController.m
//  RACDemo
//
//  Created by 張帥 on 2016/7/14.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "StatusViewController.h"
#import "GlobeHeader.h"
#import "StatusCell.h"
#import "StatusViewModel.h"
#import "WeiboAccount.h"
#import <MJRefresh/MJRefresh.h>

@interface StatusViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) StatusViewModel *viewModel;

@end

@implementation StatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"RACDemo", nil);
    self.view.backgroundColor = [UIColor whiteColor];

    // 添加视图
    [self addViews];
    
    // 进行布局
    [self defineLayout];
    
    // V绑定VM
    [self bindWithViewModel];
    
    // 授权登录
    [self login];
}

- (void)login {
    if (![WeiboAccount loadAccount]) {
        @weakify(self);
        [[self.viewModel.loginCommand execute:nil] subscribeNext:^(id x) {
            @strongify(self);
            [self setupUserData];
        }];
    } else {
        [self setupUserData];
    }
}

- (void)setupUserData {
    WeiboAccount *account = [WeiboAccount loadAccount];
    if (!account.user) {
        [self.viewModel.setupUserDataCommand execute:account];
    }
}

- (void)addViews {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[StatusCell class] forCellReuseIdentifier:NSStringFromClass([StatusCell class])];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 150;
}

- (void)defineLayout {
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.left.right.bottom.equalTo(self.view);
    }];
}

- (void)bindWithViewModel {
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [[self.viewModel.loadNewDataCommand execute:nil] subscribeCompleted:^{
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
         @strongify(self);
        [[self.viewModel.loadMoreDataCommand execute:nil] subscribeCompleted:^{
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StatusCell class]) forIndexPath:indexPath];
    cell.viewModel = self.viewModel.dataSource[indexPath.row];
    return cell;
}

#pragma mark - Lazy Load
- (StatusViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [StatusViewModel new];
    }
    return _viewModel;
}

@end
