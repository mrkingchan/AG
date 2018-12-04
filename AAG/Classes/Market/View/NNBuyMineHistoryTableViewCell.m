//
//  NNBuyMineHistoryTableViewCell.m
//  NBTMill
//
//  Created by 来旭磊 on 2018/5/3.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNBuyMineHistoryTableViewCell.h"


@interface NNBuyMineHistoryTableViewCell ()

/** 状态 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 状态 */
@property (nonatomic, strong) UILabel *modelLabel;
/** 状态 */
@property (nonatomic, strong) UILabel *timeLabel;
/** 产量 */
@property (nonatomic, strong) UILabel *amountLabel;

@end

@implementation NNBuyMineHistoryTableViewCell

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
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.modelLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.amountLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(NNHMargin_15);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-7.5);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.contentView.mas_centerY).offset(7.5);
    }];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.centerY.equalTo(self.nameLabel);
    }];
    
    [self.modelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.amountLabel);
        make.centerY.equalTo(self.timeLabel);
    }];

}

- (void)setRecordModel:(NNHMineBuyRecordModel *)recordModel
{
    _recordModel = recordModel;
    self.nameLabel.text = recordModel.text;
    self.timeLabel.text = recordModel.addtime;
    self.amountLabel.text = [NSString stringWithFormat:@"%@*%@",recordModel.coin,recordModel.num];
    self.modelLabel.text = recordModel.buytypetext;
}

#pragma mark - Lazy Loads

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextMain]];
    }
    return _nameLabel;
}

- (UILabel *)modelLabel
{
    if (_modelLabel == nil) {
        _modelLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
    }
    return _modelLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextTip]];
    }
    return _timeLabel;
}

- (UILabel *)amountLabel
{
    if (_amountLabel == nil) {
        _amountLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
    }
    return _amountLabel;
}

@end
