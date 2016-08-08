//
//  UserInfo.h
//  RACDemo
//
//  Created by 張帥 on 2016/7/16.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusUserModel : NSObject 

/**
 *  用户的ID
 */
@property (assign, nonatomic) int64_t ID;

/**
 *  用户的昵称
 */
@property (copy, nonatomic) NSString *name;

/**
 *  用户个人描述
 */
@property (copy, nonatomic) NSString *mDescription;

/**
 *  用户所在地
 */
@property (copy, nonatomic) NSString *location;

/**
 *  用户头像地址（中图），50×50像素
 */
@property (copy, nonatomic) NSString *profile_image_url;

/**
 *  用户头像地址（大图），180×180像素
 */
@property (copy, nonatomic) NSString *avatar_large;

/**
 *  用户头像地址（高清），高清头像原图
 */
@property (copy, nonatomic) NSString *avatar_hd;

/**
 *  会员等级
 */
@property (assign, nonatomic) int mbrank;

/**
 *  会员类型 > 2 会员
 */
@property (assign, nonatomic) int mbtype;

/**
 *  粉丝数
 */
@property (assign, nonatomic) int followers_count;

/**
 *  关注数
 */
@property (assign, nonatomic) int friends_count;

/**
 *  微博数
 */
@property (assign, nonatomic) int statuses_count;

/**
 *  收藏数
 */
@property (assign, nonatomic) int favourites_count;

/**
 *  用户创建（注册）时间
 */
@property (copy, nonatomic) NSString *created_at;

/**
 *  用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语
 */
@property (copy, nonatomic) NSString *lang;

@end
