//
//  NNMineFundTransferViewController.m
//  YWL
//
//  Created by 来旭磊 on 2018/4/28.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMineFundTransferViewController.h"
#import "NNMineFundtTransferAvailableView.h"
#import "NNHAPITradingTool.h"
#import "NNHEnterPasswordView.h"
#import "NNHScanCodeController.h"
#import "NNAPIBlockFundTool.h"
#import "NNVerifyPhoneViewController.h"
#import "NNSetUpPayPasswordViewController.h"

@interface NNMineFundTransferViewController ()

/** 可用余额view */
@property (nonatomic, strong) NNMineFundtTransferAvailableView *availableView;
/** 账户view */
@property (nonatomic, strong) UIView *accountView;
/** 填写账户 */
@property (nonatomic, strong) UITextField *accountField;
/** 提币数量 */
@property (nonatomic, strong) UIView *countView;
/** 填写提币数量 */
@property (nonatomic, strong) UITextField *countField;
/** 确认按钮 */
@property (nonatomic, strong) UIButton *ensureButton;
/** 输入密码 */
@property (nonatomic, strong) NNHEnterPasswordView *enterView;
/** 手续费view */
@property (nonatomic, strong) UIView *feeView;
/** 手续费label */
@property (nonatomic, strong) UILabel *feeLabel;
/** 手续费说明 */
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation NNMineFundTransferViewController

#pragma mark - Life Cycle Methods
- (void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    [self setupChildView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestBalanceData];
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    [self.view addSubview:self.availableView];
    [self.availableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(NNHMargin_10);
        make.height.equalTo(@(NNHNormalViewH * 2));
    }];
    
    [self.view addSubview:self.accountView];
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.availableView.mas_bottom).offset(NNHLineH);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self.view addSubview:self.countView];
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.accountView.mas_bottom).offset(NNHLineH);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self.view addSubview:self.feeView];
    [self.feeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.countView.mas_bottom).offset(NNHLineH);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self.view addSubview:self.ensureButton];
    [self.ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.right.equalTo(self.view).offset(-NNHMargin_15);
        make.top.equalTo(self.feeView.mas_bottom).offset(60);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self.view addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ensureButton);
        make.top.equalTo(self.feeView.mas_bottom).offset(NNHMargin_10);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField
{
    self.ensureButton.enabled = self.accountField.hasText && self.countField.hasText;
}

- (void)loadNetworkData
{
    [self requestBalanceData];
    self.countField.text = @"";
    self.accountField.text = @"";
}

#pragma mark - Network Methods
/** 请求可用余额数据 */
- (void)requestBalanceData
{
    NNHWeakSelf(self)
    NNAPIBlockFundTool *fundTool = [[NNAPIBlockFundTool alloc] initFundDetailInfoWithFundType:NNFundBanlanceType_huzhuanFund];
    [fundTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [weakself.availableView configCoinName:responseDic[@"data"][@"abb"] count:responseDic[@"data"][@"amount"]];
        weakself.feeLabel.text = responseDic[@"data"][@"zcfee_str"];
        weakself.contentLabel.text = responseDic[@"data"][@"content"];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

#pragma mark - Target Methods

- (void)codeButtonAction
{
    NNHScanCodeController *scanVc = [[NNHScanCodeController alloc] init];
    [self.navigationController pushViewController:scanVc animated:YES];
    NNHWeakSelf(self)
    scanVc.getQrCodeBlock = ^(NSString *code) {
        weakself.accountField.text = code;
    };
}

- (void)clickEnsureButton:(UIButton *)button
{
    if (![NNHApplicationHelper sharedInstance].isRealName) return;
    
    [self.enterView showInFatherView:self.view];
}

/** 输入交易密码 */
- (void)inputPayCode:(NSString *)paycode
{
    NNHWeakSelf(self)
    NNHAPITradingTool *tradeTool = [[NNHAPITradingTool alloc] initMineFundTransferWithNum:self.countField.text tousername:self.accountField.text paypwd:paycode];
    [tradeTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [weakself.enterView dissmissWithCompletion:nil];
        [SVProgressHUD showMessage:@"转出成功"];
        [weakself loadNetworkData];
    } failBlock:^(NNHRequestError *error) {
        [weakself.enterView resetStatus];
    } isCached:NO];
}

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Lazy Loads

- (NNMineFundtTransferAvailableView *)availableView
{
    if (_availableView == nil) {
        _availableView = [[NNMineFundtTransferAvailableView alloc] init];
    }
    return _availableView;
}

- (UIView *)accountView
{
    if (_accountView == nil) {
        _accountView = [[UIView alloc] init];
        _accountView.backgroundColor = [UIConfigManager colorThemeWhite];
        UILabel *titleLabel = [UILabel NNHWithTitle:@"转入账户" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
        [_accountView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_accountView).offset(NNHMargin_15);
            make.centerY.equalTo(_accountView);
            make.width.equalTo(@(60));
        }];
        
        UIButton *codeButton = [UIButton NNHBtnImage:@"ic_scan" target:self action:@selector(codeButtonAction)];
        [_accountView addSubview:codeButton];
        [codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_accountView);
            make.width.equalTo(@(NNHNormalViewH));
            make.right.equalTo(_accountView).offset(-NNHMargin_5);
        }];

        [_accountView addSubview:self.accountField];
        [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right);
            make.centerY.equalTo(_accountView);
            make.width.equalTo(@(SCREEN_WIDTH - 130));
            make.height.equalTo(_accountView.mas_height);
        }];
    }
    return _accountView;
}

- (UITextField *)accountField
{
    if (_accountField == nil) {
        _accountField = [[UITextField alloc] init];
        _accountField.font = [UIConfigManager fontThemeTextDefault];
        _accountField.placeholder = @"请输入手机号";
        [_accountField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _accountField;
}

- (UIView *)countView
{
    if (_countView == nil) {
        _countView = [[UIView alloc] init];
        _countView.backgroundColor = [UIConfigManager colorThemeWhite];
        
        UILabel *titleLabel = [UILabel NNHWithTitle:@"转出数量" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
        [_countView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_countView).offset(NNHMargin_15);
            make.centerY.equalTo(_countView);
            make.width.equalTo(@(60));
        }];
        
        [_countView addSubview:self.countField];
        [self.countField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right);
            make.centerY.equalTo(_countView);
            make.width.equalTo(@(SCREEN_WIDTH - 120));
            make.height.equalTo(_countView.mas_height);
        }];
    }
    return _countView;
}

- (UITextField *)countField
{
    if (_countField == nil) {
        _countField = [[UITextField alloc] init];
        _countField.font = [UIConfigManager fontThemeTextDefault];
        _countField.placeholder = @"请输入转出数量";
        _countField.keyboardType = UIKeyboardTypeDecimalPad;
        [_countField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _countField;
}

- (UIButton *)ensureButton
{
    if (_ensureButton == nil) {
        _ensureButton = [UIButton NNHOperationBtnWithTitle:@"转出" target:self action:@selector(clickEnsureButton:) operationButtonType:NNHOperationButtonTypeBlue isAddCornerRadius:YES];
        _ensureButton.enabled = NO;
        _ensureButton.nn_acceptEventInterval = 1;
    }
    return _ensureButton;
}

- (NNHEnterPasswordView *)enterView
{
    if (_enterView == nil) {
        _enterView = [[NNHEnterPasswordView alloc] init];
        NNHWeakSelf(self)
        _enterView.didEnterCodeBlock = ^(NSString *password){
            NNHStrongSelf(self)
            [strongself inputPayCode:password];
        };
    }
    return _enterView;
}

- (UIView *)feeView
{
    if (_feeView == nil) {
        _feeView = [[UIView alloc] init];
        _feeView.backgroundColor = [UIConfigManager colorThemeWhite];
        
        UILabel *titleLabel = [UILabel NNHWithTitle:@"手续费" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
        [_feeView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_feeView).offset(NNHMargin_15);
            make.centerY.equalTo(_feeView);
            make.width.equalTo(@(60));
        }];
        
        [_feeView addSubview:self.feeLabel];
        [self.feeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right);
            make.centerY.equalTo(_feeView);
        }];
        
    }
    return _feeView;
}

- (UILabel *)feeLabel
{
    if (_feeLabel == nil) {
        _feeLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _feeLabel;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [UILabel NNHWithTitle:@"" titleColor:[UIColor redColor] font:[UIConfigManager fontThemeTextTip]];
        _contentLabel.numberOfLines = 2;
    }
    return _contentLabel;
}




@end
