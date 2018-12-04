//
//  NNHomeListTableViewCell.m
//  YWL
//
//  Created by 来旭磊 on 2018/4/25.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNHomeListCell.h"

@interface NNHomeListCell ()

/** 图片 */
@property (nonatomic, strong) UIImageView *productImageView;
/** 名称 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 算力 */
@property (nonatomic, strong) UILabel *powerLabel;
/** 收益 */
@property (nonatomic, strong) UILabel *incomeLabel;
/** 状态 */
@property (nonatomic, strong) UIButton *statusButton;

@end

@implementation NNHomeListCell

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
    [self.contentView addSubview:self.productImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.powerLabel];
    [self.contentView addSubview:self.incomeLabel];
    [self.contentView addSubview:self.statusButton];
    
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(NNHMargin_10);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(85, 85));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.productImageView);
        make.left.equalTo(self.productImageView.mas_right).offset(NNHMargin_15);
    }];
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.bottom.equalTo(self.productImageView);
    }];
    [self.powerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.incomeLabel.mas_top).offset(-10);
        make.left.equalTo(self.nameLabel);
    }];
    [self.statusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
}

- (void)setHomeListModel:(NNHomeListModel *)homeListModel
{
    _homeListModel = homeListModel;

    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:homeListModel.thumb]];
    
    NSString *title = [NSString stringWithFormat:@"%@%@",homeListModel.limittitle,homeListModel.title];
    self.nameLabel.attributedText = [NSMutableAttributedString nn_changeCorlorWithColor:[UIConfigManager colorThemeRed] TotalString:title SubStringArray:@[homeListModel.limittitle]];
    
    self.powerLabel.text = homeListModel.stockstr;
    self.incomeLabel.text = homeListModel.totalstr;
    [self.statusButton setTitle:homeListModel.computtag forState:UIControlStateNormal];
    
    if ([homeListModel.stock integerValue] == 0) {
        self.powerLabel.textColor = [UIColor akext_colorWithHex:@"ff1844"];
    }else{
        self.powerLabel.textColor = [UIConfigManager colorThemeDarkGray];
    }
    
    if ([homeListModel.iscomput integerValue] == 1) {
        [self.statusButton setBackgroundColor:[UIConfigManager colorThemeRed] forState:UIControlStateNormal];
    }else if ([homeListModel.iscomput integerValue] == 2) {
        [self.statusButton setBackgroundColor:[UIColor akext_colorWithHex:@"eeae00"] forState:UIControlStateNormal];
    }else{
        [self.statusButton setBackgroundColor:[UIColor akext_colorWithHex:@"e5e5e5"] forState:UIControlStateNormal];
    }
}

- (void)buyAction
{
    if ([self.homeListModel.iscomput integerValue] == 0) return;
    if (self.buyActionBlock) {
        self.buyActionBlock();
    }
}

#pragma mark - Lazy Loads

- (UIImageView *)productImageView
{
    if (_productImageView == nil) {
        _productImageView = [[UIImageView alloc] init];
        _productImageView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    }
    return _productImageView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextMain]];
    }
    return _nameLabel;
}

- (UILabel *)powerLabel
{
    if (_powerLabel == nil) {
        _powerLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextTip]];
    }
    return _powerLabel;
}

- (UILabel *)incomeLabel
{
    if (_incomeLabel == nil) {
        _incomeLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextTip]];
    }
    return _incomeLabel;
}

- (UIButton *)statusButton
{
    if (_statusButton == nil) {
        _statusButton = [UIButton NNHBtnTitle:@"立即购买" titileFont:[UIConfigManager fontThemeTextTip] backGround:[UIConfigManager colorThemeRed] titleColor:[UIConfigManager colorThemeWhite]];
        [_statusButton addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
        NNHViewRadius(_statusButton, 25 *0.5);
    }
    return _statusButton;
}

@end
