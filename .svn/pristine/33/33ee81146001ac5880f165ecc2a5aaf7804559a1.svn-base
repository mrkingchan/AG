//
//  NNTransferRecordListTableViewCell.m
//  YWL
//
//  Created by 来旭磊 on 2018/4/28.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNTransferRecordListTableViewCell.h"

@interface NNTransferRecordListTableViewCell ()

/** 手机号 */
@property (nonatomic, strong) UILabel *mobileLabel;
/** 时间 */
@property (nonatomic, strong) UILabel *timeLabel;
/** 数量 */
@property (nonatomic, strong) UILabel *amountLabel;

@end

@implementation NNTransferRecordListTableViewCell

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

- (void)setRecordModel:(NNTransferRecordModel *)recordModel
{
    _recordModel = recordModel;
    
    NSMutableString *string = [NSMutableString stringWithString:recordModel.desc];
    
    if (string.length == 11) {
        [string replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    
    self.mobileLabel.text = string;
    self.timeLabel.text = recordModel.add_time;
    
    self.amountLabel.text = [NSString stringWithFormat:@"%@",recordModel.price];
    if ([recordModel.type isEqualToString:@"0"]) {
        //转出
        self.amountLabel.textColor = [UIColor akext_colorWithHex:@"#009759"];
    }else {
        //转入
        self.amountLabel.textColor = [UIColor akext_colorWithHex:@"#ff1844"];
    }
}

#pragma mark - Lazy Loads

- (UILabel *)mobileLabel
{
    if (_mobileLabel == nil) {
        _mobileLabel = [UILabel NNHWithTitle:@"13812345678" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextMain]];
    }
    return _mobileLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel NNHWithTitle:@"2018-04-28" titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextTip]];
    }
    return _timeLabel;
}

- (UILabel *)amountLabel
{
    if (_amountLabel == nil) {
        _amountLabel = [UILabel NNHWithTitle:@"+1200" titleColor:[UIColor akext_colorWithHex:@"#009759"] font:[UIConfigManager fontThemeTextImportant]];
    }
    return _amountLabel;
}

@end
