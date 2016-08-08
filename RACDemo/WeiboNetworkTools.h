//
//  WeiboNetworkTools.h
//  RACDemo
//
//  Created by 張帥 on 2016/7/29.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboInfoParam.h"
#import "WeiboInfoResult.h"

@interface WeiboNetworkTools : NSObject

/**
 *  获取当前登录用户及其所关注用户的最新微博
 */
+ (void)weiboInfoWithParam:(WeiboInfoParam *)param
                   success:(void (^)(WeiboInfoResult *result))success
                   failure:(void (^)(NSError *error))failure;


@end
