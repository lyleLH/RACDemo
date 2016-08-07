//
//  GlobeHeader.h
//  RACDemo
//
//  Created by 張帥 on 2016/7/14.
//  Copyright © 2016年 張帥. All rights reserved.
//

#ifndef GlobeHeader_h
#define GlobeHeader_h

#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "Const.h"

#if DEBUG
#define ZSLog(format, ...)          NSLog((@"%s [Line %d] " format ), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ZSLog(format, ...)
#endif

#endif /* GlobeHeader_h */

