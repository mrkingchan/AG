//
//  NNCoinChartTopView.m
//  SuperWallet
//
//  Created by 牛牛 on 2018/3/30.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNCoinChartTopView.h"
#import "UIColor+Y_StockChart.h"
#import "NNCoinMarketModel.h"

@interface NNCoinChartTopView ()

/** cny最新价 */
@property (nonatomic, strong) UILabel *lastLabel;
/** 涨跌 */
@property (nonatomic, strong) UILabel *changeLabel;
/** 成交量 */
@property (nonatomic, strong) UILabel *volLabel;
/** 最高价 */
@property (nonatomic, strong) UILabel *highLabel;
/** 最低价 */
@property (nonatomic, strong) UILabel *lowLabel;

@end

@implementation NNCoinChartTopView

- (instancetype)init
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor backgroundColor];
        
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    [self addSubview:self.lastLabel];
    [self.lastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self);
    }];
    
//    [self addSubview:self.highLabel];
//    [self.highLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(15);
//        make.top.equalTo(self.lastLabel.mas_bottom).offset(20);
//    }];
//
//    [self addSubview:self.lowLabel];
//    [self.lowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(15);
//        make.top.equalTo(self.highLabel.mas_bottom).offset(15);
//    }];
    
//    [self addSubview:self.highLabel];
//    [self.highLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_centerX);
//        make.centerY.equalTo(self.changeLabel);
//    }];
//
//    [self addSubview:self.lowLabel];
//    [self.lowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.highLabel);
//        make.centerY.equalTo(self.volLabel);
//    }];
}

- (void)setMarketModel:(NNCoinMarketModel *)marketModel
{
    _marketModel = marketModel;
    
    self.lastLabel.text = [NSString stringWithFormat:@"¥ %@",marketModel.now_price];
//    self.changeLabel.text = [NSString stringWithFormat:@"涨跌幅 %@",marketModel.change];
//    self.volLabel.text = [NSString stringWithFormat:@"成交额 %@",marketModel.market_all_price];
//    self.highLabel.text = [NSString stringWithFormat:@"最高价 ¥ %@",marketModel.max_price];
//    self.lowLabel.text = [NSString stringWithFormat:@"最低价 ¥ %@",marketModel.min_price];
}

- (UILabel *)lastLabel
{
    if (_lastLabel == nil) {
        _lastLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeMostImportantTitles]];
    }
    return _lastLabel;
}

- (UILabel *)changeLabel
{
    if (_changeLabel == nil) {
        _changeLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextTip]];
    }
    return _changeLabel;
}

- (UILabel *)volLabel
{
    if (_volLabel == nil) {
        _volLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextTip]];
    }
    return _volLabel;
}

- (UILabel *)highLabel
{
    if (_highLabel == nil) {
        _highLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextTip]];
    }
    return _highLabel;
}

- (UILabel *)lowLabel
{
    if (_lowLabel == nil) {
        _lowLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextTip]];
    }
    return _lowLabel;
}

@end
