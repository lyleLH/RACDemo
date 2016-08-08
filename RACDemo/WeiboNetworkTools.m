//
//  WeiboNetworkTools.m
//  RACDemo
//
//  Created by 張帥 on 2016/7/29.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "WeiboNetworkTools.h"
#import "WBHttpRequest.h"
#import <MJExtension/MJExtension.h>
#import "GlobeHeader.h"

@implementation WeiboNetworkTools

+ (void)weiboInfoWithParam:(WeiboInfoParam *)param success:(void (^)(WeiboInfoResult *result))success failure:(void (^)(NSError *error))failure {
    [self GET:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.mj_keyValues success:^(WBHttpRequest *httpRequest, NSDictionary *json) {
        if (success) {
            WeiboInfoResult *result = [WeiboInfoResult mj_objectWithKeyValues:json];
            success(result);
        }
    } failure:^(WBHttpRequest *httpRequest, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)GET:(NSString *)urlStr params:(NSDictionary *)params success:(void (^)(WBHttpRequest *httpRequest, NSDictionary *json))success failure:(void (^)(WBHttpRequest *httpRequest, NSError *error))failure {
    urlStr = [WeiboNetworkTools urlStr:urlStr appendingParam:params];
    [WBHttpRequest requestWithURL:urlStr httpMethod:@"GET" params:nil queue:[NSOperationQueue new] withCompletionHandler:^(WBHttpRequest *httpRequest, NSDictionary *json, NSError *error) {
        if (error) {
            if (failure) {
                ZSLog(@"GET失败 url = %@, error = %@", urlStr, error.domain);
                failure(httpRequest, error);
            }
        } else {
            if (success) {
                ZSLog(@"GET成功 url = %@, response = %@", urlStr, json);
                success(httpRequest, json);
            }
            
        }
    }];
}

+ (void)POST:(NSString *)urlStr params:(NSDictionary *)params success:(void (^)(WBHttpRequest *httpRequest, NSDictionary *json))success failure:(void (^)(WBHttpRequest *httpRequest, NSError *error))failure {
    urlStr = [WeiboNetworkTools urlStr:urlStr appendingParam:params];
    [WBHttpRequest requestWithURL:urlStr httpMethod:@"POST" params:nil queue:[NSOperationQueue new] withCompletionHandler:^(WBHttpRequest *httpRequest, NSDictionary *json, NSError *error) {
        if (error) {
            if (failure) {
                ZSLog(@"POST失败 url = %@, error = %@", urlStr, error.domain);
                failure(httpRequest, error);
            }
        } else {
            if (success) {
                ZSLog(@"POST成功 url = %@, response = %@", urlStr, json);
                success(httpRequest, json);
            }
            
        }
    }];
}

+ (NSString *)urlStr:(NSString *)urlStr appendingParam:(NSDictionary<NSString *, NSString *> *)attrs {
    if (attrs && [attrs isKindOfClass:[NSDictionary class]] && attrs.count != 0) {
        NSMutableString *attrString = [NSMutableString new];
        for (NSString *key in attrs.allKeys) {
            [attrString appendString:[NSString stringWithFormat:@"&%@=%@", key, attrs[key]]];
        }
        [attrString replaceCharactersInRange:NSMakeRange(0, 1) withString:@"?"];
        
        urlStr = [urlStr stringByAppendingString:attrString];
    }
    return urlStr;
}


@end
