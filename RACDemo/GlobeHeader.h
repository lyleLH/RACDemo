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
//#define mWeiBoAppKey                @"3326454558"
#define mWeiBoAppKey                @"2476133309"
//#define mWeiBoAppSecret             @"b4492536fcc92cd7b075d892aa78bd43"
#define mWeiBoAppSecret             @"7503313c823d35fcfb9a721805ef659a"
#define mWeiBoRedirectURI           @"https://api.weibo.com/oauth2/default.html"

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "ReactiveCocoa.h"

#define ZSColor(r, g, b)            [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#if DEBUG
#define ZSLog(format, ...)          NSLog((@"%s [Line %d] " format ), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ZSLog(format, ...)
#endif

/** 昵称的字体 */
#define mStatusNameFont             [UIFont systemFontOfSize:15]

/** 被转发微博作者昵称的字体 */
#define mRetweetStatusNameFont      mStatusNameFont

/** 时间的字体 */
#define mStatusTimeFont             [UIFont systemFontOfSize:12]

/** 来源的字体 */
#define mStatusSourceFont           mStatusTimeFont

/** 正文的字体(用于计算文本的高度, 文本的实际大小由STTwitterLabel决定) */
#define mStatusContentFont          [UIFont systemFontOfSize:15]

/** 被转发微博正文的字体 */
#define mRetweetStatusContentFont   mStatusContentFont

#endif /* GlobeHeader_h */

