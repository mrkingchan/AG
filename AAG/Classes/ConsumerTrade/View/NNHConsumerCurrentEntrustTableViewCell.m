//
//  NNHConsumerCurrentEntrustTableViewCell.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/15.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNHConsumerCurrentEntrustTableViewCell.h"

@interface NNHConsumerCurrentEntrustTableViewCell ()

/** 买入、卖出类型 */
@property (nonatomic, strong) UILabel *operationTypeLabel;
/** 用户电话号码 */
@property (nonatomic, strong) UILabel *mobileLabel;
/** 数量 */
@property (nonatomic, strong) UILabel *countLabel;
/** 单价 */
@property (nonatomic, strong) UILabel *priceLabel;
/** 总价 */
@property (nonatomic, strong) UILabel *totalAmountLabel;
/** 操作按钮 */
@property (nonatomic, strong) UIButton *operationButton;
/** 时间 */
@property (nonatomic, strong) UILabel *timeLabel;
/** 状态label */
@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation NNHConsumerCurrentEntrustTableViewCell

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
    [self.contentView addSubview:self.operationTypeLabel];
    [self.contentView addSubview:self.mobileLabel];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.totalAmountLabel];
    [self.contentView addSubview:self.operationButton];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.statusLabel];
    
    [self.operationTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(NNHMargin_20);
        make.left.equalTo(self.contentView).offset(NNHMargin_15);
    }];
    
    [self.mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.operationTypeLabel);
        make.top.equalTo(self.operationTypeLabel.mas_bottom).offset(NNHMargin_10);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mobileLabel);
        make.top.equalTo(self.mobileLabel.mas_bottom).offset(NNHMargin_10);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    lineView.backgroundColor = [UIColor akext_colorWithHex:@"#cccccc"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset(NNHMargin_10);
        make.centerY.equalTo(self.countLabel);
        make.width.equalTo(@(NNHLineH));
        make.height.equalTo(self.priceLabel).multipliedBy(0.8);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right).offset(NNHMargin_10);
        make.centerY.equalTo(self.priceLabel);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mobileLabel);
        make.top.equalTo(self.countLabel.mas_bottom).offset(NNHMargin_10);
    }];
    
    [self.totalAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.centerY.equalTo(self.mobileLabel);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.operationTypeLabel);
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
    }];
    
    [self.operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.size.mas_equalTo(CGSizeMake(80, 24));
        make.bottom.equalTo(self.timeLabel);
    }];
}

- (void)setOrderModel:(NNHConsumerTradeOrderModel *)orderModel
{
    _orderModel = orderModel;
    if ([orderModel.type isEqualToString:@"2"]) {
        self.operationTypeLabel.text = @"卖出";
        self.mobileLabel.text = [NSString stringWithFormat:@"买家：%@",orderModel.mobile];
        self.operationTypeLabel.textColor = [UIColor akext_colorWithHex:@"#ff1844"];
    }else {
        self.operationTypeLabel.text = @"买入";
        self.mobileLabel.text = [NSString stringWithFormat:@"卖家：%@",orderModel.mobile];
        self.operationTypeLabel.textColor = [UIColor akext_colorWithHex:@"#009759"];
    }
    if (orderModel.mobile.length == 0) {
        self.mobileLabel.text = @"";
    }
    
    self.totalAmountLabel.text = [NSString stringWithFormat:@"¥%@",orderModel.amount];
    self.countLabel.text = [NSString stringWithFormat:@"数量：%@",orderModel.num];
    self.priceLabel.text = [NSString stringWithFormat:@"价格：¥%@",orderModel.price];
    
    self.statusLabel.text = orderModel.tradeact.statusstr;
    self.timeLabel.text = orderModel.addtime;
    
    [self.operationButton setTitle:orderModel.tradeact.actstr forState:UIControlStateNormal];
    self.operationButton.hidden = orderModel.tradeact.actstr.length == 0;
    
    CGFloat width = [self getWidthWithText:orderModel.tradeact.actstr height:24 font:12];
    [self.operationButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.size.mas_equalTo(CGSizeMake(width + 20, 24));
        make.bottom.equalTo(self.timeLabel);
    }];
}

- (void)operationAction:(UIButton *)button
{
    if (self.operationActionBlock) {
        self.operationActionBlock(self.orderModel);
    }
}

#pragma mark - Lazy Loads

- (UILabel *)operationTypeLabel
{
    if (_operationTypeLabel == nil) {
        _operationTypeLabel = [UILabel NNHWithTitle:@"买入" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextImportant]];
    }
    return _operationTypeLabel;
}

- (UILabel *)mobileLabel
{
    if (_mobileLabel == nil) {
        _mobileLabel = [UILabel NNHWithTitle:@"卖家：" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _mobileLabel;
}

- (UILabel *)countLabel
{
    if (_countLabel == nil) {
        _countLabel = [UILabel NNHWithTitle:@"数量：" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _countLabel;
}

- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [UILabel NNHWithTitle:@"单价：" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _priceLabel;
}

- (UILabel *)totalAmountLabel
{
    if (_totalAmountLabel == nil) {
        _totalAmountLabel = [UILabel NNHWithTitle:@"￥100" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _totalAmountLabel;
}

- (UIButton *)operationButton
{
    if (_operationButton == nil) {
        _operationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _operationButton.titleLabel.font = [UIConfigManager fontThemeTextTip];
        _operationButton.layer.cornerRadius = NNHMargin_5 * 0.5;
        _operationButton.layer.masksToBounds = YES;
        [_operationButton setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
        _operationButton.adjustsImageWhenHighlighted = NO;
        [_operationButton setTitleColor:[UIConfigManager colorThemeWhite] forState:UIControlStateNormal];
        [_operationButton setTitle:@"撤销" forState:UIControlStateNormal];
        _operationButton.userInteractionEnabled = NO;
    }
    return _operationButton;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _timeLabel;
}

- (UILabel *)statusLabel
{
    if (_statusLabel == nil) {
        _statusLabel = [UILabel NNHWithTitle:@"未成交" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _statusLabel;
}

- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    if (rect.size.width < 40) {
        return 40;
    }
    
    return rect.size.width;
}




@end
