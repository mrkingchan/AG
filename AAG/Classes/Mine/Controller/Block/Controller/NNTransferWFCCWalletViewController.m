//
//  NNTransferWFCCWalletViewController.m
//  YWL
//
//  Created by 牛牛 on 2018/8/14.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNTransferWFCCWalletViewController.h"
#import "NNMineFundtTransferAvailableView.h"
#import "NNAPIBlockFundTransferTool.h"
#import "NNHEnterPasswordView.h"
#import "NNBlockFundTransferReocrdViewController.h"
#import "NNAPIBlockFundTool.h"
#import "NNVerifyPhoneViewController.h"
#import "NNSetUpPayPasswordViewController.h"
#import "NNCountDownButton.h"
#import "NNHApiSecurityTool.h"
#import "NNHAPIPaymentTool.h"
#import "UITextField+NNHExtension.h"

@interface NNTransferWFCCWalletViewController ()

/** 可用余额view */
@property (nonatomic, strong) NNMineFundtTransferAvailableView *availableView;
/** 提币数量 */
@property (nonatomic, strong) UIView *countView;
/** 填写提币数量 */
@property (nonatomic, strong) UITextField *countField;
/** 验证码view */
@property (nonatomic, strong) UIView *codeView;
/** 验证码输入框 */
@property (nonatomic, strong) UITextField *codeTextFieldField;
/** 获取验证码按钮 */
@property (nonatomic, strong) NNCountDownButton *codeButton;
/** 确认按钮 */
@property (nonatomic, strong) UIButton *ensureButton;
/** 输入密码 */
@property (nonatomic, strong) NNHEnterPasswordView *enterView;
/** 手续费说明 */
@property (nonatomic, strong) UILabel *contentLabel;
/** 当前转账类型 */
@property (nonatomic, assign) NNHWalletTransferType currentWalletTransferType;

@end

@implementation NNTransferWFCCWalletViewController

#pragma mark - Life Cycle Methods
- (void)dealloc
{
    NNHLog(@"------%s------",__func__);
}

- (instancetype)initWithTransferType:(NNHWalletTransferType)transferType
{
    if (self = [super init]) {
        _currentWalletTransferType = transferType;
    }
    return self;
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
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self requestBalanceData];
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    self.navigationItem.title = @"转账";
    if (self.currentWalletTransferType == NNHWalletTransferTypeZZAAG) {
        self.navigationItem.title = @"AAG兑换";
    }else{
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightItemAction) title:@"明细"];
    }
    
    [self.view addSubview:self.availableView];
    [self.availableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(NNHMargin_10);
        make.height.equalTo(@(NNHNormalViewH * 2));
    }];
    
    [self.view addSubview:self.countView];
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.availableView.mas_bottom).offset(NNHLineH);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self.view addSubview:self.codeView];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.countView.mas_bottom).offset(NNHLineH);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self.view addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.top.equalTo(self.countView.mas_bottom).offset(NNHMargin_10);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
    }];
    
    [self.view addSubview:self.ensureButton];
    [self.ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentLabel);
        make.right.equalTo(self.view).offset(-NNHMargin_15);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(50);
        make.height.equalTo(@(NNHNormalViewH));
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField
{
    self.ensureButton.enabled = self.countField.hasText;
}

#pragma mark - Network Methods
/** 请求可用余额数据 */
- (void)requestBalanceData
{
    NNHWeakSelf(self)
    NNAPIBlockFundTool *fundTool = [[NNAPIBlockFundTool alloc] initWalletTransferWithType:self.currentWalletTransferType];
    [fundTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [weakself.availableView configCoinName:responseDic[@"data"][@"unit"] count:responseDic[@"data"][@"balance"]];
        weakself.contentLabel.text = responseDic[@"data"][@"transferinfo"];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

#pragma mark - Target Methods
- (void)rightItemAction
{
    NNBlockFundTransferReocrdViewController *recordVC = [[NNBlockFundTransferReocrdViewController alloc]  initTransferRecordWithTransferType:self.currentWalletTransferType];
    recordVC.navigationItem.title = @"转账明细";
    [self.navigationController pushViewController:recordVC animated:YES];
}

- (void)clickEnsureButton:(UIButton *)button
{
    if ([self.countField.text integerValue] == 0) {
        [SVProgressHUD showMessage:@"请输入转出数量"];
        return;
    }
    [self.enterView showInFatherView:self.view];
}

/** 输入交易密码 */
- (void)inputPayCode:(NSString *)paycode
{    
    NNHWeakSelf(self)
    self.codeTextFieldField.text = @"";
    [SVProgressHUD nn_showWithStatus:nil];
    NNAPIBlockFundTransferTool *blockTool = [[NNAPIBlockFundTransferTool alloc] initWalletTransferWithTransferType:self.currentWalletTransferType transferNum:self.countField.text account:@"" verificationCode:self.codeTextFieldField.text paypwd:paycode];
    [blockTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [weakself.enterView dissmissWithCompletion:nil];
        [SVProgressHUD showMessage:@"转账成功"];
        [weakself.navigationController popViewControllerAnimated:YES];
    } failBlock:^(NNHRequestError *error) {
        [weakself.enterView resetStatus];
    } isCached:NO];
}

#pragma mark - Lazy Loads
- (NNMineFundtTransferAvailableView *)availableView
{
    if (_availableView == nil) {
        _availableView = [[NNMineFundtTransferAvailableView alloc] init];
    }
    return _availableView;
}

- (UIView *)countView
{
    if (_countView == nil) {
        _countView = [[UIView alloc] init];
        _countView.backgroundColor = [UIConfigManager colorThemeWhite];
        
        UILabel *titleLabel = [UILabel NNHWithTitle:@"数量" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
        [_countView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_countView).offset(NNHMargin_15);
            make.centerY.equalTo(_countView);
        }];
        
        [_countView addSubview:self.countField];
        [self.countField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(NNHMargin_10);
            make.centerY.equalTo(_countView);
            make.width.equalTo(@(SCREEN_WIDTH - 80));
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
        _countField.placeholder = @"请输入数量";
        _countField.keyboardType = UIKeyboardTypeNumberPad;
        [_countField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _countField;
}

- (UIView *)codeView
{
    if (_codeView == nil) {
        _codeView = [[UIView alloc] init];
        _codeView.backgroundColor = [UIConfigManager colorThemeWhite];
        _codeView.hidden = YES;
        
        UILabel *titleLabel = [UILabel NNHWithTitle:@"短信验证码" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
        [_codeView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_codeView).offset(NNHMargin_15);
            make.centerY.equalTo(_codeView);
        }];
        
        [_codeView addSubview:self.codeTextFieldField];
        [self.codeTextFieldField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(NNHMargin_10);
            make.centerY.equalTo(_codeView);
            make.height.equalTo(_codeView.mas_height);
            make.width.equalTo(@(SCREEN_WIDTH - 80 - 100));
        }];
        
        [_codeView addSubview:self.codeButton];
        [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_codeView);
            make.right.equalTo(_codeView).offset(10);
            make.width.equalTo(@100);
            make.height.equalTo(@35);
        }];
    }
    return _codeView;
}

- (UITextField *)codeTextFieldField
{
    if (_codeTextFieldField == nil) {
        _codeTextFieldField = [[UITextField alloc] init];
        _codeTextFieldField.font = [UIConfigManager fontThemeTextDefault];
        _codeTextFieldField.placeholder = @"请输入短信验证码";
        _codeTextFieldField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextFieldField.nn_maxLength = 6;
        [_codeTextFieldField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _codeTextFieldField;
}

- (UIButton *)ensureButton
{
    if (_ensureButton == nil) {
        _ensureButton = [UIButton NNHOperationBtnWithTitle:@"提交" target:self action:@selector(clickEnsureButton:) operationButtonType:NNHOperationButtonTypeBlue isAddCornerRadius:YES];
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

- (NNCountDownButton *)codeButton
{
    if (_codeButton == nil) {
        
        NNHSendVerificationCodeType type;
        if (_currentWalletTransferType == NNHWalletTransferTypeLTWFCC) {
            type = NNHSendVerificationCodeType_LTWFCC;
        }else if (_currentWalletTransferType == NNHWalletTransferTypeTradingWFCC) {
            type = NNHSendVerificationCodeType_TradingWFCC;
        }else if (_currentWalletTransferType == NNHWalletTransferTypeXFWFCC) {
            type = NNHSendVerificationCodeType_XFWFCC;
        }else {
            type = NNHSendVerificationCodeType_ZZWFCC;
        }
        _codeButton = [[NNCountDownButton alloc] initWithTotalTime:60 titleBefre:@"获取验证码" titleConting:@"s" titleAfterCounting:@"获取验证码" clickAction:^(NNCountDownButton *countBtn) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NNHApiSecurityTool *tool = [[NNHApiSecurityTool alloc] initWithMobile:[NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.completemobile verifyCodeType:type countryCode:nil];
                [tool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
                    [countBtn startCounting];
                    [SVProgressHUD showMessage:@"获取验证码成功 请注意查收"];
                } failBlock:^(NNHRequestError *error) {
                    [countBtn resetButton];
                } isCached:NO];
            });
        }];
        [_codeButton setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
        [_codeButton setBackgroundColor:[UIColor clearColor] forState:UIControlStateDisabled];
        _codeButton.lbNormalColor = [UIConfigManager colorThemeRed];
    }
    return _codeButton;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextTip]];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
@end
