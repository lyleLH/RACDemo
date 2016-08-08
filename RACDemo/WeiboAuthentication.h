//
//  WeiboAccount.h
//  RACDemo
//
//  Created by 張帥 on 2016/7/30.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusUserModel.h"

@interface WeiboAuthentication : NSObject <NSCoding>

// 认证的过期时间
@property (strong, nonatomic) NSDate *expiresTime;

// 成功
@property (copy, nonatomic) NSString *access_token;
@property (copy, nonatomic) NSString *expires_in;
@property (copy, nonatomic) NSString *uid;
// 只有用微博SDK的SSO认证才有
@property (copy, nonatomic) NSString *refresh_token;

// 出错
@property (copy, nonatomic) NSString *error_description;

- (BOOL)save;
+ (instancetype)authentication;
+ (void)remove;

@end
