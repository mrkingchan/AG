//
//  NNHMineTopView.m
//  YWL
//
//  Created by 牛牛 on 2018/3/5.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNHMineTopView.h"
#import "UIButton+NNImagePosition.h"
#import "NNMineModel.h"

@interface NNHMineTopView ()

/** 背景 */
@property (nonatomic, weak) UIImageView *iconView;
/** 头像 */
@property (nonatomic, strong) UIImageView *headerImageView;
/** 昵称 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 等级 */
@property (nonatomic, strong) UIButton *levelButton;
/** 余额详细view */
@property (nonatomic, strong) UIView *balanceDetailView;
/** 资产详细标题 */
@property (nonatomic, strong) NSArray *assetsTitles;

@end

@implementation NNHMineTopView
{
    CGFloat _balanceDetailViewH;
    UIButton *_lastAssetsButton;  // 记录九宫格最后一个button
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        
        [self setupcChildView];
    }
    return self;
}

- (void)setupcChildView
{
    CGFloat iconViewH = 180 + (NNHSTATUSBARDifference);
    UIImageView *iconView = [[UIImageView alloc] initWithImage:ImageName(@"center_bg")];
    [self addSubview:iconView];
    _iconView = iconView;
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(iconViewH));
    }];
    
    UILabel *titleLabel = [UILabel NNHWithTitle:@"我的" titleColor:[UIColor whiteColor] font:[UIConfigManager fontNaviTitle]];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(STATUSBAR_HEIGHT);
        make.centerX.equalTo(self);
        make.height.equalTo(@44);
    }];
    
    UIButton *settingButton = [UIButton NNHBtnTitle:@"设置" titileFont:[UIConfigManager fontThemeTextMain] backGround:[UIColor clearColor] titleColor:[UIColor whiteColor]];
    [settingButton addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:settingButton];
    [settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel);
        make.right.equalTo(self).offset(-5);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    UIButton *noticeButton = [UIButton NNHBtnTitle:@"公告" titileFont:[UIConfigManager fontThemeTextMain] backGround:[UIColor clearColor] titleColor:[UIColor whiteColor]];
    [noticeButton addTarget:self action:@selector(noticeAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:noticeButton];
    [noticeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(settingButton);
        make.left.equalTo(self).offset(5);
        make.size.equalTo(settingButton);
    }];
    
    [self addSubview:self.headerImageView];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(iconView).offset(-30);
        make.left.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headerImageView.mas_centerY).offset(-5);
        make.left.equalTo(self.headerImageView.mas_right).offset(15);
    }];
    
    [self addSubview:self.levelButton];
    [self.levelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageView.mas_centerY).offset(5);
        make.left.equalTo(self.nameLabel);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    
    [self addSubview:self.balanceDetailView];
    [self.balanceDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconView.mas_bottom);
        make.left.right.equalTo(self);
        make.bottom.equalTo(_lastAssetsButton);
    }];
}

- (void)setMineModel:(NNMineModel *)mineModel
{
    _mineModel = mineModel;
    
    self.nameLabel.text = mineModel.userModel.username;
    [self.levelButton setTitle:mineModel.levelname forState:UIControlStateNormal];

    NSInteger count = self.balanceDetailView.subviews.count;
    for (NSInteger i = 0; i < count ; i++) {
        UIButton *btn = self.balanceDetailView.subviews[i];
        UILabel *titleLabel = btn.subviews[0];
        if (i == 0) {
            titleLabel.text = mineModel.amountInfoModel.wfccamount;
        }else if (i == 1) {
            titleLabel.text = mineModel.amountInfoModel.coinamount;
        }else if (i == 2) {
            titleLabel.text = mineModel.amountInfoModel.giveamount;
        }else if (i == 3) {
            titleLabel.text = mineModel.amountInfoModel.increamount;
        }else if (i == 4) {
            titleLabel.text = mineModel.amountInfoModel.mallamount;
        }else {
            titleLabel.text = mineModel.amountInfoModel.lockwareamount;
        }
    }
}

- (void)settingAction
{
    if (self.mineTopViewJumpBlock) {
        self.mineTopViewJumpBlock(NNHMineTopJumpSetting);
    }
}

- (void)noticeAction
{
    if (self.mineTopViewJumpBlock) {
        self.mineTopViewJumpBlock(NNHMineTopJumpNotice);
    }
}

- (void)assetsDetailJumpAction:(UIButton *)button
{
    if (self.mineAssetsDetailJumpBlock) {
        
        NNHMineAssetsType walletType;
        switch (button.tag) {
            case 1:
                walletType = NNHMineAssetsType_wfcc;
                break;
            case 2:
                walletType = NNHMineAssetsType_lt;
                break;
            case 3:
                walletType = NNHMineAssetsType_zs;
                break;
            case 4:
                walletType = NNHMineAssetsType_zz;
                break;
            case 5:
                walletType = NNHMineAssetsType_xf;
                break;
            default:
                walletType = NNHMineAssetsType_sc;
                break;
        }

        self.mineAssetsDetailJumpBlock(walletType, self.assetsTitles[button.tag - 1][@"title"]);
    }
}

- (UIImageView *)headerImageView
{
    if (_headerImageView == nil) {
        _headerImageView = [[UIImageView alloc] initWithImage:ImageName(@"ic_center_logo")];
        NNHViewRadius(_headerImageView, 60*0.5);
    }
    return _headerImageView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeWhite] font:[UIFont boldSystemFontOfSize:16]];
    }
    return _nameLabel;
}

- (UIButton *)levelButton
{
    if (_levelButton == nil) {
        _levelButton = [UIButton NNHBtnTitle:@"普通会员" titileFont:[UIConfigManager fontThemeTextTip] backGround:[UIColor akext_colorWithHex:@"#ffe9cb"] titleColor:[UIColor akext_colorWithHex:@"#c07412"]];
        NNHViewRadius(_levelButton, 2.0);
    }
    return _levelButton;
}

- (UIView *)balanceDetailView
{
    if (_balanceDetailView == nil) {
        _balanceDetailView = [[UIView alloc] init];
        _balanceDetailView.backgroundColor = [UIConfigManager colorThemeSeperatorLightGray];
        
        // 创建资产明细
        NSInteger col = 3;
        CGFloat margin = 0.5;
        CGFloat btnW = (SCREEN_WIDTH - (col - 1) *margin) / col;
        CGFloat btnH = btnW *0.6;
        
        // 创建按钮
        for (NSInteger i = 0; i < self.assetsTitles.count; i++) {
            UIButton *btn = [self buttonWithTitle:self.assetsTitles[i][@"amount"] detailTitle:self.assetsTitles[i][@"title"] detailTitleColor:[UIConfigManager colorThemeDark]];
            btn.tag = i + 1;
            [_balanceDetailView addSubview:btn];
            
            // 约束
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_balanceDetailView).offset((i / col) *btnH + (i / col) *margin);
                if (!_lastAssetsButton || (i % col) == 0) {
                    make.left.equalTo(_balanceDetailView);
                }else{
                    make.left.equalTo(_lastAssetsButton.mas_right).offset(margin);
                }
                make.width.mas_equalTo(btnW);
                make.height.mas_equalTo(btnH);
            }];
            _lastAssetsButton = btn;
        }
    }
    return _balanceDetailView;
}

- (NSArray *)assetsTitles
{
    if (_assetsTitles == nil) {
        _assetsTitles = @[
                           @{@"title" : @"报单积分", @"amount" : @"0.00"},
                           @{@"title" : @"通用积分", @"amount" : @"0.00"},
                           @{@"title" : @"赠送积分", @"amount" : @"0.00"},
                           @{@"title" : @"增值积分", @"amount" : @"0.00"},
                           @{@"title" : @"消费积分", @"amount" : @"0.00"},
                           @{@"title" : @"锁仓钱包", @"amount" : @"0.00"}                           
                         ];
    }
    return _assetsTitles;
}

- (UIButton *)buttonWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle detailTitleColor:(UIColor *)detailTitleColor
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(assetsDetailJumpAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [UILabel NNHWithTitle:title titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeLargerBtnTitles]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(btn.mas_centerY).offset(-2);
        make.width.equalTo(btn).multipliedBy(0.9);
        make.centerX.equalTo(btn);
    }];
    
    UILabel *detailTitleLabel = [UILabel NNHWithTitle:detailTitle titleColor:detailTitleColor font:[UIConfigManager fontThemeTextTip]];
    [btn addSubview:detailTitleLabel];
    [detailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_centerY).offset(5);
        make.centerX.equalTo(btn);
    }];
    
    return btn;
}

@end
