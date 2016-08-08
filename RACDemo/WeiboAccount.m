//
//  WeiboAccount.m
//  RACDemo
//
//  Created by 張帥 on 2016/7/30.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "WeiboAccount.h"
#import "GlobeHeader.h"
#import <WeiboSDK.h>
#import <MJExtension/MJExtension.h>

@implementation WeiboAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.user = [decoder decodeObjectForKey:@"user"];
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expiresTime = [decoder decodeObjectForKey:@"expiresTime"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.refresh_token = [decoder decodeObjectForKey:@"refreshToken"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.user forKey:@"user"];
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expiresTime forKey:@"expiresTime"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.refresh_token forKey:@"refreshToken"];
}

- (BOOL)saveAccount {
    if (self.error_description) return NO;
    
    ZSLog("%@, %@", self.expiresTime, self.expires_in);
    
    if (!self.expiresTime && self.expires_in) {
        // 计算账号的过期时间
        self.expiresTime = [[NSDate date] dateByAddingTimeInterval:[self.expires_in longLongValue]];
    }
    
    [NSKeyedArchiver archiveRootObject:self toFile:[self.class accountSavePath]];
    return YES;
}

+ (instancetype)loadAccount {
    ZSLog("%@", [self.class accountSavePath]);
    
    WeiboAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:[self.class accountSavePath]];
    if (!account) return nil;
    
    // 判断账号是否过期
    if ([[NSDate date] compare:account.expiresTime] == NSOrderedAscending) { // 还没有过期
        return account;
    } else { // 过期
        return nil;
    }
}

+ (void)refreshAccountExpiresTime {
    WeiboAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:[self.class accountSavePath]];
    if (!account) return;
    
    // 如果账号过期，使用RefreshToken去换取新的AccessToken
    if ([[NSDate date] compare:account.expiresTime] == NSOrderedDescending) {
        [WBHttpRequest requestForRenewAccessTokenWithRefreshToken:account.refresh_token queue:[NSOperationQueue new] withCompletionHandler:^(WBHttpRequest *httpRequest, NSDictionary *result, NSError *error) {
            ZSLog("result = %@", result);
            WeiboAccount *account = [WeiboAccount mj_objectWithKeyValues:result];
            [account saveAccount];
            ZSLog("account = %@", account.mj_keyValues);
        }];
    }
}

+ (NSString *)accountSavePath {
    NSString *dir =  [WeiboAccount directoryInDocuments:@"Weibo"];
    NSString *fileName = @"account.plist";
    return [dir stringByAppendingPathComponent:fileName];
}

+ (void)deleteAccount {
    [[NSFileManager defaultManager] removeItemAtPath:[self accountSavePath] error:NULL];
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

@end
