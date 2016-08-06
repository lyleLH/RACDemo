//
//  AuthorizeParam.h
//  RACDemo
//
//  Created by 張帥 on 2016/7/29.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "WeiboBaseParam.h"

@interface WeiboUserParam : WeiboBaseParam

/**
 *  int64
 *  需要查询的用户ID。
 */
@property (nonatomic, strong) NSNumber *uid;

/**
 *  需要查询的用户昵称。
 */
@property (nonatomic, copy) NSString *screen_name;

@end
