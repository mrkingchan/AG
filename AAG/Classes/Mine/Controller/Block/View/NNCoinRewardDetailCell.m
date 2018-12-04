//
//  NNCoinRewardDetailCell.m
//  YWL
//
//  Created by 牛牛 on 2018/5/18.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNCoinRewardDetailCell.h"
#import "NNCoinRewardDetailModel.h"

@interface NNCoinRewardDetailCell ()

/** 左边顶部label */
@property (nonatomic, strong) UILabel *leftTopLabel;
/** 左边中间label */
@property (nonatomic, strong) UILabel *leftMiddleLabel;
/** 左边底部label */
@property (nonatomic, strong) UILabel *leftBottomLabel;

/** 右边顶部label */
@property (nonatomic, strong) UILabel *rightTopLabel;
/** 右边中间label */
@property (nonatomic, strong) UILabel *rightMiddleLabel;
/** 右边底部label */
@property (nonatomic, strong) UILabel *rightBottomLabel;

@end

@implementation NNCoinRewardDetailCell

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
    [self.contentView addSubview:self.leftTopLabel];
    [self.contentView addSubview:self.leftMiddleLabel];
    [self.contentView addSubview:self.leftBottomLabel];
    [self.contentView addSubview:self.rightTopLabel];
    [self.contentView addSubview:self.rightMiddleLabel];
    [self.contentView addSubview:self.rightBottomLabel];
    
    [self.leftTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(NNHMargin_15);
    }];
    [self.leftMiddleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftTopLabel.mas_bottom).offset(NNHMargin_15);
        make.left.equalTo(self.leftTopLabel);
    }];
    [self.leftBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftMiddleLabel.mas_bottom).offset(15);
        make.left.equalTo(self.leftTopLabel);
    }];
    [self.rightTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.leftTopLabel);
    }];
    [self.rightMiddleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightTopLabel);
        make.centerY.equalTo(self.leftMiddleLabel);
    }];
    [self.rightBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightTopLabel);
        make.centerY.equalTo(self.leftBottomLabel);
    }];
}

- (void)setRewardDetailListModel:(NNCoinRewardDetailModel *)rewardDetailListModel
{
    _rewardDetailListModel = rewardDetailListModel;
    
//    if (rewardDetailListModel.assetsType == NNHMineAssetsType_yesterdayChargeAccount) {        
//        self.rightMiddleLabel.hidden = NO;
//        self.leftTopLabel.text = rewardDetailListModel.text;
//        self.leftMiddleLabel.text = rewardDetailListModel.addtime;
//        self.rightMiddleLabel.text = rewardDetailListModel.amount;
//    }else if (rewardDetailListModel.assetsType == NNHMineAssetsType_chargeAccountPool || rewardDetailListModel.assetsType ==  NNHMineAssetsType_teamPerformanceAward){
//        self.leftBottomLabel.hidden = NO;
//        self.rightMiddleLabel.hidden = NO;
//        self.leftTopLabel.text = rewardDetailListModel.text;
//        self.leftMiddleLabel.text = rewardDetailListModel.moble;
//        self.leftBottomLabel.text = rewardDetailListModel.text;
//        self.rightTopLabel.text = rewardDetailListModel.addtime;
//        self.rightMiddleLabel.text = rewardDetailListModel.amount;
//    }else if (rewardDetailListModel.assetsType == NNHMineAssetsType_teamPerformance){
//        self.leftBottomLabel.hidden = NO;
//        self.rightMiddleLabel.hidden = NO;
//        self.rightBottomLabel.hidden = NO;
//        self.leftTopLabel.text = rewardDetailListModel.text;
//        self.leftMiddleLabel.text = rewardDetailListModel.moble;
//        self.leftBottomLabel.text = rewardDetailListModel.gradetext;
//        self.rightTopLabel.text = rewardDetailListModel.addtime;
//        self.rightMiddleLabel.text = rewardDetailListModel.num;
//        self.rightBottomLabel.text = rewardDetailListModel.amount;
//        self.rightMiddleLabel.textColor = [UIConfigManager colorThemeRed];
//        self.rightBottomLabel.textColor = [UIConfigManager colorThemeRed];
//    }else {
//        self.rightMiddleLabel.hidden = NO;
//        self.leftTopLabel.text = rewardDetailListModel.text;
//        self.leftMiddleLabel.text = rewardDetailListModel.moble;
//        self.rightTopLabel.text = rewardDetailListModel.addtime;
//        self.rightMiddleLabel.text = rewardDetailListModel.amount;
//    }
}

#pragma mark - Lazy Loads
- (UILabel *)leftTopLabel
{
    if (_leftTopLabel == nil) {
        _leftTopLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextMain]];
        _leftTopLabel.backgroundColor = [UIColor whiteColor];
    }
    return _leftTopLabel;
}

- (UILabel *)leftMiddleLabel
{
    if (_leftMiddleLabel == nil) {
        _leftMiddleLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextMain]];
        _leftMiddleLabel.backgroundColor = [UIColor whiteColor];
    }
    return _leftMiddleLabel;
}

- (UILabel *)leftBottomLabel
{
    if (_leftBottomLabel == nil) {
        _leftBottomLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextTip]];
        _leftBottomLabel.backgroundColor = [UIColor whiteColor];
        _leftBottomLabel.hidden = YES;
    }
    return _leftBottomLabel;
}

- (UILabel *)rightTopLabel
{
    if (_rightTopLabel == nil) {
        _rightTopLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextTip]];
        _rightTopLabel.backgroundColor = [UIColor whiteColor];
    }
    return _rightTopLabel;
}

- (UILabel *)rightMiddleLabel
{
    if (_rightMiddleLabel == nil) {
        _rightMiddleLabel = [UILabel NNHWithTitle:@"" titleColor:[UIColor akext_colorWithHex:@"#ff1844"] font:[UIConfigManager fontThemeTextImportant]];
        _rightMiddleLabel.backgroundColor = [UIColor whiteColor];
        _rightMiddleLabel.hidden = YES;
    }
    return _rightMiddleLabel;
}

- (UILabel *)rightBottomLabel
{
    if (_rightBottomLabel == nil) {
        _rightBottomLabel = [UILabel NNHWithTitle:@"" titleColor:[UIColor akext_colorWithHex:@"#ff1844"] font:[UIConfigManager fontThemeTextImportant]];
        _rightBottomLabel.backgroundColor = [UIColor whiteColor];
        _rightBottomLabel.hidden = YES;
    }
    return _rightBottomLabel;
}

@end
