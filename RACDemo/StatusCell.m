//
//  StatusCell.m
//  RACDemo
//
//  Created by 張帥 on 2016/7/14.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "StatusCell.h"
#import "GlobeHeader.h"

@implementation StatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.iconImg = UIImageView.new;
    [self.contentView addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(UIEdgeInsetsMake(8, 8, 8, 8));
        make.width.equalTo(100);
    }];
    self.iconImg.backgroundColor = [UIColor yellowColor];
    
    return self;
}

@end
