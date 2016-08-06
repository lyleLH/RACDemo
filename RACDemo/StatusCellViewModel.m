//
//  StatusCellViewModel.m
//  RACDemo
//
//  Created by 張帥 on 2016/7/29.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "StatusCellViewModel.h"

@implementation StatusCellViewModel

- (instancetype)initWithStatusModel:(StatusModel *)status {
    self = [super init];
    if (!self) return nil;
    
    self.status = status;
    
    return self;
}

- (void)setStatus:(StatusModel *)status {
    _status = status;
    
    self.avatar = status.user.avatar_large;
    self.userName = status.user.name;
    self.text = status.text;
}

@end
