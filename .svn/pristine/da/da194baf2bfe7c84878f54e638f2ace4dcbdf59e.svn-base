//
//  NNHConsumerHistoryEntrustTableViewCell.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/16.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNHConsumerHistoryEntrustTableViewCell.h"

@interface NNHConsumerHistoryEntrustTableViewCell ()

/** 操作类型图片 */
@property (nonatomic, strong) UIImageView *operationImageView;
/** 手机号 */
@property (nonatomic, strong) UILabel *mobileLabel;
/** 数量 */
@property (nonatomic, strong) UILabel *countLabel;
/** 单价 */
@property (nonatomic, strong) UILabel *priceLabel;
/** 总金额 */
@property (nonatomic, strong) UILabel *totalAmountLabel;
/** 成交时间 */
@property (nonatomic, strong) UILabel *timeLabel;
/** 操作图标 */
@property (nonatomic, strong) UIImageView *rankImageView;

/** <#注释#> */
@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation NNHConsumerHistoryEntrustTableViewCell

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
    [self.contentView addSubview:self.operationImageView];
    [self.contentView addSubview:self.rankImageView];
    [self.contentView addSubview:self.mobileLabel];
    [self.contentView addSubview:self.totalAmountLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.timeLabel];
    
    [self.mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel).offset(NNHMargin_20);
        make.top.equalTo(self.contentView.mas_top).offset(NNHMargin_15);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(50);
        make.top.equalTo(self.mobileLabel.mas_bottom).offset(NNHMargin_10);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    lineView.backgroundColor = [UIColor akext_colorWithHex:@"#cccccc"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset(NNHMargin_10);
        make.centerY.equalTo(self.priceLabel);
        make.width.equalTo(@(NNHLineH));
        make.height.equalTo(self.priceLabel).multipliedBy(0.8);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right).offset(NNHMargin_10);
        make.centerY.equalTo(self.priceLabel);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(NNHMargin_10);
    }];
    
    [self.totalAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.centerY.equalTo(self.priceLabel);
    }];
    
    [self.rankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mobileLabel.mas_left).offset(-NNHMargin_5);
        make.centerY.equalTo(self.operationImageView);
    }];
    
    [self.operationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mobileLabel);
        make.right.equalTo(self.rankImageView.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(26, 15));
    }];
    
    [self.contentView addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.centerY.equalTo(self.mobileLabel);
    }];
    
}

- (void)setOrderModel:(NNHConsumerTradeOrderModel *)orderModel
{
    _orderModel = orderModel;
    self.mobileLabel.text = orderModel.mobile;
    self.totalAmountLabel.text = [NSString stringWithFormat:@"总额：%@",orderModel.amount];
    self.countLabel.text = [NSString stringWithFormat:@"数量：%@",orderModel.num];
    self.priceLabel.text = [NSString stringWithFormat:@"价格：¥%@",orderModel.price];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",orderModel.addtime];
    
    self.statusLabel.text = orderModel.tradeact.statusstr;
    
    if ([orderModel.tradeact.type isEqualToString:@"2"]) {
        self.operationImageView.image = [UIImage imageNamed:@"ic_trade_sell"];
    }else {
        self.operationImageView.image = [UIImage imageNamed:@"ic_trade_buy"];
    }
    
    if ([orderModel.statusintro isEqualToString:@"3"]) {
        self.statusLabel.textColor = [UIColor redColor];
    }else {
        self.statusLabel.textColor = [UIConfigManager colorThemeDark];
    }
}

#pragma mark - Lazy Loads

- (UILabel *)mobileLabel
{
    if (_mobileLabel == nil) {
        _mobileLabel = [UILabel NNHWithTitle:@"13800000000" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextImportant]];
    }
    return _mobileLabel;
}

- (UILabel *)countLabel
{
    if (_countLabel == nil) {
        _countLabel = [UILabel NNHWithTitle:@"数量：" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextTip]];
    }
    return _countLabel;
}

- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [UILabel NNHWithTitle:@"价格：" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextTip]];
    }
    return _priceLabel;
}

- (UILabel *)totalAmountLabel
{
    if (_totalAmountLabel == nil) {
        _totalAmountLabel = [UILabel NNHWithTitle:@"0.00" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextMain]];
    }
    return _totalAmountLabel;
}

- (UILabel *)statusLabel
{
    if (_statusLabel == nil) {
        _statusLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextMain]];
    }
    return _statusLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel NNHWithTitle:@"2018-01-01" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextTip]];
    }
    return _timeLabel;
}

- (UIImageView *)operationImageView
{
    if (_operationImageView == nil) {
        _operationImageView = [[UIImageView alloc] init];
        _operationImageView.image = [UIImage imageNamed:@"ic_trade_buy"];
    }
    return _operationImageView;
}

- (UIImageView *)rankImageView
{
    if (_rankImageView == nil) {
        _rankImageView = [[UIImageView alloc] init];
        _rankImageView.image = [UIImage imageNamed:@"ic_credit_high"];
    }
    return _rankImageView;
}

@end
