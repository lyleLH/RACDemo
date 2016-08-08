//
//  StatusViewModel.m
//  RACDemo
//
//  Created by 張帥 on 2016/7/16.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "StatusViewModel.h"
#import "GlobeHeader.h"
#import <WeiboSDK.h>
#import "WeiboNetworkTools.h"
#import "WeiboAuthentication.h"
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

- (RACCommand *)loadNewDataCommand {
    if (!_loadNewDataCommand) {
        _loadNewDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                WeiboInfoParam *param = [WeiboInfoParam new];
                param.count = @20;
                if (self.dataSource.count) {
                    StatusCellViewModel *cellModel = self.dataSource[0];
                    param.since_id = @(cellModel.ID);
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
                    
                    [NSKeyedArchiver archiveRootObject:self.dataSource toFile:[self savedPath]];
                    
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    self.dataSource = [NSKeyedUnarchiver unarchiveObjectWithFile:[self savedPath]];
                    
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
                    param.max_id = @(cellModel.ID - 1);
                }
                
                [WeiboNetworkTools weiboInfoWithParam:param success:^(WeiboInfoResult *result) {
                    NSMutableArray *cellModelArray = [NSMutableArray array];
                    for (StatusModel *status in result.statuses) {
                        StatusCellViewModel *cellModel = [[StatusCellViewModel alloc] initWithStatusModel:status];
                        [cellModelArray addObject:cellModel];
                    }
                    [self.dataSource addObjectsFromArray:cellModelArray];
                    
                    [NSKeyedArchiver archiveRootObject:self.dataSource toFile:[self savedPath]];
                    
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    self.dataSource = [NSKeyedUnarchiver unarchiveObjectWithFile:[self savedPath]];
                    
                    [subscriber sendError:error];
                }];

                return nil;
            }];
        }];
    }
    return _loadMoreDataCommand;
}

- (NSString *)savedPath {
    NSString *dir = [StatusViewModel directoryInDocuments:@"Weibo"];
    NSString *fileName = [[WeiboAuthentication authentication].access_token stringByAppendingPathExtension:@"plist"];
    return [dir stringByAppendingPathComponent:fileName];
}

+ (NSString *)directoryInDocuments:(NSString *)dir {
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *directory = [path stringByAppendingPathComponent:dir];
    if ([[NSFileManager defaultManager] fileExistsAtPath:directory]) {
        
    } else {
        NSError* error;
        if (![fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"Can not create directory: %@  error: %@", directory, error.debugDescription);
        }
    }
    return directory;
}

#pragma mark - Lazy Load
- (NSMutableArray<StatusCellViewModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

@end
