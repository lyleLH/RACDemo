//
//  WeiboInfoParam.h
//  RACDemo
//
//  Created by 張帥 on 2016/7/29.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboInfoParam : NSObject

/**
 *  int64
 *  若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 */
@property (nonatomic, strong) NSNumber *since_id;

/**
 *  int64
 *  若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 */
@property (nonatomic, strong) NSNumber *max_id;

/**
 *  int
 *  单页返回的记录条数，最大不超过100，默认为20。
 */
@property (nonatomic, strong) NSNumber *count;

/**
 *  int
 *  返回结果的页码，默认为1。
 */
@property (strong, nonatomic) NSNumber *page;

/**
 *  int
 *  是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
@property (strong, nonatomic) NSNumber *base_app;

/**
 *  int
 *  过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 */
@property (strong, nonatomic) NSNumber *feature;

/**
 *  int
 *  返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。
 */
@property (strong, nonatomic) NSNumber *trim_user;

@end
