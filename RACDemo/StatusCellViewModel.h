//
//  StatusCellViewModel.h
//  RACDemo
//
//  Created by 張帥 on 2016/7/29.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusModel.h"

@interface StatusCellViewModel : NSObject

@property (assign, nonatomic) int64_t ID;

// 头像url
@property (nonatomic, copy) NSString *avatar;

// 昵称
@property (copy, nonatomic) NSString *userName;

// 微博正文
@property (copy, nonatomic) NSString *text;

- (instancetype)initWithStatusModel:(StatusModel *)status;

@end
