//
//  NNConsumerMatchOrderCoinPriceView.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/18.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNConsumerMatchOrderCoinPriceView.h"

@interface NNConsumerMatchOrderCoinPriceView ()

/** 当前价格 */
@property (nonatomic, strong) UILabel *currentPriceLabel;
/** 最高价格 */
@property (nonatomic, strong) UILabel *heightPriceLabel;
/** 最低价格 */
@property (nonatomic, strong) UILabel *lowPriceLabel;
/** 量 */
@property (nonatomic, strong) UILabel *amountLabel;
/** 幅度 */
@property (nonatomic, strong) UILabel *rangeLabel;

@end


@implementation NNConsumerMatchOrderCoinPriceView

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
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    [self addSubview:backgroundImageView];
    backgroundImageView.image = [UIImage imageNamed:@"top_long_bg"];
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.currentPriceLabel];
    [self.currentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(NNHMargin_15);
        make.centerY.equalTo(self);
    }];
    
//    [self addSubview:self.amountLabel];
//    [self addSubview:self.rangeLabel];
//    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(-NNHMargin_15);
//        make.bottom.equalTo(self.mas_centerY).offset(-NNHMargin_5);
//    }];
//
//    [self.rangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.amountLabel);
//        make.top.equalTo(self.mas_centerY).offset(NNHMargin_5);
//    }];
    
//    [self addSubview:self.heightPriceLabel];
//    [self addSubview:self.lowPriceLabel];
//    [self.heightPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.amountLabel);
//        make.right.equalTo(self.amountLabel.mas_left).offset(-NNHMargin_10);
//    }];
//    [self.lowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.rangeLabel);
//        make.right.equalTo(self.heightPriceLabel);
//    }];
    
    [self addSubview:self.heightPriceLabel];
    [self addSubview:self.lowPriceLabel];
    [self.heightPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-NNHMargin_15);
        make.bottom.equalTo(self.mas_centerY).offset(-NNHMargin_5);
    }];

    [self.lowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.heightPriceLabel);
        make.top.equalTo(self.mas_centerY).offset(NNHMargin_5);
    }];
}

- (void)setMarketModel:(NNCoinMarketModel *)marketModel
{
    _marketModel = marketModel;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@",marketModel.now_price];
    self.heightPriceLabel.text = [NSString stringWithFormat:@"高￥%@",marketModel.max_price];
    self.lowPriceLabel.text = [NSString stringWithFormat:@"低￥%@",marketModel.min_price];
//    self.amountLabel.text = [NSString stringWithFormat:@"量%@",marketModel.market_volume];
//    self.rangeLabel.text = [NSString stringWithFormat:@"幅%@",marketModel.change];
    
}

#pragma mark - Lazy Loads

- (UILabel *)currentPriceLabel
{
    if (_currentPriceLabel == nil) {
        _currentPriceLabel = [UILabel NNHWithTitle:@"￥1.00" titleColor:[UIColor akext_colorWithHex:@"#e7ab38"] font:[UIFont systemFontOfSize:24]];
    }
    return _currentPriceLabel;
}

- (UILabel *)heightPriceLabel
{
    if (_heightPriceLabel == nil) {
        _heightPriceLabel = [UILabel NNHWithTitle:@"高 ￥1.00" titleColor:[UIColor akext_colorWithHex:@"#ff1844"] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _heightPriceLabel;
}

- (UILabel *)lowPriceLabel
{
    if (_lowPriceLabel == nil) {
        _lowPriceLabel = [UILabel NNHWithTitle:@"低 ￥0.52" titleColor:[UIColor akext_colorWithHex:@"#009759"] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _lowPriceLabel;
}

- (UILabel *)amountLabel
{
    if (_amountLabel == nil) {
        _amountLabel = [UILabel NNHWithTitle:@"量416720" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _amountLabel;
}

- (UILabel *)rangeLabel
{
    if (_rangeLabel == nil) {
        _rangeLabel = [UILabel NNHWithTitle:@"幅102%" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _rangeLabel;
}

@end
