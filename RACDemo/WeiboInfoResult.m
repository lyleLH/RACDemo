//
//  WeiboInfoResult.m
//  RACDemo
//
//  Created by 張帥 on 2016/7/29.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "WeiboInfoResult.h"
#import <MJExtension/MJExtension.h>

@implementation WeiboInfoResult

- (NSDictionary *)objectClassInArray {
    return @{@"statuses" : [StatusModel class]};
}

@end
