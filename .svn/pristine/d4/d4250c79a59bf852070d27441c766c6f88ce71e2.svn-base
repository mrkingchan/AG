//
//  NNBlockFundTransferViewController.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/4.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNBlockFundTransferViewController.h"
#import "NNHScanCodeController.h"
#import "NNMineFundtTransferAvailableView.h"
#import "NNAPIBlockFundTransferTool.h"
#import "NNHEnterPasswordView.h"
#import "NNBlockFundTransferReocrdViewController.h"
#import "NNAPIBlockFundTool.h"
#import "NNVerifyPhoneViewController.h"
#import "NNSetUpPayPasswordViewController.h"
#import "NNCountDownButton.h"
#import "NNHApiSecurityTool.h"
#import "UITextField+NNHExtension.h"

#define myDotNumbers     @"0123456789.\n"
#define myNumbers          @"0123456789\n"

@interface NNBlockFundTransferViewController ()<UITextFieldDelegate>

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
@property (nonatomic, assign) NNHWalletTransferType currentTransferType;

@end

@implementation NNBlockFundTransferViewController

#pragma mark - Life Cycle Methods
- (void)dealloc
{
    NNHLog(@"------%s------",__func__);
}

- (instancetype)initWithTransferType:(NNHWalletTransferType)transferType
{
    if (self = [super init]) {
        _currentTransferType = transferType;
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
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightItemAction) title:@"明细"];
    self.navigationItem.rightBarButtonItem = rightItem;
    
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
    
    [self.view addSubview:self.codeView];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.countView.mas_bottom).offset(NNHLineH);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self.view addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.top.equalTo(self.codeView.mas_bottom).offset(NNHMargin_10);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
    }];
    
    [self.view addSubview:self.ensureButton];
    [self.ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentLabel);
        make.right.equalTo(self.view).offset(-NNHMargin_15);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(30);
        make.height.equalTo(@(NNHNormalViewH));
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField
{
    self.ensureButton.enabled = self.accountField.hasText && self.countField.hasText && self.codeTextFieldField.text.length == 6;
}

#pragma mark - Network Methods
/** 请求可用余额数据 */
- (void)requestBalanceData
{
    NNHWeakSelf(self)
    NNAPIBlockFundTool *fundTool = [[NNAPIBlockFundTool alloc] initWalletTransferWithType:self.currentTransferType];
    [fundTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [weakself.availableView configCoinName:responseDic[@"data"][@"unit"] count:responseDic[@"data"][@"balance"]];
        weakself.contentLabel.text = responseDic[@"data"][@"content"];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];    
}

#pragma mark - Target Methods
- (void)rightItemAction
{
    NNBlockFundTransferReocrdViewController *recordVC = [[NNBlockFundTransferReocrdViewController alloc]  initTransferRecordWithTransferType:self.currentTransferType];
    recordVC.navigationItem.title = @"转账明细";
    [self.navigationController pushViewController:recordVC animated:YES];
}

- (void)clickEnsureButton:(UIButton *)button
{
    [self.enterView showInFatherView:self.view];
}

- (void)getWalletAddress
{
    NNHScanCodeController *vc = [[NNHScanCodeController alloc] init];
    NNHWeakSelf(self)
    vc.getQrCodeBlock = ^(NSString *code) {
        weakself.accountField.text = code;
        [weakself textFieldDidChange:weakself.accountField];
    };
    [self.navigationController pushViewController:vc animated:NO];
}

/** 输入交易密码 */
- (void)inputPayCode:(NSString *)paycode
{
    NNHWeakSelf(self)
    [SVProgressHUD nn_showWithStatus:nil];
    NNAPIBlockFundTransferTool *blockTool = [[NNAPIBlockFundTransferTool alloc] initWalletTransferWithTransferType:self.currentTransferType transferNum:self.countField.text account:self.accountField.text verificationCode:self.codeTextFieldField.text paypwd:paycode];
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
        }];
        
        [_accountView addSubview:self.accountField];
        [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(NNHMargin_10);
            make.centerY.equalTo(_accountView);
            make.width.equalTo(@(SCREEN_WIDTH - 120));
            make.height.equalTo(_accountView.mas_height);
        }];
        
        UIButton *scanButton = [UIButton NNHBtnImage:@"ic_scan" target:self action:@selector(getWalletAddress)];
        scanButton.hidden = YES;
        [_accountView addSubview:scanButton];
        [scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(_accountView);
            make.width.equalTo(@44);
        }];
    }
    return _accountView;
}

- (UITextField *)accountField
{
    if (_accountField == nil) {
        _accountField = [[UITextField alloc] init];
        _accountField.font = [UIConfigManager fontThemeTextDefault];
        _accountField.placeholder = @"请输入账户";
        [_accountField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _accountField;
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
        _countField.delegate = self;
        _countField.keyboardType = UIKeyboardTypeDecimalPad;
        [_countField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _countField;
}

- (UIView *)codeView
{
    if (_codeView == nil) {
        _codeView = [[UIView alloc] init];
        _codeView.backgroundColor = [UIConfigManager colorThemeWhite];
        
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
        NNHWeakSelf(self)
        _codeButton = [[NNCountDownButton alloc] initWithTotalTime:60 titleBefre:@"获取验证码" titleConting:@"s" titleAfterCounting:@"获取验证码" clickAction:^(NNCountDownButton *countBtn) {
            NNHStrongSelf(self)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                NNHSendVerificationCodeType type;
                if (strongself.currentTransferType == NNHWalletTransferTypeLTTransfer) {
                    type = NNHSendVerificationCodeType_LTTransfer;
                }else if (strongself.currentTransferType == NNHWalletTransferTypeWFCCTransfer) {
                    type = NNHSendVerificationCodeType_WFCCTransfer;
                }else {
                    type = NNHSendVerificationCodeType_ZZTransfer;
                }

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
        _contentLabel = [UILabel NNHWithTitle:@"" titleColor:[UIColor redColor] font:[UIConfigManager fontThemeTextTip]];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

#pragma mark -
#pragma mark --------- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // 判断是否输入内容，或者用户点击的是键盘的删除按钮
    if (![string isEqualToString:@""]) {
        NSCharacterSet *cs;
        // 小数点在字符串中的位置 第一个数字从0位置开始
        NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
        // 判断字符串中是否有小数点，并且小数点不在第一位
        // NSNotFound 表示请求操作的某个内容或者item没有发现，或者不存在
        // range.location 表示的是当前输入的内容在整个字符串中的位置，位置编号从0开始
        if (dotLocation == NSNotFound && range.location != 0) {
            // 取只包含“myDotNumbers”中包含的内容，其余内容都被去掉
            /* [NSCharacterSet characterSetWithCharactersInString:myDotNumbers]的作用是去掉"myDotNumbers"中包含的所有内容，只要字符串中有内容与"myDotNumbers"中的部分内容相同都会被舍去在上述方法的末尾加上invertedSet就会使作用颠倒，只取与“myDotNumbers”中内容相同的字符
             */
            cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
            if (range.location >= 9) {
                NNHLog(@"单笔金额不能超过亿位");
                if ([string isEqualToString:@"."] && range.location == 9) {
                    return YES;
                }
                return NO;
            }
        }else {
            cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
        }
        // 按cs分离出数组,数组按@""分离出字符串
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if (!basicTest) {
            NNHLog(@"只能输入数字和小数点");
            return NO;
        }
        if (dotLocation != NSNotFound && range.location > dotLocation + 2) {
            NNHLog(@"小数点后最多两位");
            return NO;
        }
        if (textField.text.length > 11) {
            return NO;
        }
    }
    return YES;
}

@end
