//
//  NNCoinFundWalletAddressListTableViewCell.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/12.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNCoinFundWalletAddressListCell.h"

@interface NNCoinFundWalletAddressListCell ()

/** 地址 */
@property (nonatomic, copy) UILabel *addressLabel;

/** 备注 */
@property (nonatomic, copy) UILabel *nameLabel;

@end


@implementation NNCoinFundWalletAddressListCell

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
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.nameLabel];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(NNHMargin_15);
        make.width.equalTo(@(SCREEN_WIDTH - 80));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.width.equalTo(@(50));
    }];
}

- (void)setAddressModel:(NNWalletAddressModel *)addressModel
{
    _addressModel = addressModel;
    self.addressLabel.text = addressModel.addr;
    self.nameLabel.text = addressModel.name;
}

- (UILabel *)addressLabel
{
    if (_addressLabel == nil) {
        _addressLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _addressLabel;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
        _nameLabel.textAlignment = NSTextAlignmentRight;
    }
    return _nameLabel;
}

@end
