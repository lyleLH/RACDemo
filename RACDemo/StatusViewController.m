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
#import <WeiboSDK.h>
#import "AppDelegate.h"

@interface StatusViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) StatusViewModel *viewModel;

@end

@implementation StatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"RACDemo", nil);
    self.view.backgroundColor = [UIColor whiteColor];

    [self login];
}

- (void)login {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = mWeiBoRedirectURI;
    request.scope = @"all";
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    @weakify(self);
    [appDelegate.authorizeCompletionSignal subscribeNext:^(id x) {
        @strongify(self);
        
        // 添加视图
        [self addViews];
        
        // 进行布局
        [self defineLayout];
    }];
    [WeiboSDK sendRequest:request];
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
