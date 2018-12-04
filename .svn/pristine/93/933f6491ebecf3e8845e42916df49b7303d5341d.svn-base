//
//  NNMyOrderCell.m
//  WTA
//
//  Created by 牛牛 on 2018/9/10.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMyOrderCell.h"

@interface NNMyOrderCell ()

/** 订单号 */
@property (nonatomic, strong) UILabel *orderNumLabel;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 状态 */
@property (nonatomic, strong) UILabel *statusLabel;
/** 金额 */
@property (nonatomic, strong) UILabel *amountLabel;
/** 时间 */
@property (nonatomic, strong) UILabel *timeLabel;
/** 撤单时间 */
@property (nonatomic, strong) UILabel *cancelTimeLabel;
/** 按钮 */
@property (nonatomic, weak) UIButton *cancleButton;


@end

@implementation NNMyOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        NNHViewRadius(self, 5);
        
        [self setupChlidView];
    }
    return self;
}

- (void)setupChlidView
{
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.cancelTimeLabel];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView);
        make.right.lessThanOrEqualTo(self.cancelTimeLabel.mas_left).offset(-10);
        make.height.equalTo(@44);
    }];
    
    [self.cancelTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.left.greaterThanOrEqualTo(self.timeLabel.mas_right).offset(10);
        make.centerY.equalTo(self.timeLabel);
    }];
    
    UIView *lineView = [UIView lineView];
    [self.timeLabel addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.timeLabel);
        make.height.equalTo(@(NNHLineH));
    }];
    
    [self.contentView addSubview:self.orderNumLabel];
    [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(15);
        make.left.equalTo(self.contentView).offset(15);
    }];
    
    [self.contentView addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderNumLabel);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderNumLabel.mas_bottom).offset(15);
        make.left.equalTo(self.orderNumLabel);
    }];
    
    [self.contentView addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.left.equalTo(self.orderNumLabel);
    }];
    
    UIButton *cancleButton = [UIButton NNHBtnTitle:@"撤销" titileFont:[UIConfigManager fontThemeTextTip] backGround:[UIColor akext_colorWithHex:@"e5e5e5"] titleColor:[UIConfigManager colorThemeDarkGray]];
    [cancleButton addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    cancleButton.hidden = YES;
    NNHViewRadius(cancleButton, 27 *0.5);
    [self.contentView addSubview:cancleButton];
    _cancleButton = cancleButton;
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(self.amountLabel);
        make.right.equalTo(self.contentView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(62, 27));
    }];
}

- (void)setOrderModel:(NNMyOrderModel *)orderModel
{
    _orderModel = orderModel;
    
    self.orderNumLabel.text = orderModel.orderno;
    self.titleLabel.text = orderModel.ltcname;
    self.amountLabel.text = orderModel.amount;
    self.timeLabel.text = [NSString stringWithFormat:@"    %@",orderModel.addtime];
    self.cancelTimeLabel.text = orderModel.righttimestr;
    self.statusLabel.text = orderModel.statusStr;
    self.cancleButton.hidden = orderModel.orderact.count == 0;
}

- (void)cancleAction
{
    if (self.cancleOrderBlock) {
        self.cancleOrderBlock(self.orderModel);
    }
}

- (UILabel *)orderNumLabel
{
    if (_orderNumLabel == nil) {
        _orderNumLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextDefault]];
        _orderNumLabel.backgroundColor = [UIColor whiteColor];
    }
    return _orderNumLabel;
}

- (UILabel *)statusLabel
{
    if (_statusLabel == nil) {
        _statusLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextDefault]];
        _statusLabel.backgroundColor = [UIColor whiteColor];
    }
    return _statusLabel;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel NNHWithTitle:@"" titleColor:[UIColor blackColor] font:[UIConfigManager fontThemeTextDefault]];
        _titleLabel.backgroundColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UILabel *)amountLabel
{
    if (_amountLabel == nil) {
        _amountLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextDefault]];
        _amountLabel.backgroundColor = [UIColor whiteColor];
    }
    return _amountLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextMiddleTip]];
        _timeLabel.backgroundColor = [UIColor whiteColor];
        NNHViewRadius(_timeLabel, 5);
    }
    return _timeLabel;
}

- (UILabel *)cancelTimeLabel
{
    if (_cancelTimeLabel == nil) {
        _cancelTimeLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextMinTip]];
        _cancelTimeLabel.backgroundColor = [UIColor whiteColor];
    }
    return _cancelTimeLabel;
}

@end
