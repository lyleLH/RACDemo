//
//  StatusInfo.m
//  RACDemo
//
//  Created by 張帥 on 2016/7/16.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "StatusModel.h"
#import <MJExtension/MJExtension.h>

@implementation StatusModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id" };
}

@end
