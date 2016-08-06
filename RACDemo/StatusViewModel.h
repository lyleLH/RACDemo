//
//  StatusViewModel.h
//  RACDemo
//
//  Created by 張帥 on 2016/7/16.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusCellViewModel.h"
#import "GlobeHeader.h"

@interface StatusViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<StatusCellViewModel *> *dataSource;

@property (nonatomic, strong) RACCommand *loginCommand;

@property (nonatomic, strong) RACCommand *setupUserDataCommand;

@end
