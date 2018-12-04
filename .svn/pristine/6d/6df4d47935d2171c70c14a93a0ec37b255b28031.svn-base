//
//  NNBuyMinePayMethodCell.m
//  WTA
//
//  Created by 来旭磊 on 2018/9/10.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNBuyMinePayMethodCell.h"
#import "NNBuyMinePayMethodModel.h"

@interface NNBuyMinePayMethodCell ()

/** 选择按钮 */
@property (nonatomic, strong) UIButton *selectedButton;
/** 支付方式名称 */
@property (nonatomic, strong) UILabel *payNameLabel;
/** 可用余额 */
@property (nonatomic, strong) UILabel *amountLabel;
@end

@implementation NNBuyMinePayMethodCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIConfigManager colorThemeWhite];
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    [self.contentView addSubview:self.selectedButton];
    [self.contentView addSubview:self.amountLabel];
    [self.contentView addSubview:self.payNameLabel];
    
    [self.selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(NNHMargin_5);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(NNHNormalViewH, NNHNormalViewH));
    }];
    
    [self.payNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.selectedButton.mas_right).offset(NNHMargin_5);
    }];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setPayMethodModel:(NNBuyMinePayMethodModel *)payMethodModel
{
    _payMethodModel = payMethodModel;
    self.payNameLabel.text = payMethodModel.name;
    self.amountLabel.text = payMethodModel.amount;
    
    self.selectedButton.selected = payMethodModel.selectedFalg;
    
    if (payMethodModel.selectedFalg) {
        self.payNameLabel.textColor = [UIConfigManager colorThemeRed];
    }else {
        self.payNameLabel.textColor = [UIConfigManager colorThemeBlack];
    }
}

#pragma mark - Lazy Loads

- (UILabel *)payNameLabel
{
    if (_payNameLabel == nil) {
        _payNameLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _payNameLabel;
}

- (UILabel *)amountLabel
{
    if (_amountLabel == nil) {
        _amountLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _amountLabel;
}

- (UIButton *)selectedButton
{
    if (_selectedButton == nil) {
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedButton setImage:[UIImage imageNamed:@"ic_not_check_chosse_payment"] forState:UIControlStateNormal];
        [_selectedButton setImage:[UIImage imageNamed:@"ic_check_chosse_payment"] forState:UIControlStateSelected];
        _selectedButton.userInteractionEnabled = NO;
    }
    return _selectedButton;
}

@end
