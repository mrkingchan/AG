//
//  NNConsumerTradeTitleAmountView.m
//  YWL
//
//  Created by 来旭磊 on 2018/7/9.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNConsumerTradeTitleAmountView.h"

@interface NNConsumerTradeTitleAmountView ()

/** 标题数量 */
@property (nonatomic, strong) UILabel *titleAmountLabel;

@end

@implementation NNConsumerTradeTitleAmountView

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
    [self addSubview:self.titleAmountLabel];
    [self.titleAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset((NNHMargin_15));
        make.centerY.equalTo(self);
    }];

    UIButton *outButton = [UIButton NNHBtnTitle:@"转出" titileFont:[UIConfigManager fontThemeTextTip] backGround:[UIColor whiteColor] titleColor:[UIConfigManager colorThemeRed]];
    NNHViewBorderRadius(outButton, 2, 0.5, [UIConfigManager colorThemeRed])
    [self addSubview:outButton];
    [outButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-NNHMargin_15);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
    [outButton addTarget:self action:@selector(takeoutAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *inButton = [UIButton NNHBorderBtnTitle:@"转入" borderColor:[UIColor akext_colorWithHex:@"#d1d1da"] titleColor:[UIConfigManager colorThemeRed]];
    inButton.hidden = YES;
    inButton.titleLabel.font = [UIConfigManager fontThemeTextTip];
    [self addSubview:inButton];
    [inButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(outButton.mas_left).offset(-NNHMargin_10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
    [inButton addTarget:self action:@selector(takeinAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setBalance:(NSString *)balance
{
    _balance = balance;    
    self.titleAmountLabel.text = [NSString stringWithFormat:@"可用交易余额：%@",balance];
}

- (void)takeinAction
{
    if (self.takeinActionBlock) {
        self.takeinActionBlock();
    }
}

- (void)takeoutAction
{
    if (self.takeoutActionBlock) {
        self.takeoutActionBlock();
    }
}

#pragma mark - Lazy Loads

- (UILabel *)titleAmountLabel
{
    if (_titleAmountLabel == nil) {
        _titleAmountLabel = [UILabel NNHWithTitle:@"可用交易余额：0.00" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
    }
    return _titleAmountLabel;
}



@end
