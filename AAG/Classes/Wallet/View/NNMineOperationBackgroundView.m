//
//  NNMineOperationBackgroundView.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/10.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMineOperationBackgroundView.h"
#import "NNMineOperationRollView.h"

@interface NNMineOperationBackgroundView ()

@end

@implementation NNMineOperationBackgroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor akext_colorWithHex:@"#c17c46"];
        
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    [self setGroup0];
    [self setGroup1];
    [self setGroup2];
    
    NNMineOperationRollView *rollView0 = [[NNMineOperationRollView alloc] initWithCellHeight:40 rollSpeed:10 alpha:1];
    [self addSubview:rollView0];
    [rollView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(-10);
        make.width.equalTo(@(20));
        make.top.bottom.equalTo(self);
    }];
    
    NNMineOperationRollView *rollView1 = [[NNMineOperationRollView alloc] initWithCellHeight:55 rollSpeed:8 alpha:0.6];
    [self addSubview:rollView1];
    [rollView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(20);
        make.width.equalTo(@(25));
        make.top.bottom.equalTo(self);
    }];
}

- (void)setGroup0
{
    CGFloat padding = SCREEN_HEIGHT * 0.23;
    
    NNMineOperationRollView *rollView0 = [[NNMineOperationRollView alloc] initWithCellHeight:20 rollSpeed:8 alpha:0.7f];
    [self addSubview:rollView0];
    [rollView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.equalTo(@(12));
        make.top.bottom.equalTo(self);
    }];
    
    NNMineOperationRollView *rollView1 = [[NNMineOperationRollView alloc] initWithCellHeight:34 rollSpeed:7 alpha:0.3f];
    [self addSubview:rollView1];
    [rollView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.width.equalTo(@(16));
        make.top.bottom.equalTo(self);
    }];
    
    NNMineOperationRollView *rollView2 = [[NNMineOperationRollView alloc] initWithCellHeight:20 rollSpeed:9 alpha:0.7f];
    [self addSubview:rollView2];
    [rollView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.width.equalTo(@(10));
        make.top.bottom.equalTo(self);
    }];
    
    NNMineOperationRollView *rollView3 = [[NNMineOperationRollView alloc] initWithCellHeight:20 rollSpeed:4 alpha:0.f];
    [self addSubview:rollView3];
    [rollView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(@(10));
        make.top.bottom.equalTo(self);
    }];
}

- (void)setGroup1
{
    NNMineOperationRollView *rollView0 = [[NNMineOperationRollView alloc] initWithCellHeight:60 rollSpeed:5 alpha:1];
    [self addSubview:rollView0];
    [rollView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.width.equalTo(@(30));
        make.top.bottom.equalTo(self);
    }];
    
    NNMineOperationRollView *rollView1 = [[NNMineOperationRollView alloc] initWithCellHeight:60 rollSpeed:8 alpha:0.9f];
    [self addSubview:rollView1];
    [rollView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-25);
        make.width.equalTo(@(30));
        make.top.bottom.equalTo(self);
    }];

    NNMineOperationRollView *rollView2 = [[NNMineOperationRollView alloc] initWithCellHeight:52 rollSpeed:5 alpha:0.7f];
    [self addSubview:rollView2];
    [rollView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-80);
        make.width.equalTo(@(25));
        make.top.bottom.equalTo(self);
    }];

    NNMineOperationRollView *rollView3 = [[NNMineOperationRollView alloc] initWithCellHeight:55 rollSpeed:6 alpha:0.7];
    [self addSubview:rollView3];
    [rollView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(90);
        make.width.equalTo(@(25));
        make.top.bottom.equalTo(self);
    }];
}

- (void)setGroup2
{
    NNMineOperationRollView *rollView0 = [[NNMineOperationRollView alloc] initWithCellHeight:60 rollSpeed:4 alpha:1];
    [self addSubview:rollView0];
    [rollView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(SCREEN_WIDTH * 0.33);
        make.width.equalTo(@(30));
        make.top.bottom.equalTo(self);
    }];
    
    NNMineOperationRollView *rollView1 = [[NNMineOperationRollView alloc] initWithCellHeight:40 rollSpeed:8 alpha:0.9f];
    [self addSubview:rollView1];
    [rollView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-SCREEN_WIDTH * 0.3);
        make.width.equalTo(@(20));
        make.top.bottom.equalTo(self);
    }];
    
    NNMineOperationRollView *rollView2 = [[NNMineOperationRollView alloc] initWithCellHeight:45 rollSpeed:3 alpha:0.4f];
    [self addSubview:rollView2];
    [rollView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rollView1.mas_right).offset(20);
        make.width.equalTo(@(22));
        make.top.bottom.equalTo(self);
    }];

    NNMineOperationRollView *rollView3 = [[NNMineOperationRollView alloc] initWithCellHeight:50 rollSpeed:5 alpha:0.3];
    [self addSubview:rollView3];
    [rollView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rollView0.mas_left).offset(-30);
        make.width.equalTo(@(24));
        make.top.bottom.equalTo(self);
    }];
}

- (void)stopTimer
{
    [self.subviews makeObjectsPerformSelector:@selector(stop)];
}

@end
