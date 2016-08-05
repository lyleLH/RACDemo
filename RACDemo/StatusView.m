//
//  StatusView.m
//  RACDemo
//
//  Created by 張帥 on 2016/7/15.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "StatusView.h"
#import "GlobeHeader.h"
#import "StatusLabel.h"
#import "StatusRetweetView.h"
#import "StatusPhotoGroupView.h"

@interface StatusView ()

/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) StatusPhotoGroupView *photosView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;

/** 被转发微博的view(父控件) */
@property (nonatomic, weak) StatusRetweetView *retweetView;

@end

@implementation StatusView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    /** 头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    /** 会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [self addSubview:vipView];
    self.vipView = vipView;
    
    /** 配图 */
    StatusPhotoGroupView *photosView = [[StatusPhotoGroupView alloc] init];
    [self addSubview:photosView];
    self.photosView = photosView;
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = mStatusNameFont;
    nameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = mStatusTimeFont;
    timeLabel.textColor = ZSColor(240, 140, 19);
    timeLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = mStatusSourceFont;
    sourceLabel.textColor = ZSColor(135, 135, 135);
    sourceLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = ZSColor(39, 39, 39);
    contentLabel.font = mStatusContentFont;
    contentLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    /** 添加被转发微博的view */
    StatusRetweetView *retweetView = [[StatusRetweetView alloc] init];
    [self addSubview:retweetView];
    self.retweetView = retweetView;
    
    return self;
}

@end
