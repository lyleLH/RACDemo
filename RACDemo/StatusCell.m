//
//  StatusCell.m
//  RACDemo
//
//  Created by 張帥 on 2016/7/14.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "StatusCell.h"
#import "GlobeHeader.h"
#import "UIImageView+WebCache.h"

@interface StatusCell ()

@property(nonatomic, strong) UIImageView *iconImg;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation StatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
     self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 添加视图
    [self addViews];
    
    // 进行布局
    [self defineLayout];
    
    // V绑定VM
    [self bindWithViewModel];
    
    return self;
}

- (void)addViews {
    self.iconImg = [UIImageView new];
    [self.contentView addSubview:self.iconImg];
    
    self.nameLabel = [UILabel new];
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    
    self.contentLabel = [UILabel new];
    [self.contentView addSubview:self.contentLabel];
    self.contentLabel.numberOfLines = 0;
}

- (void)defineLayout {
    @weakify(self);
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(UIEdgeInsetsMake(16, 16, 16, 16));
        make.size.equalTo(40);
        make.right.bottom.lessThanOrEqualTo(UIEdgeInsetsMake(16, 16, 16, 16));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self.iconImg);
        make.left.equalTo(self.iconImg.mas_right).offset(16);
        make.right.top.bottom.lessThanOrEqualTo(UIEdgeInsetsMake(16, 16, 16, 16));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.iconImg.mas_bottom).offset(8);
        make.left.right.equalTo(UIEdgeInsetsMake(16, 16, 16, 16));
        make.bottom.lessThanOrEqualTo(UIEdgeInsetsMake(16, 16, 16, 16));
    }];
}

- (void)bindWithViewModel {
    @weakify(self);
    [RACObserve(self, viewModel) subscribeNext:^(StatusCellViewModel *viewModel) {
        @strongify(self);
        [self.iconImg sd_setImageWithURL:[NSURL URLWithString:viewModel.avatar] placeholderImage:[UIImage imageNamed:@"avatar_default_big"]];
        self.nameLabel.text = viewModel.userName;
        self.contentLabel.text = viewModel.text;
    }];
}

@end
