//
//  NNConsumerMatchOrderTableViewCell.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/18.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNConsumerMatchOrderTableViewCell.h"

@interface NNConsumerMatchOrderTableViewCell ()

/** 操作图标 */
@property (nonatomic, strong) UIImageView *rankImageView;
/** 电话号码 */
@property (nonatomic, strong) UILabel *mobileLabel;
/** 总金额 */
@property (nonatomic, strong) UILabel *totalAmountLabel;
/** 数量 */
@property (nonatomic, strong) UILabel *countLabel;
/** 单价 */
@property (nonatomic, strong) UILabel *priceLabel;
/** 左侧按钮 */
@property (nonatomic, strong) NSMutableArray *iconArray;

/** 操作按钮 */
@property (nonatomic, strong) UIButton *operationButton;


@end

@implementation NNConsumerMatchOrderTableViewCell

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
    [self.contentView addSubview:self.rankImageView];
    [self.contentView addSubview:self.mobileLabel];
    [self.contentView addSubview:self.totalAmountLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.operationButton];
    
    [self.mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(35);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-NNHMargin_5);
    }];
    
    [self.rankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mobileLabel.mas_left).offset(-NNHMargin_5);
        make.centerY.equalTo(self.mobileLabel);
    }];
    
    [self.operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.centerY.equalTo(self.mobileLabel);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];

    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_centerY).offset(NNHMargin_5);
        make.left.equalTo(self.mobileLabel);
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
        make.centerY.equalTo(self.priceLabel);
        make.left.equalTo(lineView.mas_right).offset(NNHMargin_10);
    }];
    
    [self.totalAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.centerY.equalTo(self.priceLabel);
    }];
    
    UIImageView *leftIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:leftIcon];
    [self.iconArray addObject:leftIcon];
    
    UIImageView *middleIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:middleIcon];
    [self.iconArray addObject:middleIcon];
    
    UIImageView *rightIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:rightIcon];
    [self.iconArray addObject:rightIcon];
    
    [leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(NNHMargin_20, NNHMargin_20));
        make.centerY.equalTo(self.mobileLabel);
        make.left.equalTo(self.mobileLabel.mas_right).offset(NNHMargin_10);
    }];
    
    [middleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(NNHMargin_20, NNHMargin_20));
        make.centerY.equalTo(leftIcon);
        make.left.equalTo(leftIcon.mas_right).offset(5);
    }];
    
    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(NNHMargin_20, NNHMargin_20));
        make.centerY.equalTo(leftIcon);
        make.left.equalTo(middleIcon.mas_right).offset(5);
    }];
}

- (void)setOrderModel:(NNConsumerMatchOrderModel *)orderModel
{
    _orderModel = orderModel;

    self.mobileLabel.text = orderModel.mobile;
    self.totalAmountLabel.text = [NSString stringWithFormat:@"总额：￥%@",orderModel.amount];
    self.priceLabel.text = [NSString stringWithFormat:@"单价：￥%@",orderModel.price];
    self.countLabel.text = [NSString stringWithFormat:@"数量：%@",orderModel.num];
    [self.operationButton setTitle:orderModel.buttonTitle forState:UIControlStateNormal];
    [self.operationButton setTitleColor:orderModel.buttonColor forState:UIControlStateNormal];
    self.operationButton.layer.borderColor = orderModel.buttonColor.CGColor;
    
    self.rankImageView.image = [UIImage imageNamed:orderModel.rankImageName];
    
    for (UIImageView *imageView in self.iconArray) {
        imageView.hidden = YES;
    }
    
    for (int i = 0; i < orderModel.iconNameArray.count; i ++) {
        UIImageView *imageView = self.iconArray[i];
        imageView.image = [UIImage imageNamed:orderModel.iconNameArray[i]];
        imageView.hidden = NO;
    }
}

- (void)operationAction:(UIButton *)button
{
    if (self.actionBlock) {
        self.actionBlock();
    }
}

#pragma mark - Lazy Loads

- (UIImageView *)rankImageView
{
    if (_rankImageView == nil) {
        _rankImageView = [[UIImageView alloc] init];
        _rankImageView.image = [UIImage imageNamed:@"ic_credit_high"];
    }
    return _rankImageView;
}

- (UILabel *)mobileLabel
{
    if (_mobileLabel == nil) {
        _mobileLabel = [UILabel NNHWithTitle:@"13800000000" titleColor:[UIConfigManager colorThemeBlack] font:[UIFont systemFontOfSize:15]];
    }
    return _mobileLabel;
}

- (UILabel *)countLabel
{
    if (_countLabel == nil) {
        _countLabel = [UILabel NNHWithTitle:@"数量：5500" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _countLabel;
}

- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [UILabel NNHWithTitle:@"单价：1.00" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _priceLabel;
}

- (UILabel *)totalAmountLabel
{
    if (_totalAmountLabel == nil) {
        _totalAmountLabel = [UILabel NNHWithTitle:@"￥5500" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIFont systemFontOfSize:13]];
    }
    return _totalAmountLabel;
}

- (NSMutableArray *)iconArray
{
    if (_iconArray == nil) {
        _iconArray = [NSMutableArray array];
    }
    return _iconArray;
}

- (UIButton *)operationButton
{
    if (_operationButton == nil) {
        _operationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _operationButton.titleLabel.font = [UIConfigManager fontThemeTextMiddleTip];
        _operationButton.layer.cornerRadius = NNHMargin_5 * 0.5;
        _operationButton.layer.masksToBounds = YES;
        [_operationButton setBackgroundColor:[UIConfigManager colorThemeWhite] forState:UIControlStateNormal];
        _operationButton.adjustsImageWhenHighlighted = NO;
        [_operationButton setTitleColor:[UIConfigManager colorThemeRed] forState:UIControlStateNormal];
        [_operationButton setTitle:@"买入" forState:UIControlStateNormal];
        _operationButton.layer.borderWidth = NNHLineH;
        _operationButton.layer.borderColor = [UIConfigManager colorThemeRed].CGColor;
        [_operationButton addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
        _operationButton.userInteractionEnabled = NO;
    }
    return _operationButton;
}

@end
