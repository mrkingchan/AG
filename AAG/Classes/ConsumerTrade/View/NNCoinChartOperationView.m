//
//  NNCoinChartOperationView.m
//  YWL
//
//  Created by 来旭磊 on 2018/8/1.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNCoinChartOperationView.h"
#import "UIColor+Y_StockChart.h"

@interface NNCoinChartOperationView ()


@end

@implementation NNCoinChartOperationView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor backgroundColor];
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    UIButton *leftButton = [self createButtonWithButtonTitle:@"我要发布" tag:0];
    UIButton *middleButton = [self createButtonWithButtonTitle:@"我要买入" tag:1];
    UIButton *righeButton = [self createButtonWithButtonTitle:@"我要卖出" tag:2];
    
    [self addSubview:leftButton];
    [self addSubview:middleButton];
    [self addSubview:righeButton];
    
    CGFloat buttonW = (SCREEN_WIDTH - 50 - 60) / 3;
    
    [middleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.equalTo(@(30));
        make.width.equalTo(@(buttonW));
    }];

    
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(NNHMargin_25);
        make.height.equalTo(@(30));
        make.width.equalTo(@(buttonW));
    }];
    
    
    [righeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-NNHMargin_20);
        make.height.equalTo(@(30));
        make.width.equalTo(@(buttonW));
    }];
}

- (void)buttonAction:(UIButton *)button
{
    if (self.operationBlock) {
        self.operationBlock(button.tag);
    }
}

- (UIButton *)createButtonWithButtonTitle:(NSString *)title tag:(NSInteger)tag
{
    UIButton *button = [UIButton NNHBorderBtnTitle:title borderColor:[UIConfigManager colorThemeWhite] titleColor:[UIConfigManager colorThemeWhite]];
    button.tag = tag;
    button.adjustsImageWhenHighlighted = NO;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
