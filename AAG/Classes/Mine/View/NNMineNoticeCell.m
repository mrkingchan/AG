//
//  NNMineNoticeCell.m
//  YWL
//
//  Created by 牛牛 on 2018/4/27.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMineNoticeCell.h"
#import "NNMineNoticeModel.h"

@interface NNMineNoticeCell ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) UILabel *timeLabel;

@end

@implementation NNMineNoticeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor akext_colorWithHex:@"#eeeeee"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupChlidView];
    }
    return self;
}

- (void)setupChlidView
{
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.height.equalTo(@44);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    NNHViewRadius(contentView, 10.0);
    [self.contentView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.contentView);
    }];
    
    [contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(15);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
    }];
    
    [contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.left.right.equalTo(self.titleLabel);
    }];
    
    UIView *lineView = [UIView lineView];
    [contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).offset(15);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@(NNHLineH));
    }];
    
    UILabel *checkDetailLabel = [UILabel NNHWithTitle:@"查看详情" titleColor:[UIColor akext_colorWithHex:@"#999999"] font:[UIConfigManager fontThemeTextDefault]];
    [contentView addSubview:checkDetailLabel];
    [checkDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.equalTo(contentView).offset(15);
        make.height.equalTo(@44);
    }];
    
    UIImageView *arrowView = [[UIImageView alloc] initWithImage:ImageName(@"mine_order_arrow")];
    [contentView addSubview:arrowView];
    [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(checkDetailLabel);
        make.right.equalTo(contentView).offset(-15);
    }];
}

- (void)setMineNoticeModel:(NNMineNoticeModel *)mineNoticeModel
{
    _mineNoticeModel = mineNoticeModel;
    
    self.titleLabel.text = mineNoticeModel.title;
    self.detailLabel.text = mineNoticeModel.content;
    self.timeLabel.text = mineNoticeModel.addtime;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextImportant]];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (_detailLabel == nil) {
        _detailLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
        _detailLabel.backgroundColor = [UIColor whiteColor];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel NNHWithTitle:@"" titleColor:[UIColor akext_colorWithHex:@"#999999"] font:[UIConfigManager fontThemeTextMiddleTip]];
        _timeLabel.backgroundColor = [UIColor akext_colorWithHex:@"#eeeeee"];
    }
    return _timeLabel;
}

@end
