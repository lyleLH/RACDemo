//
//  StatusViewModel.m
//  RACDemo
//
//  Created by 張帥 on 2016/7/16.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "StatusViewModel.h"
#import "WBHttpRequest.h"
#import "GlobeHeader.h"

@implementation StatusViewModel

- (NSMutableArray<StatusCellViewModel *> *)dataSource {
    if (!_dataSource) {
        NSMutableArray *array = [NSMutableArray new];
        for (int i = 0; i < 50; i++) {
            StatusCellViewModel *cellModel = [StatusCellViewModel new];
            cellModel.text = [NSString stringWithFormat:@"%d - gtesijglsajhlahljreaiglangsg单肩都发你肯定是你姐夫是电脑跟楼上的过分的话gtesijglsajhlahljreaiglangsggtesijglsajhlahljreaiglanasaa", i];
            cellModel.userName = @"嗚嚕嗚嚕";
            [array addObject:cellModel];
        }
        _dataSource = array;
        
    }
    return _dataSource;
}




@end
