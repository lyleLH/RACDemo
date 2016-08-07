//
//  GlobeHeader.h
//  RACDemo
//
//  Created by 張帥 on 2016/7/14.
//  Copyright © 2016年 張帥. All rights reserved.
//

#ifndef GlobeHeader_h
#define GlobeHeader_h

// Sina Weibo
#define mWeiBoAppKey                @"2476133309"
#define mWeiBoAppSecret             @"7503313c823d35fcfb9a721805ef659a"
#define mWeiBoRedirectURI           @"https://api.weibo.com/oauth2/default.html"

#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "ReactiveCocoa.h"

#define ZSColor(r, g, b)            [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#if DEBUG
#define ZSLog(format, ...)          NSLog((@"%s [Line %d] " format ), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ZSLog(format, ...)
#endif

#endif /* GlobeHeader_h */

