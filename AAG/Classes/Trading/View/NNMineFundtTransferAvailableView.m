//
//  NNMineFundtTransferAvailableView.m
//  YWL
//
//  Created by 来旭磊 on 2018/4/28.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMineFundtTransferAvailableView.h"

@interface NNMineFundtTransferAvailableView ()

/** 可提数量 */
@property (nonatomic, strong) UILabel *totalCountLabel;
/** 币的名称 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation NNMineFundtTransferAvailableView

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
    UILabel *titleLabel = [UILabel NNHWithTitle:@"可用" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(NNHMargin_15);
        make.top.equalTo(self);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self addSubview:self.totalCountLabel];
    [self.totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.top.equalTo(titleLabel.mas_bottom);
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalCountLabel.mas_right).offset(NNHMargin_5);
        make.baseline.equalTo(self.totalCountLabel);
    }];
    
}

- (void)configCoinName:(NSString *)coinName count:(NSString *)count
{
    self.totalCountLabel.text = count;
    self.nameLabel.text = coinName;
    if (count.length == 0) {
        self.totalCountLabel.text = @"0.0";
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

#pragma mark - Lazy Loads

- (UILabel *)totalCountLabel
{
    if (_totalCountLabel == nil) {
        _totalCountLabel = [UILabel NNHWithTitle:@"0.00" titleColor:[UIConfigManager colorThemeRed] font:[UIFont systemFontOfSize:30]];
    }
    return _totalCountLabel;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _nameLabel;
}



@end
