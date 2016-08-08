//
//  WeiboAccount.m
//  RACDemo
//
//  Created by 張帥 on 2016/7/30.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "WeiboAuthentication.h"
#import "GlobeHeader.h"
#import <WeiboSDK.h>
#import <MJExtension/MJExtension.h>

@implementation WeiboAuthentication

#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expiresTime = [decoder decodeObjectForKey:@"expiresTime"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.refresh_token = [decoder decodeObjectForKey:@"refreshToken"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expiresTime forKey:@"expiresTime"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.refresh_token forKey:@"refreshToken"];
}

- (BOOL)save {
    if (self.error_description) return NO;
    
    ZSLog("%@, %@", self.expiresTime, self.expires_in);
    
    if (!self.expiresTime && self.expires_in) {
        // 计算认证的过期时间
        self.expiresTime = [[NSDate date] dateByAddingTimeInterval:[self.expires_in longLongValue]];
    }
    
    [NSKeyedArchiver archiveRootObject:self toFile:[self.class savedPath]];
    return YES;
}

+ (instancetype)authentication {
    ZSLog("%@", [self.class savedPath]);
    
    WeiboAuthentication *authentication = [NSKeyedUnarchiver unarchiveObjectWithFile:[self.class savedPath]];
    if (!authentication) return nil;
    
    // 判断认证是否过期
    if ([[NSDate date] compare:authentication.expiresTime] == NSOrderedAscending) {
        return authentication;
    } else {
        return nil;
    }
}

+ (void)remove {
    [[NSFileManager defaultManager] removeItemAtPath:[self savedPath] error:NULL];
}

+ (NSString *)savedPath {
    NSString *dir =  [WeiboAuthentication directoryInDocuments:@"Weibo"];
    NSString *fileName = @"authentication.plist";
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
            ZSLog(@"Can not create directory: %@  error: %@", directory, error.debugDescription);
        }
    }
    return directory;
}

@end
