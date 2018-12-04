//
//  NNConsumerMatchOrderTypeView.m
//  YWL
//
//  Created by 来旭磊 on 2018/7/9.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNConsumerMatchOrderTypeView.h"

@interface NNConsumerMatchOrderTypeView ()

/** 当前选中button */
@property (nonatomic, weak) UIButton *selectedButton;
/** <#注释#> */
@property (nonatomic, weak) UIButton *leftButton;
/** <#注释#> */
@property (nonatomic, weak) UIButton *rightButton;
@end

@implementation NNConsumerMatchOrderTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIConfigManager colorThemeWhite];
    NNHViewBorderRadius(contentView, NNHMargin_15, NNHLineH, [UIColor akext_colorWithHex:@"dcddf1"])
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(NNHMargin_15);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
        make.height.equalTo(@(30));
    }];
    
    UIButton *leftbutton = [UIButton NNHBtnTitle:@"购买" titileFont:[UIConfigManager fontThemeTextDefault] backGround:[UIConfigManager colorThemeWhite] titleColor:[UIConfigManager colorThemeRed]];
    [leftbutton setBackgroundColor:[UIConfigManager colorThemeWhite] forState:UIControlStateNormal];
    [leftbutton setBackgroundColor:[UIColor akext_colorWithHex:@"dcddf1"] forState:UIControlStateSelected];
    [leftbutton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    leftbutton.tag = 0;
    leftbutton.adjustsImageWhenHighlighted = NO;
    leftbutton.selected = YES;
    self.selectedButton = leftbutton;
    [contentView addSubview:leftbutton];
    [leftbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(contentView);
        make.right.equalTo(contentView.mas_centerX);
    }];
    self.leftButton = leftbutton;
    
    UIButton *rightbutton = [UIButton NNHBtnTitle:@"出售" titileFont:[UIConfigManager fontThemeTextDefault] backGround:[UIConfigManager colorThemeWhite] titleColor:[UIConfigManager colorThemeRed]];
    rightbutton.tag = 1;
    [rightbutton setBackgroundColor:[UIConfigManager colorThemeWhite] forState:UIControlStateNormal];
    [rightbutton setBackgroundColor:[UIColor akext_colorWithHex:@"dcddf1"] forState:UIControlStateSelected];
    [rightbutton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    rightbutton.adjustsImageWhenHighlighted = NO;
    [contentView addSubview:rightbutton];
    [rightbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(contentView);
        make.left.equalTo(contentView.mas_centerX);
    }];
    self.rightButton = rightbutton;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    if (selectedIndex == 0) {
        [self selectButton:self.leftButton];
    }else {
        [self selectButton:self.rightButton];
    }
}

- (void)selectButton:(UIButton *)button
{
    if (!button.selected) {
        button.selected = YES;
        self.selectedButton.selected = NO;
        self.selectedButton = button;
        if (self.selectedButtonBlock) {
            self.selectedButtonBlock(button.tag);
        }
    }
}


@end
