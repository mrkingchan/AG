//
//  NNHLoginViewController.m
//  NNCivetCat
//
//  Created by 牛牛 on 2017/2/27.
//  Copyright © 2017年 灵猫. All rights reserved.
//

#import "NNHLoginViewController.h"
#import "NNHRegisterViewController.h"
#import "NNVerifyPhoneViewController.h"
#import "NNHLoginTextField.h"
#import "NNHApiLoginTool.h"
#import "NNNavigationController.h"
#import "UIWindow+NNExtension.h"

@interface NNHLoginViewController ()

/** 电话号码 */
@property (nonatomic, strong) NNHLoginTextField *phoneTextFiled;
/** 密码 */
@property (nonatomic, strong) NNHLoginTextField *passwordTextFiled;
/** 登录按钮 */
@property (nonatomic, strong) UIButton *loginButton;
/** 返回按钮 */
@property (nonatomic, strong) UIButton *backButton;
/** 忘记密码按钮 */
@property (nonatomic, strong) UIButton *missCodeButton;
/** 注册 */
@property (nonatomic, strong) UIButton *registerButton;

@end

@implementation NNHLoginViewController

#pragma mark -
#pragma mark ---------Life Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupChildView];
}

/** 添加子控件 */
- (void)setupChildView
{
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-NNHMargin_10);
        make.top.equalTo(self.view).offset(STATUSBAR_HEIGHT);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    CGFloat marginX = 42;
    UILabel *titleLabel = [UILabel NNHWithTitle:@"登录" titleColor:[UIConfigManager colorThemeDark] font:[UIFont boldSystemFontOfSize:25]];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backButton.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(marginX);
    }];
    
    [self.view addSubview:self.phoneTextFiled];
    [self.phoneTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(110);
        make.height.equalTo(@(NNHNormalViewH));
        make.width.equalTo(@(SCREEN_WIDTH - marginX * 2));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.passwordTextFiled];
    [self.passwordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextFiled.mas_bottom).offset(15);
        make.centerX.equalTo(self.phoneTextFiled);
        make.size.equalTo(self.phoneTextFiled);
    }];
    
    [self.view addSubview:self.missCodeButton];
    [self.missCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextFiled.mas_bottom);
        make.left.equalTo(self.phoneTextFiled).offset(15);
        make.height.equalTo(@(50));
    }];
    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.missCodeButton);
        make.right.equalTo(self.phoneTextFiled).offset(-15);
        make.height.equalTo(@(50));
    }];
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.missCodeButton.mas_bottom);
        make.centerX.equalTo(self.phoneTextFiled);
        make.size.equalTo(self.phoneTextFiled);
    }];
}

#pragma mark -
#pragma mark ---------私有方法
- (void)loginButtonClick:(UIButton *)button
{
    if (self.phoneTextFiled.text.length < 6) {
        [SVProgressHUD showMessage:@"请输入6-25位用户名"];
        return;
    }
    if (self.passwordTextFiled.text.length < 6) {
        [SVProgressHUD showMessage:@"请输入6-16位密码"];
        return;
    }    
    
    NNHApiLoginTool *loginTool = [[NNHApiLoginTool alloc] initLoginWithUserName:self.phoneTextFiled.text loginpwd:self.passwordTextFiled.text];
    NNHWeakSelf(self)
    [SVProgressHUD nn_showWithStatus:@"登录中"];
    [loginTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        NNHStrongSelf(self)
        [SVProgressHUD dismissWithDelay:0.5 completion:^{
            [strongself loginSuccessfullyProcessData:responseDic];
        }];
        
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (void)loginSuccessfullyProcessData:(NSDictionary *)responseDic
{
    // 保存登录数据
    NNUserModel *userModel = [[NNUserModel alloc] init];
    userModel.mtoken = responseDic[@"data"][@"mtoken"];
    userModel.completemobile = responseDic[@"data"][@"mobile"];
    userModel.tradeoperurl = responseDic[@"data"][@"tradeoperurl"];
    userModel.username = self.phoneTextFiled.text;
    [[NNHProjectControlCenter sharedControlCenter] userControl_saveUserDataWithUserInfo:userModel];

    if (self.successLoginblock) {
        self.successLoginblock();
    }

    // 切换控制器
    [[UIApplication sharedApplication].keyWindow loadRootViewController];
}

- (void)agreeButtonClick:(UIButton *)button
{
    button.selected = !button.selected;
}

- (void)backButtonClick:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)missCodeButtonClick
{
    NNVerifyPhoneViewController *vc = [[NNVerifyPhoneViewController alloc] initWithType:NNHSendVerificationCodeType_userForgetpwd];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)registerButtonClick
{
    NNHRegisterViewController *vc = [[NNHRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark -
#pragma mark ---------UITextFieldDelegate
- (void)textFieldDidChange:(NNHLoginTextField *)textField
{
    self.loginButton.enabled = self.phoneTextFiled.text.length >= 6 && self.passwordTextFiled.text.length >= 6;
}

#pragma mark -
#pragma mark ---------getter && setter
- (NNHLoginTextField *)phoneTextFiled
{
    if (_phoneTextFiled == nil) {
        _phoneTextFiled = [[NNHLoginTextField alloc] init];
        _phoneTextFiled.placeholder = @"请输入6-25位用户名";
        _phoneTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
        _phoneTextFiled.nn_maxLength = 25;
    }
    return _phoneTextFiled;
}

- (NNHLoginTextField *)passwordTextFiled
{
    if (_passwordTextFiled == nil) {
        _passwordTextFiled = [[NNHLoginTextField alloc] init];
        _passwordTextFiled.placeholder = @"请输入6-16位密码";
        _passwordTextFiled.showSecureButotn = YES;
        _passwordTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordTextFiled.nn_maxLength = 16;
    }
    return _passwordTextFiled;
}

- (UIButton *)loginButton
{
    if (_loginButton == nil) {
        _loginButton = [UIButton NNHOperationBtnWithTitle:@"登录" target:self action:@selector(loginButtonClick:) operationButtonType:NNHOperationButtonTypeBlue isAddCornerRadius:YES];
        [_loginButton setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:.4] forState:UIControlStateDisabled];
    }
    return _loginButton;
}

- (UIButton *)backButton
{
    if (_backButton == nil) {
        _backButton = [UIButton NNHBtnImage:@"ic_login_close" target:self action:@selector(backButtonClick:)];
        _backButton.hidden = YES;
        _backButton.adjustsImageWhenHighlighted = NO;
    }
    return _backButton;
}

- (UIButton *)missCodeButton
{
    if (_missCodeButton == nil) {
        _missCodeButton = [UIButton NNHBtnTitle:@"忘记密码?" titileFont:[UIConfigManager fontThemeTextDefault] backGround:[UIColor whiteColor] titleColor:[UIConfigManager colorThemeRed]];
        [_missCodeButton addTarget:self action:@selector(missCodeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _missCodeButton.adjustsImageWhenHighlighted = NO;
    }
    return _missCodeButton;
}

- (UIButton *)registerButton
{
    if (_registerButton == nil) {
        _registerButton = [UIButton NNHBtnTitle:@"注册" titileFont:[UIConfigManager fontThemeTextDefault] backGround:[UIColor whiteColor] titleColor:[UIConfigManager colorThemeRed]];
        [_registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _registerButton.adjustsImageWhenHighlighted = NO;
    }
    return _registerButton;
}

@end

