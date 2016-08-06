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

@implementation StatusViewModel

- (NSMutableArray<StatusCellViewModel *> *)dataSource {
    if (!_dataSource) {
        NSMutableArray *array = [NSMutableArray new];
        for (int i = 0; i < 50; i++) {
            StatusCellViewModel *cellModel = [StatusCellViewModel new];
            cellModel.text = [NSString stringWithFormat:@"%d - gtesijglsajhlahljreaiglangsg单肩都发你肯定是你姐夫是电脑跟楼上的过分的话gtesijglsajhlahljreaiglangsggtesijglsajhlahljreaiglanasaa", i];
            cellModel.userName = @"嗚嚕嗚嚕";
            [array addObject:cellModel];
        }
        _dataSource = array;
        
    }
    return _dataSource;
}

- (RACCommand *)loginCommand {
    if (!_loginCommand) {
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                WBAuthorizeRequest *request = [WBAuthorizeRequest request];
                request.redirectURI = mWeiBoRedirectURI;
                request.scope = @"all";
                [WeiboSDK sendRequest:request];
                
                return nil;
            }];
        }];
    }
    return _loginCommand;
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
                } failure:nil];
                
                return nil;
            }];
        }];
    }
    return _setupUserDataCommand;
}

@end
