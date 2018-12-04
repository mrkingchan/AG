//
//  NNBlockFundTransferReocrdCell.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/14.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNBlockFundTransferReocrdCell.h"

@interface NNBlockFundTransferReocrdCell ()

/** 手机号 */
@property (nonatomic, strong) UILabel *mobileLabel;
/** 时间 */
@property (nonatomic, strong) UILabel *timeLabel;
/** 数量 */
@property (nonatomic, strong) UILabel *amountLabel;

@end

@implementation NNBlockFundTransferReocrdCell

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
    [self.contentView addSubview:self.mobileLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.amountLabel];
    
    [self.mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(NNHMargin_15);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-2);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mobileLabel);
        make.top.equalTo(self.contentView.mas_centerY).offset(NNHMargin_5);
    }];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setRecordModel:(NNBlockFundTransferReocrdModel *)recordModel
{
    _recordModel = recordModel;
    
    if (self.consumeFundFlag) {
        //消费资产转账记录
        self.timeLabel.text = recordModel.addtime;
        self.mobileLabel.text = recordModel.text;
        self.amountLabel.text = [NSString stringWithFormat:@"%@",recordModel.amount];
        
        self.amountLabel.textColor = [UIColor akext_colorWithHex:@"#ff1844"];
    }else {
        
        //记账资产转账记录
        self.mobileLabel.text = recordModel.mobile;
        self.timeLabel.text = recordModel.addtime;
        
        self.amountLabel.text = recordModel.numberstr;
        
        if ([recordModel.type isEqualToString:@"2"]) {
            self.amountLabel.textColor = [UIColor akext_colorWithHex:@"#009759"];
        }else{
            self.amountLabel.textColor = [UIColor akext_colorWithHex:@"#ff1844"];
        }
    }
}

#pragma mark - Lazy Loads

- (UILabel *)mobileLabel
{
    if (_mobileLabel == nil) {
        _mobileLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextMain]];
    }
    return _mobileLabel;
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
        _amountLabel = [UILabel NNHWithTitle:@"" titleColor:[UIColor akext_colorWithHex:@"#009759"] font:[UIConfigManager fontThemeTextImportant]];
    }
    return _amountLabel;
}

@end
