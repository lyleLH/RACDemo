//
//  WeiboBaseParam.m
//  RACDemo
//
//  Created by 張帥 on 2016/8/6.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "WeiboBaseParam.h"
#import "WeiboAccount.h"

@implementation WeiboBaseParam

- (instancetype)init {
    if (self = [super init]) {
        _access_token = WeiboAccount.loadAccount.access_token;
    }
    return self;
}

@end
