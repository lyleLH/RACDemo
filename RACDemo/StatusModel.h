//
//  StatusInfo.h
//  RACDemo
//
//  Created by 張帥 on 2016/7/16.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusUserModel.h"

@interface StatusModel : NSObject <NSCoding>
/**
 *  微博的内容
 */
@property (nonatomic, copy) NSString *text;

/**
 *  微博的来源
 */
@property (nonatomic, copy) NSString *source;

/**
 *  微博的时间
 */
@property (nonatomic, copy) NSString *created_at;

/**
 *  微博的ID
 */
@property (nonatomic, copy) NSString *idstr;

/**
 *  微博的ID
 */
@property (assign, nonatomic) int64_t ID;

/**
 *  微博的配图
 */
@property (nonatomic, strong) NSArray *pic_urls;

/**
 *  微博的转发数
 */
@property (nonatomic, assign) int reposts_count;

/**
 *  微博的评论数
 */
@property (nonatomic, assign) int comments_count;

/**
 *  微博的被赞数
 */
@property (nonatomic, assign) int attitudes_count;

/**
 *  微博的作者
 */
@property (nonatomic, strong) StatusUserModel *user;

/**
 *  被转发的微博
 */
@property (nonatomic, strong) StatusModel *retweeted_status;

@end
