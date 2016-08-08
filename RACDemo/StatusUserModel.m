//
//  UserInfo.m
//  RACDemo
//
//  Created by 張帥 on 2016/7/16.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "StatusUserModel.h"
#import <MJExtension/MJExtension.h>

@implementation StatusUserModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id", @"mDescription" : @"description"};
}

@end
