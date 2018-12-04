//
//  NNCoinAssetsDetailTopView.m
//  YWL
//
//  Created by 牛牛 on 2018/5/15.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNCoinAssetsDetailTopView.h"
#import "NNCoinAssetsDetailModel.h"

@interface NNCoinAssetsDetailTopView ()

/** 类型 */
@property (nonatomic, assign) NNHMineAssetsType currentAssetsType;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 总额 */
@property (nonatomic, strong) UILabel *totalLabel;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLbl;
/** 提资产 */
@property (nonatomic, strong) UIButton *extractButton;
/** 转出易物通 */
@property (nonatomic, strong) UIButton *outButton;

@end

@implementation NNCoinAssetsDetailTopView

- (instancetype)initWithTopAssetsType:(NNHMineAssetsType)type title:(NSString *)title
{
    if (self = [super init]) {
        self.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        _currentAssetsType = type;
        _title = title;
        
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    // 创建背景图
    UIImageView *bgView = [[UIImageView alloc] initWithImage:ImageName(@"wallet_bg")];
    bgView.userInteractionEnabled = YES;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    // 返回按钮
    UIButton *backBtn = [UIButton NNHBtnImage:@"ic_back_white" target:self action:@selector(backAction)];
    [bgView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(5);
        make.top.equalTo(bgView).offset(STATUSBAR_HEIGHT);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    // 中间标题
    [bgView addSubview:self.titleLbl];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.centerY.equalTo(backBtn);
    }];
    
    // 总额
    [bgView addSubview:self.totalLabel];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.equalTo(backBtn.mas_bottom).offset(50);
    }];
    
    // 提示
    UILabel *promptLabel = [UILabel NNHWithTitle:@"总额" titleColor:[UIColor whiteColor] font:[UIConfigManager fontThemeTextTip]];
    [bgView addSubview:promptLabel];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.equalTo(self.totalLabel.mas_bottom).offset(15);
    }];
    
    if (_currentAssetsType == NNHMineAssetsType_lt) {
        
        [self addSubview:self.outButton];
        [self.outButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(promptLabel.mas_bottom).offset(20);
            make.right.equalTo(self.mas_centerX).offset(-8);
            make.size.mas_equalTo(CGSizeMake(90, 25));
        }];

        [self addSubview:self.extractButton];
        [self.extractButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.outButton);
            make.left.equalTo(self.mas_centerX).offset(8);
            make.size.mas_equalTo(CGSizeMake(70, 25));
        }];
    }
    
    if (_currentAssetsType == NNHMineAssetsType_zz) {
        
        [self.outButton setTitle:@"兑换AAG" forState:UIControlStateNormal];
        [self addSubview:self.outButton];
        [self.outButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(promptLabel.mas_bottom).offset(20);
            make.right.equalTo(self.mas_centerX).offset(-8);
            make.size.mas_equalTo(CGSizeMake(90, 25));
        }];
        
        [self addSubview:self.extractButton];
        [self.extractButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.outButton);
            make.left.equalTo(self.mas_centerX).offset(8);
            make.size.mas_equalTo(CGSizeMake(70, 25));
        }];
    }
    
    if (_currentAssetsType == NNHMineAssetsType_wfcc) {
        
        [self addSubview:self.extractButton];
        [self.extractButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(promptLabel.mas_bottom).offset(20);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(70, 25));
        }];
    }
    
    if (_currentAssetsType == NNHMineAssetsType_xf) {

        [self addSubview:self.outButton];
        [self.outButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(promptLabel.mas_bottom).offset(20);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(90, 25));
        }];
    }
}

-(void)setAssetsDetailModel:(NNCoinAssetsDetailModel *)assetsDetailModel
{
    _assetsDetailModel = assetsDetailModel;
    
    self.totalLabel.text = assetsDetailModel.balance;    
}

- (void)backAction
{
    if (self.backActionBlock) self.backActionBlock();
}

- (void)extractionAssetsAction
{
    if (self.extractionAssetsBlock) self.extractionAssetsBlock(self.currentAssetsType);
}

- (void)rollOutAction
{
    if (self.rollOutActionBlock) self.rollOutActionBlock(self.currentAssetsType);
}

- (UILabel *)totalLabel
{
    if (_totalLabel == nil) {
        _totalLabel = [UILabel NNHWithTitle:@"0.00" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:30]];
    }
    return _totalLabel;
}

- (UILabel *)titleLbl
{
    if (_titleLbl == nil) {
        _titleLbl = [UILabel NNHWithTitle:_title titleColor:[UIColor whiteColor] font:[UIConfigManager fontNaviTitle]];
    }
    return _titleLbl;
}

- (UIButton *)extractButton
{
    if (_extractButton == nil) {
        _extractButton = [UIButton NNHBorderBtnTitle:@"转账" borderColor:[UIColor whiteColor] titleColor:[UIColor whiteColor]];
        [_extractButton addTarget:self action:@selector(extractionAssetsAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _extractButton;
}

- (UIButton *)outButton
{
    if (_outButton == nil) {
        _outButton = [UIButton NNHBorderBtnTitle:@"转出易物通" borderColor:[UIColor whiteColor] titleColor:[UIColor whiteColor]];
        [_outButton addTarget:self action:@selector(rollOutAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _outButton;
}

@end
