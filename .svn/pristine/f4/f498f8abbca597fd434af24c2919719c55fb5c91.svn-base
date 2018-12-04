//
//  NNWalletTableHeaderView.m
//  YWL
//
//  Created by 来旭磊 on 2018/4/25.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNWalletTableHeaderView.h"

@interface NNWalletTableHeaderView ()
/** <#注释#> */
@property (nonatomic, weak) UIView *topView;

/** 总算力 */
@property (nonatomic, strong) UILabel *powerLabel;
/** 总产量 */
@property (nonatomic, strong) UILabel *outputLabel;
@end

@implementation NNWalletTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIConfigManager colorThemeWhite];
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    UIView *topVeiw = [[UIView alloc] init];
    [self addSubview:topVeiw];
    self.topView = topVeiw;
    [topVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@(80));
    }];
    
    UIView *middleVeiw = [[UIView alloc] init];
    middleVeiw.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    [self addSubview:middleVeiw];
    [middleVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(topVeiw.mas_bottom);
        make.height.equalTo(@(10));
    }];
    

    [self setupTopView];
}

- (void)setupTopView
{
    UILabel *powerLabel = [UILabel NNHWithTitle:@"运行总算力(T)" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
    powerLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *outputLabel = [UILabel NNHWithTitle:@"运行总产量(NBT/T)" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
    outputLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.topView addSubview:powerLabel];
    [self.topView addSubview:outputLabel];
    
    CGFloat width = SCREEN_WIDTH * 0.5;
    
    [powerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView);
        make.top.equalTo(self.topView.mas_centerY).offset(NNHMargin_5);
        make.width.equalTo(@(width));
    }];
    [outputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(powerLabel.mas_right);
        make.top.equalTo(self.topView.mas_centerY).offset(NNHMargin_5);
        make.width.equalTo(@(width));
    }];
    
    [self.topView addSubview:self.powerLabel];
    [self.topView addSubview:self.outputLabel];

    [self.powerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(powerLabel);
        make.bottom.equalTo(self.topView.mas_centerY).offset(-NNHMargin_5);

    }];
    [self.outputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(outputLabel);
        make.bottom.equalTo(self.topView.mas_centerY).offset(-NNHMargin_5);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    [self.topView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.topView);
        make.centerX.equalTo(self.topView);
        make.width.equalTo(@(1));
    }];
}

- (void)configPower:(NSString *)power output:(NSString *)output
{
    self.powerLabel.text = power;
    self.outputLabel.text = output;
}

#pragma mark - Lazy Loads

- (UILabel *)powerLabel
{
    if (_powerLabel == nil) {
        _powerLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeLargerBtnTitles]];
    }
    return _powerLabel;
}

- (UILabel *)outputLabel
{
    if (_outputLabel == nil) {
        _outputLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeLargerBtnTitles]];
    }
    return _outputLabel;
}

@end
