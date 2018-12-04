//
//  NNCoinAssetsDetailCell.m
//  YWL
//
//  Created by 牛牛 on 2018/5/15.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNCoinAssetsDetailCell.h"
#import "NNCoinAssetsDetailModel.h"

@interface NNCoinAssetsDetailCell ()

/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 时间 */
@property (nonatomic, strong) UILabel *detailLabel;
/** 用户名 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 数量 */
@property (nonatomic, strong) UILabel *amountLabel;

@end

@implementation NNCoinAssetsDetailCell

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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.amountLabel];
    [self.contentView addSubview:self.nameLabel];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-2);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(NNHMargin_15);
        make.right.lessThanOrEqualTo(self.amountLabel.mas_left).offset(-15);
        make.centerY.equalTo(self.amountLabel);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.amountLabel);
        make.top.equalTo(self.contentView.mas_centerY).offset(NNHMargin_5);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.lessThanOrEqualTo(self.detailLabel.mas_left).offset(-15);
        make.centerY.equalTo(self.detailLabel);
    }];
}

- (void)setAssetsDetailListModel:(NNCoinAssetsDetailListModel *)assetsDetailListModel
{
    _assetsDetailListModel = assetsDetailListModel;
    
    self.titleLabel.text = assetsDetailListModel.flowname;
    self.detailLabel.text = assetsDetailListModel.flowtime;
    self.amountLabel.text = assetsDetailListModel.amount;
    self.nameLabel.text = assetsDetailListModel.flowinfo;
    
    if ([assetsDetailListModel.direction integerValue] == 1) {
        self.amountLabel.textColor = [UIColor akext_colorWithHex:@"#ff1844"];        
    }else{
        self.amountLabel.textColor = [UIColor akext_colorWithHex:@"#009759"];
    }
}

#pragma mark - Lazy Loads

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextMain]];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (_detailLabel == nil) {
        _detailLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextTip]];
    }
    return _detailLabel;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextTip]];
    }
    return _nameLabel;
}

- (UILabel *)amountLabel
{
    if (_amountLabel == nil) {
        _amountLabel = [UILabel NNHWithTitle:@"" titleColor:[UIColor akext_colorWithHex:@"#009759"] font:[UIConfigManager fontThemeTextImportant]];
    }
    return _amountLabel;
}

@end
