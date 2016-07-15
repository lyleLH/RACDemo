//
//  GlobeHeader.h
//  RACDemo
//
//  Created by 張帥 on 2016/7/14.
//  Copyright © 2016年 張帥. All rights reserved.
//

#ifndef GlobeHeader_h
#define GlobeHeader_h

// 新浪微博
#define mWeiBoAppKey                @"3326454558"
#define mWeiBoAppSecret             @"b4492536fcc92cd7b075d892aa78bd43"
#define mWeiBoRedirectURI           @"https://api.weibo.com/oauth2/default.html"

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"
#import "ReactiveCocoa.h"

#if DEBUG
#define ZSLog(format, ...)      NSLog((@"%s [Line %d] " format ), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ZSLog(format, ...)
#endif

#endif /* GlobeHeader_h */

