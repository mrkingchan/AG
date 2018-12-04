//
//  NNForgetPasswordViewController.m
//  NBTMill
//
//  Created by 来旭磊 on 2018/3/30.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNForgetPasswordViewController.h"
#import "NNTextField.h"
#import "NNCountDownButton.h"
#import "UITextField+NNHExtension.h"
#import "UILabel+NNHAttributeTextTapAction.h"
#import "NNRegisterAreaView.h"
#import "NNHApiSecurityTool.h"
#import "NNHApiLoginTool.h"

@interface NNForgetPasswordViewController ()

/** 顶部image */
@property (nonatomic, strong) UIImageView *topView;
/** 电话号码 */
@property (nonatomic, strong) NNTextField *phoneTextFiled;
/** 验证码 */
@property (nonatomic, strong) NNTextField *codeTextFiled;
/** 密码 */
@property (nonatomic, strong) NNTextField *pwdTextFiled;
/** 获取验证码 */
@property (nonatomic, strong) NNCountDownButton *codeButton;
/** 注册按钮 */
@property (nonatomic, strong) UIButton *registerButton;
/** 返回登录 */
@property (nonatomic, strong) UILabel *backLoginLabel;

@end

@implementation NNForgetPasswordViewController

#pragma mark -
#pragma mark ---------Life Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"找回密码";
    self.view.backgroundColor = [UIConfigManager colorThemeWhite];
    
    [self setupChildView];
}

- (void)setupChildView
{
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NNHNavBarViewHeight);
        make.centerX.equalTo(self.view);
    }];
    
    [self.view addSubview:self.phoneTextFiled];
    [self.phoneTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(30);
        make.centerX.equalTo(self.topView);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.equalTo(@60);
    }];
    
    [self.view addSubview:self.codeTextFiled];
    [self.codeTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextFiled.mas_bottom).offset(10);
        make.centerX.equalTo(self.phoneTextFiled);
        make.size.equalTo(self.phoneTextFiled);
    }];
    
    [self.codeTextFiled addSubview:self.codeButton];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.codeTextFiled);
        make.right.equalTo(self.codeTextFiled);
        make.width.equalTo(@100);
        make.height.equalTo(@35);
    }];
    
    [self.view addSubview:self.pwdTextFiled];
    [self.pwdTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTextFiled.mas_bottom);
        make.centerX.equalTo(self.phoneTextFiled);
        make.size.equalTo(self.phoneTextFiled);
    }];
    
    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdTextFiled.mas_bottom).offset(30);
        make.centerX.equalTo(self.phoneTextFiled);
        make.width.equalTo(self.phoneTextFiled);
        make.height.equalTo(@44);
    }];
    
    [self.view addSubview:self.backLoginLabel];
    [self.backLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerButton.mas_bottom).offset(15);
        make.right.equalTo(self.registerButton);
        make.height.equalTo(@25);
    }];
}

#pragma mark -
#pragma mark ---------UserAction
- (void)registerAction
{
    NNHApiLoginTool *loginTool = [[NNHApiLoginTool alloc] initWithMobile:self.phoneTextFiled.text valicode:self.codeTextFiled.text loginpwd:self.pwdTextFiled.text confirmpwd:nil typeregister:@"2"];
    NNHWeakSelf(self)
    [SVProgressHUD nn_showWithStatus:@"提交中"];
    [loginTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        
        [SVProgressHUD dismissWithDelay:0.3 completion:^{
            [weakself.navigationController popViewControllerAnimated:YES];
        }];
        
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

#pragma mark -
#pragma mark ---------UITextFieldDelegate
- (void)textFieldDidChange:(NNTextField *)textField
{
    self.codeButton.enabled = self.phoneTextFiled.text.length == 11;
    self.registerButton.enabled = self.phoneTextFiled.text.length == 11 && self.codeTextFiled.text.length == 6 && self.pwdTextFiled.text.length;
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (NNTextField *)phoneTextFiled
{
    if (_phoneTextFiled == nil) {
        _phoneTextFiled = [[NNTextField alloc] initWithPlaceholder:@"手机号" leftImage:@"tel_icon"];
        [_phoneTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextFiled.nn_maxLength = 11;
    }
    return _phoneTextFiled;
}

- (NNTextField *)codeTextFiled
{
    if (_codeTextFiled == nil) {
        _codeTextFiled = [[NNTextField alloc] initWithPlaceholder:@"验证码" leftImage:@"verificationcode_icon"];
        [_codeTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _codeTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextFiled.nn_maxLength = 6;
        _codeTextFiled.rightViewMode = UITextFieldViewModeAlways;
    }
    return _codeTextFiled;
}

- (NNTextField *)pwdTextFiled
{
    if (_pwdTextFiled == nil) {
        _pwdTextFiled = [[NNTextField alloc] initWithPlaceholder:@"请输入密码" leftImage:@"password"];
        [_pwdTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _pwdTextFiled.nn_maxLength = 16;
        _pwdTextFiled.showEyes = YES;
    }
    return _pwdTextFiled;
}

/** 获取验证码按钮 */
- (NNCountDownButton *)codeButton
{
    if (_codeButton == nil) {
                NNHWeakSelf(self)
        _codeButton = [[NNCountDownButton alloc] initWithTotalTime:60 titleBefre:@"获取验证码" titleConting:@"s" titleAfterCounting:@"获取验证码" clickAction:^(NNCountDownButton *countBtn) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                NNHApiSecurityTool *apiTool = [[NNHApiSecurityTool alloc] initWithMobile:weakself.phoneTextFiled.text verifyCodeType:NNHSendVerificationCodeType_userForgetpwd];
                
                [apiTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
                    [countBtn startCounting];
                    [SVProgressHUD showMessage:@"获取验证码成功 请注意查收"];
                } failBlock:^(NNHRequestError *error) {
                    [countBtn resetButton];
                } isCached:NO];
            });
        }];
        _codeButton.enabled = NO;
        _codeButton.layer.cornerRadius = 35 *0.5;
        _codeButton.layer.borderWidth = NNHLineH;
        _codeButton.layer.borderColor = [UIConfigManager colorThemeBlack].CGColor;
        _codeButton.lbCountingColor = [UIConfigManager colorThemeBlack];
    }
    return _codeButton;
}

- (UILabel *)backLoginLabel
{
    if (_backLoginLabel == nil) {
        _backLoginLabel = [UILabel NNHWithTitle:@"已有账户，去登录" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_backLoginLabel.text];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor akext_colorWithHex:@"#3fa2ff"] range:NSMakeRange(6, 2)];
        _backLoginLabel.attributedText = attributedString;
        NNHWeakSelf(self)
        [_backLoginLabel nnh_addAttributeTapActionWithStrings:@[@"登录"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
            [weakself.navigationController popViewControllerAnimated:YES];
        }];
        _backLoginLabel.enabledTapEffect = NO;
    }
    
    return _backLoginLabel;
}

- (UIButton *)registerButton
{
    if (_registerButton == nil) {
        _registerButton = [UIButton NNHOperationBtnWithTitle:@"确定" target:self action:@selector(registerAction) operationButtonType:NNHOperationButtonTypeBlue isAddCornerRadius:YES];
        _registerButton.nn_acceptEventInterval = NNHAcceptEventInterval;
        _registerButton.enabled = NO;
    }
    return _registerButton;
}

- (UIImageView *)topView
{
    if (_topView == nil) {
        _topView = [[UIImageView alloc] initWithImage:ImageName(@"login_logo")];
    }
    return _topView;
}

@end
