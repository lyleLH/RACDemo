//
//  StatusViewModel.m
//  RACDemo
//
//  Created by 張帥 on 2016/7/16.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "StatusViewModel.h"
#import "WBHttpRequest.h"
#import "GlobeHeader.h"
#import <WeiboSDK.h>
#import "WeiboNetworkTools.h"
#import "WeiboAccount.h"
#import "AppDelegate.h"

@implementation StatusViewModel

- (RACCommand *)authorizeCommand {
    if (!_authorizeCommand) {
        _authorizeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                WBAuthorizeRequest *request = [WBAuthorizeRequest request];
                request.redirectURI = WeiBoRedirectURI;
                request.scope = @"all";
                AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
                [appDelegate.authorizeCompletionSignal subscribeNext:^(id x) {
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }];
                [WeiboSDK sendRequest:request];
                
                return nil;
            }];
        }];
    }
    return _authorizeCommand;
}

- (RACCommand *)setupUserDataCommand {
    if (!_setupUserDataCommand) {
        _setupUserDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            __block WeiboAccount *account = (WeiboAccount *)input;
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                WeiboUserParam *param = [WeiboUserParam new];
                param.uid = @([[WeiboAccount loadAccount].uid longLongValue]);
                
                [WeiboNetworkTools userInfoWithParam:param success:^(WeiboUserResult *result) {
                    if(!account) account = [WeiboAccount loadAccount];
                    account.user = (StatusUserModel *)result;
                    [account saveAccount];
                    
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    [subscriber sendError:error];
                }];
                
                return nil;
            }];
        }];
    }
    return _setupUserDataCommand;
}

- (RACCommand *)loadNewDataCommand {
    if (!_loadNewDataCommand) {
        _loadNewDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                WeiboInfoParam *param = [WeiboInfoParam new];
                param.count = @20;
                if (self.dataSource.count) {
                    StatusCellViewModel *cellModel = self.dataSource[0];
                    param.since_id = @(cellModel.status.ID);
                }
                
                [WeiboNetworkTools weiboInfoWithParam:param success:^(WeiboInfoResult *result) {
                    NSMutableArray *cellModelArray = [NSMutableArray array];
                    for (StatusModel *status in result.statuses) {
                        StatusCellViewModel *cellModel = [[StatusCellViewModel alloc] initWithStatusModel:status];
                        [cellModelArray addObject:cellModel];
                    }
                    
                    NSMutableArray *tempArray = [NSMutableArray array];
                    [tempArray addObjectsFromArray:cellModelArray];
                    [tempArray addObjectsFromArray:self.dataSource];
                    self.dataSource = tempArray;
                    
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    [subscriber sendError:error];
                }];
                
                return nil;
            }];
        }];
    }
    return _loadNewDataCommand;
}

- (RACCommand *)loadMoreDataCommand {
    if (!_loadMoreDataCommand) {
        _loadMoreDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                WeiboInfoParam *param = [WeiboInfoParam new];
                if (self.dataSource.count) {
                    StatusCellViewModel *cellModel = [self.dataSource lastObject];
                    param.max_id = @(cellModel.status.ID - 1);
                }
                
                [WeiboNetworkTools weiboInfoWithParam:param success:^(WeiboInfoResult *result) {
                    NSMutableArray *cellModelArray = [NSMutableArray array];
                    for (StatusModel *status in result.statuses) {
                        StatusCellViewModel *cellModel = [[StatusCellViewModel alloc] initWithStatusModel:status];
                        [cellModelArray addObject:cellModel];
                    }
                    [self.dataSource addObjectsFromArray:cellModelArray];
                    
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    [subscriber sendError:error];
                }];

                return nil;
            }];
        }];
    }
    return _loadMoreDataCommand;
}

#pragma mark - Lazy Load
- (NSMutableArray<StatusCellViewModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

@end
