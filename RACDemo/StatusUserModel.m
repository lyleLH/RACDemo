//
//  UserInfo.m
//  RACDemo
//
//  Created by 張帥 on 2016/7/16.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "StatusUserModel.h"
#import <MJExtension/MJExtension.h>

@implementation StatusUserModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id", @"mDescription" : @"description"};
}

#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.ID = [decoder decodeInt64ForKey:@"ID"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.mDescription = [decoder decodeObjectForKey:@"mDescription"];
        self.location = [decoder decodeObjectForKey:@"location"];
        
        self.profile_image_url = [decoder decodeObjectForKey:@"profile_image_url"];
        self.avatar_large = [decoder decodeObjectForKey:@"avatar_large"];
        self.avatar_hd = [decoder decodeObjectForKey:@"avatar_hd"];
        
        self.mbrank = [decoder decodeIntForKey:@"mbrank"];
        self.mbtype = [decoder decodeIntForKey:@"mbtype"];
        
        self.followers_count = [decoder decodeIntForKey:@"followers_count"];
        self.friends_count = [decoder decodeIntForKey:@"friends_count"];
        self.statuses_count = [decoder decodeIntForKey:@"statuses_count"];
        self.favourites_count = [decoder decodeIntForKey:@"favourites_count"];
        
        self.created_at = [decoder decodeObjectForKey:@"created_at"];
        self.lang = [decoder decodeObjectForKey:@"lang"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt64:self.ID forKey:@"ID"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.mDescription forKey:@"mDescription"];
    [encoder encodeObject:self.location forKey:@"location"];
    
    [encoder encodeObject:self.profile_image_url forKey:@"profile_image_url"];
    [encoder encodeObject:self.avatar_large forKey:@"avatar_large"];
    [encoder encodeObject:self.avatar_hd forKey:@"avatar_hd"];
    
    [encoder encodeInt:self.mbrank forKey:@"mbrank"];
    [encoder encodeInt:self.mbtype forKey:@"mbtype"];
    
    [encoder encodeInt:self.followers_count forKey:@"followers_count"];
    [encoder encodeInt:self.friends_count forKey:@"friends_count"];
    [encoder encodeInt:self.statuses_count forKey:@"statuses_count"];
    [encoder encodeInt:self.favourites_count forKey:@"favourites_count"];
    
    [encoder encodeObject:self.created_at forKey:@"created_at"];
    [encoder encodeObject:self.lang forKey:@"lang"];
}

@end
