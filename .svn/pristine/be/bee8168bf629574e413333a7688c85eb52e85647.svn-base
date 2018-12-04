//
//  NNConsumerTradeDetailOrderInfoView.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/21.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNConsumerTradeDetailOrderInfoView.h"

@interface NNConsumerTradeDetailOrderInfoView ()

/** 订单编号 */
@property (nonatomic, strong) UILabel *orderNumLabel;
/** 违规原因label */
@property (nonatomic, strong) UILabel *reasonLabel;
/** 单价 */
@property (nonatomic, strong) UILabel *priceLabel;
/** 数量 */
@property (nonatomic, strong) UILabel *countLabel;
/** 状态label */
@property (nonatomic, strong) UILabel *statusLabel;
/** 时间 */
@property (nonatomic, strong) UILabel *timeLabel;
/** 总价 */
@property (nonatomic, strong) UILabel *totalAmountLabel;
/** 手续费 */
@property (nonatomic, strong) UILabel *feeLabel;
/** 状态label */
@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation NNConsumerTradeDetailOrderInfoView

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
    [self addSubview:self.orderNumLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.countLabel];
    [self addSubview:self.statusLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.totalAmountLabel];
    [self addSubview:self.feeLabel];
    [self addSubview:self.messageLabel];
    
    [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(NNHMargin_15);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(NNHLineH));
        make.bottom.equalTo(self.orderNumLabel);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(NNHMargin_15);
        make.top.equalTo(lineView).offset(NNHMargin_15);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(NNHMargin_15);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(NNHMargin_15);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.priceLabel);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.statusLabel);
        make.width.equalTo(@(SCREEN_WIDTH * 0.5 - 20));
    }];
    
    [self.totalAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(NNHMargin_15);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(NNHMargin_15);
    }];
    
    [self.feeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.totalAmountLabel);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(NNHMargin_15);
        make.top.equalTo(self.totalAmountLabel.mas_bottom).offset(NNHMargin_15);
        make.bottom.equalTo(self).offset(-NNHMargin_20);
    }];
    
    CGFloat height = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.nnh_height = height;
}

- (void)setOrderModel:(NNConsumerOrderDetailModel *)orderModel
{
    _orderModel = orderModel;
    self.orderNumLabel.text = [NSString stringWithFormat:@"单号：%@",orderModel.orderno];
    self.priceLabel.text = [NSString stringWithFormat:@"价格：￥%@",orderModel.price];
    self.countLabel.text = [NSString stringWithFormat:@"数量：%@",orderModel.num];
    self.statusLabel.text = [NSString stringWithFormat:@"状态：%@",orderModel.statusstr];;
    self.totalAmountLabel.text = [NSString stringWithFormat:@"总额：￥%@",orderModel.amount];
    self.feeLabel.text = [orderModel.orderstatus.type integerValue] == 1 ? [NSString stringWithFormat:@"奖励数量：%@",orderModel.fee] : [NSString stringWithFormat:@"手续费：%@",orderModel.fee];
    self.messageLabel.text = orderModel.remark;
    self.messageLabel.hidden = [orderModel.orderstatus.type integerValue] == 1;
    
    self.timeLabel.text = [NSString stringWithFormat:@"剩余支付时间：%@",orderModel.orderstatus.statusinfo];
    
    self.timeLabel.textColor = [UIConfigManager colorThemeBlack];
    if ([orderModel.statusintro isEqualToString:@"0"]) {
        self.timeLabel.text = @"";
    }else if ([orderModel.statusintro isEqualToString:@"1"]) {
        self.timeLabel.text = [NSString stringWithFormat:@"剩余支付时间：%@",orderModel.orderstatus.statusinfo];
    }else if ([orderModel.statusintro isEqualToString:@"2"]) {
        self.timeLabel.text = [NSString stringWithFormat:@"剩余确认时间：%@",orderModel.orderstatus.statusinfo];
    }else if ([orderModel.statusintro isEqualToString:@"3"]) {
        self.timeLabel.textColor = [UIColor redColor];
        self.timeLabel.text = [NSString stringWithFormat:@"违规原因：%@",orderModel.reason];
    }else if ([orderModel.statusintro isEqualToString:@"4"]) {
        self.timeLabel.text = [NSString stringWithFormat:@"撤销时间：%@",orderModel.orderstatus.statusinfo];
    }else if ([orderModel.statusintro isEqualToString:@"5"]) {
        self.timeLabel.text = @"";
    }
}

#pragma mark - Lazy Loads

- (UILabel *)orderNumLabel
{
    if (_orderNumLabel == nil) {
        _orderNumLabel = [UILabel NNHWithTitle:@"单号：" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _orderNumLabel;
}

- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [UILabel NNHWithTitle:@"价格：" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
    }
    return _priceLabel;
}

- (UILabel *)countLabel
{
    if (_countLabel == nil) {
        _countLabel = [UILabel NNHWithTitle:@"数量：" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
    }
    return _countLabel;
}

- (UILabel *)statusLabel
{
    if (_statusLabel == nil) {
        _statusLabel = [UILabel NNHWithTitle:@"状态：" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
    }
    return _statusLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel NNHWithTitle:@"剩余支付时间：" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
        _timeLabel.numberOfLines = 2;
    }
    return _timeLabel;
}

- (UILabel *)totalAmountLabel
{
    if (_totalAmountLabel == nil) {
        _totalAmountLabel = [UILabel NNHWithTitle:@"总额：" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
    }
    return _totalAmountLabel;
}

- (UILabel *)feeLabel
{
    if (_feeLabel == nil) {
        _feeLabel = [UILabel NNHWithTitle:@"手续费：" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
    }
    return _feeLabel;
}

- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        _messageLabel = [UILabel NNHWithTitle:@"注：手续费在成交数量中扣除" titleColor:[UIColor redColor] font:[UIConfigManager fontThemeTextTip]];
    }
    return _messageLabel;
    
}

- (UILabel *)reasonLabel
{
    if (_reasonLabel == nil) {
        _reasonLabel = [UILabel NNHWithTitle:@"" titleColor:[UIColor redColor] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _reasonLabel;
}

@end
