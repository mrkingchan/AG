//
//  NNWalletTableViewCell.m
//  YWL
//
//  Created by 来旭磊 on 2018/4/25.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNWalletTableViewCell.h"

@interface NNWalletTableViewCell ()

/** 状态 */
@property (nonatomic, strong) UILabel *statusLabel;
/** 状态 */
@property (nonatomic, strong) UILabel *modelLabel;
/** 状态 */
@property (nonatomic, strong) UILabel *powerLabel;
/** 产量 */
@property (nonatomic, strong) UILabel *outputLabel;
/** 图标 */
@property (nonatomic, strong) UIImageView *arrowimage;
@end

@implementation NNWalletTableViewCell

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
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.modelLabel];
    [self.contentView addSubview:self.powerLabel];
    [self.contentView addSubview:self.outputLabel];
    [self.contentView addSubview:self.arrowimage];
    
    [self.modelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(NNHMargin_15);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-7.5);
    }];
    
    [self.powerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.modelLabel);
        make.top.equalTo(self.contentView.mas_centerY).offset(7.5);
    }];
    
    [self.outputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).offset(-20);
        make.centerY.equalTo(self.powerLabel);
    }];
    
    [self.arrowimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.arrowimage);
        make.right.equalTo(self.arrowimage.mas_left).offset(-NNHMargin_5);
    }];
}

- (void)setMineModel:(NNHomeListModel *)mineModel
{
    _mineModel = mineModel;
//    self.modelLabel.text = mineModel.ltc_name;
//    
//    self.powerLabel.text = [NSString stringWithFormat:@"运行算力：%@",mineModel.power];
//    self.outputLabel.text = [NSString stringWithFormat:@"产量：%@",mineModel.day_out];
//    
//    [self.powerLabel nnh_addAttringTextWithText:mineModel.power font:[UIConfigManager fontThemeTextTip] color:[UIConfigManager colorThemeRed]];
//    
//    [self.outputLabel nnh_addAttringTextWithText:mineModel.day_out font:[UIConfigManager fontThemeTextTip] color:[UIConfigManager colorThemeRed]];
//    
//    if (![mineModel.status isEqualToString:@"1"]) {
//        self.statusLabel.text = @"进行中";
//    }else {
//        self.statusLabel.text = @"停止";
//    }
}

#pragma mark - Lazy Loads

- (UILabel *)statusLabel
{
    if (_statusLabel == nil) {
        _statusLabel = [UILabel NNHWithTitle:@"停止" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
    }
    return _statusLabel;
}

- (UILabel *)modelLabel
{
    if (_modelLabel == nil) {
        _modelLabel = [UILabel NNHWithTitle:@"Dell 500" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextMain]];
    }
    return _modelLabel;
}

- (UILabel *)powerLabel
{
    if (_powerLabel == nil) {
        _powerLabel = [UILabel NNHWithTitle:@"0.067" titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextTip]];
    }
    return _powerLabel;
}

- (UILabel *)outputLabel
{
    if (_outputLabel == nil) {
        _outputLabel = [UILabel NNHWithTitle:@"0.40" titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextTip]];
    }
    return _outputLabel;
}
- (UIImageView *)arrowimage
{
    if (_arrowimage ==  nil) {
        _arrowimage = [[UIImageView alloc] init];
        _arrowimage.image = [UIImage imageNamed:@"mine_order_arrow"];
    }
    return _arrowimage;
}
@end
