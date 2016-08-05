//
//  WeiboAccount.h
//  RACDemo
//
//  Created by 張帥 on 2016/7/30.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusUserModel.h"

@interface WeiboAccount : NSObject <NSCoding>

// 用户信息
@property (strong, nonatomic) StatusUserModel *user;

// 账号的过期时间
@property (strong, nonatomic) NSDate *expiresTime;

// 成功
@property (copy, nonatomic) NSString *access_token;
@property (copy, nonatomic) NSString *expires_in;
@property (copy, nonatomic) NSString *uid;
// 只有用微博SDK的SSO认证才有
@property (copy, nonatomic) NSString *refresh_token;

// 出错
@property (copy, nonatomic) NSString *error_description;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

- (BOOL)saveAccount;
+ (instancetype)loadAccount;
+ (void)refreshAccountExpiresTime;
+ (void)deleteAccount;

@end
