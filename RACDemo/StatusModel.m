//
//  StatusInfo.m
//  RACDemo
//
//  Created by 張帥 on 2016/7/16.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "StatusModel.h"

@implementation StatusModel

- (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id" };
}

#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.text = [decoder decodeObjectForKey:@"text"];
        self.source = [decoder decodeObjectForKey:@"source"];
        self.created_at = [decoder decodeObjectForKey:@"created_at"];
        self.ID = [decoder decodeInt64ForKey:@"ID"];
        self.pic_urls = [decoder decodeObjectForKey:@"pic_urls"];
        self.reposts_count = [decoder decodeIntForKey:@"reposts_count"];
        self.comments_count = [decoder decodeIntForKey:@"comments_count"];
        self.attitudes_count = [decoder decodeIntForKey:@"attitudes_count"];
        self.user = [decoder decodeObjectForKey:@"user"];
        self.retweeted_status = [decoder decodeObjectForKey:@"retweeted_status"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.text forKey:@"text"];
    [encoder encodeObject:self.source forKey:@"source"];
    [encoder encodeObject:self.created_at forKey:@"created_at"];
    [encoder encodeInt64:self.ID forKey:@"ID"];
    [encoder encodeObject:self.pic_urls forKey:@"pic_urls"];
    [encoder encodeInt:self.reposts_count forKey:@"reposts_count"];
    [encoder encodeInt:self.comments_count forKey:@"comments_count"];
    [encoder encodeInt:self.attitudes_count forKey:@"attitudes_count"];
    [encoder encodeObject:self.user forKey:@"user"];
    [encoder encodeObject:self.retweeted_status forKey:@"retweeted_status"];
}


@end
