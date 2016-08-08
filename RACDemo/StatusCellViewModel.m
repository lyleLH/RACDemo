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
    
    self.ID = status.ID;
    self.avatar = status.user.avatar_large;
    self.userName = status.user.name;
    self.text = status.text;
    
    return self;
}

#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.ID = [decoder decodeInt64ForKey:@"ID"];
        self.avatar = [decoder decodeObjectForKey:@"avatar"];
        self.userName = [decoder decodeObjectForKey:@"userName"];
        self.text = [decoder decodeObjectForKey:@"text"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt64:self.ID forKey:@"ID"];
    [encoder encodeObject:self.avatar forKey:@"avatar"];
    [encoder encodeObject:self.userName forKey:@"userName"];
    [encoder encodeObject:self.text forKey:@"text"];
}

@end
