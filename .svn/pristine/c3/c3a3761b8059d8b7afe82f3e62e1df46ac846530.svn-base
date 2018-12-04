//
//  NNHRegisterViewController.m
//  TFC
//
//  Created by 牛牛 on 2018/6/25.
//  Copyright © 2018年 牛牛汇. All rights reserved.
//

#import "NNHRegisterViewController.h"
#import "NNHLoginTextField.h"
#import "UILabel+NNHAttributeTextTapAction.h"
#import "NNWebViewController.h"
#import "NNCountDownButton.h"
#import "NNHApiLoginTool.h"
#import "NNHApiSecurityTool.h"
#import "UIButton+NNImagePosition.h"
#import "NNRegisterAreaView.h"
#import "NNHCountryCodeModel.h"

@interface NNHRegisterViewController ()<UITextFieldDelegate, UIScrollViewDelegate>

/** 选择郭嘉 */
@property (nonatomic, strong) NNHLoginTextField *areaTextFiled;
/** 电话号码 */
@property (nonatomic, strong) NNHLoginTextField *phoneTextFiled;
/** 用户名 */
@property (nonatomic, strong) NNHLoginTextField *userNameTextFiled;
/** 接点人 */
@property (nonatomic, strong) NNHLoginTextField *pointTextFiled;
/** 邀请人 */
@property (nonatomic, strong) NNHLoginTextField *inviteTextField;
/** 密码 */
@property (nonatomic, strong) NNHLoginTextField *passwordTextFiled;
/** 支付密码 */
@property (nonatomic, strong) NNHLoginTextField *payTextFiled;
/** 验证码 */
@property (nonatomic, strong) NNHLoginTextField *codeTextField;
/** 左接点 */
@property (nonatomic, strong) UIButton *leftPointButton;
/** 右接点 */
@property (nonatomic, strong) UIButton *rightPointButton;
/** 登录按钮 */
@property (nonatomic, strong) UIButton *registerButton;
/** 获取验证码按钮 */
@property (nonatomic, strong) NNCountDownButton *codeButton;
/** 注册协议label */
@property (nonatomic, strong) UILabel *tipLabel;
/** 同意注册协议label */
@property (nonatomic, strong) UIButton *agreeButton;
/** 返回按钮 */
@property (nonatomic, strong) UIButton *backButton;
/** 区域选择箭头 */
@property (nonatomic, strong) UIImageView *arrowImageView;
/** 区域view */
@property (nonatomic, strong) NNRegisterAreaView *areaMenu;
/** 下拉框是否打开 */
@property (nonatomic, assign) BOOL openFlag;
/** scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation NNHRegisterViewController

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
    
    [self requestCodeData];
    
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
    UILabel *titleLabel = [UILabel NNHWithTitle:@"注册" titleColor:[UIConfigManager colorThemeDark] font:[UIFont boldSystemFontOfSize:25]];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backButton.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(marginX);
    }];
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    contentView.delegate = self;
    [self.view addSubview:contentView];
    self.scrollView = contentView;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view).offset(-15);
        make.bottom.equalTo(self.view);
    }];
    
    [contentView addSubview:self.areaTextFiled];
    [self.areaTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView);
        make.centerX.equalTo(contentView);
        make.height.equalTo(@(50));
        make.width.equalTo(@(SCREEN_WIDTH - 42 * 2));
    }];
    
    [contentView addSubview:self.phoneTextFiled];
    [self.phoneTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.areaTextFiled.mas_bottom);
        make.size.equalTo(self.areaTextFiled);
        make.centerX.equalTo(contentView);
    }];
    
    [contentView addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextFiled.mas_bottom);
        make.size.equalTo(self.phoneTextFiled);
        make.centerX.equalTo(contentView);
    }];
    
    [self.codeTextField addSubview:self.codeButton];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.codeTextField);
        make.right.equalTo(self.codeTextField).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@35);
    }];
    
    UILabel *promptLabel1 = [UILabel NNHWithTitle:@"    用户名和推荐人输入后将不能更改，请仔细核对" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextTip]];
    NNHViewRadius(promptLabel1, 2.0);
    promptLabel1.backgroundColor = [UIColor akext_colorWithHex:@"e9e9f0"];
    [contentView addSubview:promptLabel1];
    [promptLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTextField.mas_bottom).offset(40);
        make.width.equalTo(self.phoneTextFiled);
        make.height.equalTo(@30);
        make.centerX.equalTo(contentView);
    }];
    
    [contentView addSubview:self.userNameTextFiled];
    [self.userNameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(promptLabel1.mas_bottom);
        make.centerX.equalTo(contentView);
        make.size.equalTo(self.phoneTextFiled);
    }];
    
    [contentView addSubview:self.inviteTextField];
    [self.inviteTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameTextFiled.mas_bottom);
        make.centerX.equalTo(contentView);
        make.size.equalTo(self.phoneTextFiled);
    }];
    
    [contentView addSubview:self.pointTextFiled];
    [self.pointTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inviteTextField.mas_bottom);
        make.centerX.equalTo(contentView);
        make.size.equalTo(self.phoneTextFiled);
    }];
    
    [contentView addSubview:self.leftPointButton];
    [self.leftPointButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pointTextFiled.mas_bottom);
        make.left.equalTo(self.phoneTextFiled).offset(15);
        make.height.equalTo(self.phoneTextFiled);
    }];
    
    [contentView addSubview:self.rightPointButton];
    [self.rightPointButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftPointButton);
        make.left.equalTo(contentView.mas_centerX).offset(15);
        make.height.equalTo(self.leftPointButton);
    }];
    
    UILabel *promptLabel2 = [UILabel NNHWithTitle:@"    设置登录密码和支付密码" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextTip]];
    NNHViewRadius(promptLabel2, 2.0);
    promptLabel2.backgroundColor = [UIColor akext_colorWithHex:@"e9e9f0"];
    [contentView addSubview:promptLabel2];
    [promptLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftPointButton.mas_bottom).offset(20);
        make.width.equalTo(self.phoneTextFiled);
        make.height.equalTo(promptLabel1);
        make.centerX.equalTo(contentView);
    }];
    
    [contentView addSubview:self.passwordTextFiled];
    [self.passwordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(promptLabel2.mas_bottom);
        make.centerX.equalTo(contentView);
        make.size.equalTo(self.phoneTextFiled);
    }];
    
    [contentView addSubview:self.payTextFiled];
    [self.payTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextFiled.mas_bottom);
        make.centerX.equalTo(contentView);
        make.size.equalTo(self.phoneTextFiled);
    }];
    
    [contentView addSubview:self.agreeButton];
    [self.agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payTextFiled.mas_bottom);
        make.left.equalTo(self.phoneTextFiled).offset(8);
        make.height.equalTo(@50);
    }];
    
    [contentView addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.agreeButton);
        make.left.equalTo(self.agreeButton.mas_right);
        make.height.equalTo(self.agreeButton);
    }];
    
    [contentView addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.agreeButton.mas_bottom);
        make.centerX.equalTo(self.phoneTextFiled);
        make.size.equalTo(self.phoneTextFiled);
    }];
    
    UIButton *loginButton = [UIButton NNHBtnTitle:@"已有账号马上登录" titileFont:[UIConfigManager fontThemeTextDefault] backGround:[UIColor clearColor] titleColor:[UIConfigManager colorThemeRed]];
    [loginButton addTarget:self action:@selector(backLoginClick) forControlEvents:UIControlEventTouchUpInside];
    loginButton.adjustsImageWhenHighlighted = NO;
    [contentView addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerButton.mas_bottom);
        make.right.equalTo(self.registerButton);
        make.height.equalTo(@50);
        make.bottom.equalTo(contentView).offset(-150);
    }];
    
    [contentView addSubview:self.areaMenu];
    [self.areaMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.areaTextFiled.mas_bottom);
        make.centerX.equalTo(contentView);
        make.width.equalTo(@(SCREEN_WIDTH - 42 * 2));
        make.height.equalTo(@(0));
    }];
}

#pragma mark -
#pragma mark ---------私有方法
- (void)requestCodeData
{
    NNHWeakSelf(self)
    NNHApiLoginTool *loginTool = [[NNHApiLoginTool alloc] initCountryCodeData];
    [loginTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        weakself.areaMenu.dataSource = [NNHCountryCodeModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"]];
        
        weakself.areaTextFiled.text = [NSString stringWithFormat:@"%@  |   %@",weakself.areaMenu.selectedModel.scode, weakself.areaMenu.selectedModel.name];
        
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}


- (void)registerButtonClick
{
    if (self.phoneTextFiled.text.length < 6) {
        [SVProgressHUD showMessage:@"请输入正确的手机号码"];
        return;
    }
    if (self.codeTextField.text.length < 6) {
        [SVProgressHUD showMessage:@"请输入正确的验证码"];
        return;
    }
    if (self.userNameTextFiled.text.length < 6) {
        [SVProgressHUD showMessage:@"请输入6-25位用户名"];
        return;
    }
    if (!self.inviteTextField.hasText) {
        [SVProgressHUD showMessage:@"请输入推荐人用户名"];
        return;
    }
    if (!self.pointTextFiled.hasText) {
        [SVProgressHUD showMessage:@"请输入接点人用户名"];
        return;
    }
    if (self.passwordTextFiled.text.length < 6) {
        [SVProgressHUD showMessage:@"请请输入6-16字符、数字密码"];
        return;
    }
    if (self.payTextFiled.text.length < 6) {
        [SVProgressHUD showMessage:@"请输入6位数字支付密码"];
        return;
    }
    if (!self.agreeButton.isSelected) {
        [SVProgressHUD showMessage:@"请同意注册协议"];
        return;
    }
    
    NSString *pointLocation = self.leftPointButton.enabled ? @"2" : @"1";
    NNHApiLoginTool *loginTool = [[NNHApiLoginTool alloc] initRegisterWithMobile:self.phoneTextFiled.text valicode:self.codeTextField.text username:self.userNameTextFiled.text parentname:self.inviteTextField.text nodename:self.pointTextFiled.text position:pointLocation loginpwd:self.passwordTextFiled.text paypwd:self.payTextFiled.text checkcode:self.checkcode countrycode:self.areaMenu.selectedModel.code];
    NNHWeakSelf(self)
    [SVProgressHUD nn_showWithStatus:@"注册中"];
    [loginTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        NNHStrongSelf(self)
        [SVProgressHUD dismissWithDelay:0.5 completion:^{
            [SVProgressHUD showMessage:@"注册成功"];
            [strongself.navigationController popViewControllerAnimated:YES];
        }];

    } failBlock:^(NNHRequestError *error) {

    } isCached:NO];
}

- (void)agreeButtonClick:(UIButton *)button
{
    button.selected = !button.selected;
}

- (void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)backLoginClick
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)selectedPointLocation:(UIButton *)button
{
    if (button == self.leftPointButton) {
        self.rightPointButton.enabled = YES;
        self.leftPointButton.enabled = NO;
    }else{
        self.rightPointButton.enabled = NO;
        self.leftPointButton.enabled = YES;
    }
}

/** 点击下拉框 打开或关闭币种选择 */
- (void)changeTableViewUIWithOpen:(BOOL)openFlag
{
    if (!openFlag) { // 如果要打开
        self.areaMenu.hidden = NO;
        
        CGFloat height = 54 * 5 + 40;
        [UIView animateWithDuration:0.3 animations:^{
            [self.areaMenu mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.areaTextFiled.mas_bottom);
                make.centerX.equalTo(self.scrollView);
                make.width.mas_equalTo(SCREEN_WIDTH - 85);
                make.height.equalTo(@(height));
            }];
        } completion:^(BOOL finished) {
            self.openFlag = YES;
        }];
        
    }else { // 如果要打开
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.areaMenu mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.areaTextFiled.mas_bottom);
                make.centerX.equalTo(self.scrollView);
                make.width.mas_equalTo(SCREEN_WIDTH - 85);
                make.height.equalTo(@(0));
            }];
        } completion:^(BOOL finished) {
            self.areaMenu.hidden = YES;
            self.openFlag = NO;
        }];
    }
    [self.view layoutIfNeeded];
}

#pragma mark -
#pragma mark ---------UITextFieldDelegate
- (void)textFieldDidChange:(NNHLoginTextField *)textField
{
    self.codeButton.enabled = self.phoneTextFiled.text.length > 5;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.areaTextFiled) {
        [self changeTableViewUIWithOpen:self.openFlag];
        return NO;
    }else {
        return YES;
    }
}

#pragma mark -
#pragma mark --------- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.openFlag) {
       [self changeTableViewUIWithOpen:self.openFlag];
    }
}

#pragma mark -
#pragma mark ---------getter && setter
- (NNHLoginTextField *)areaTextFiled
{
    if (_areaTextFiled == nil) {
        _areaTextFiled = [[NNHLoginTextField alloc] init];
        _areaTextFiled.text = @"+86  |  中国";
        _areaTextFiled.delegate = self;
        
        [_areaTextFiled addSubview:self.arrowImageView];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_areaTextFiled).offset(-NNHMargin_5);
            make.centerY.equalTo(_areaTextFiled);
        }];
    }
    return _areaTextFiled;
}

- (NNHLoginTextField *)phoneTextFiled
{
    if (_phoneTextFiled == nil) {
        _phoneTextFiled = [[NNHLoginTextField alloc] init];
        _phoneTextFiled.placeholder = @"请输入您的手机号";
        [_phoneTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneTextFiled;
}

- (NNHLoginTextField *)codeTextField
{
    if (_codeTextField == nil) {
        _codeTextField = [[NNHLoginTextField alloc] init];
        _codeTextField.placeholder = @"请输入验证码";
        [_codeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.nn_maxLength = 6;
    }
    return _codeTextField;
}

- (NNHLoginTextField *)userNameTextFiled
{
    if (_userNameTextFiled == nil) {
        _userNameTextFiled = [[NNHLoginTextField alloc] init];
        _userNameTextFiled.placeholder = @"请输入6-25位用户名";
        [_userNameTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _userNameTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
        _userNameTextFiled.nn_maxLength = 25;
    }
    return _userNameTextFiled;
}

- (NNHLoginTextField *)inviteTextField
{
    if (_inviteTextField == nil) {
        _inviteTextField = [[NNHLoginTextField alloc] init];
        _inviteTextField.placeholder = @"请输入推荐人用户名";
        [_inviteTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _inviteTextField.keyboardType = UIKeyboardTypeASCIICapable;
    }
    return _inviteTextField;
}

- (NNHLoginTextField *)pointTextFiled
{
    if (_pointTextFiled == nil) {
        _pointTextFiled = [[NNHLoginTextField alloc] init];
        _pointTextFiled.placeholder = @"请输入接点人用户名";
        [_pointTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _pointTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
    }
    return _pointTextFiled;
}

- (NNHLoginTextField *)passwordTextFiled
{
    if (_passwordTextFiled == nil) {
        _passwordTextFiled = [[NNHLoginTextField alloc] init];
        _passwordTextFiled.placeholder = @"请输入6-16字符、数字密码";
        _passwordTextFiled.showSecureButotn = YES;
        [_passwordTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _passwordTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordTextFiled.nn_maxLength = 16;
    }
    return _passwordTextFiled;
}

- (NNHLoginTextField *)payTextFiled
{
    if (_payTextFiled == nil) {
        _payTextFiled = [[NNHLoginTextField alloc] init];
        _payTextFiled.placeholder = @"请输入6位数字支付密码";
        _payTextFiled.showSecureButotn = YES;
        [_payTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _payTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        _payTextFiled.nn_maxLength = 6;
    }
    return _payTextFiled;
}

- (UIButton *)agreeButton
{
    if (_agreeButton == nil) {
        _agreeButton = [UIButton NNHBtnImage:@"login_not_check" target:self action:@selector(agreeButtonClick:)];
        [_agreeButton setImage:[UIImage imageNamed:@"login_check"] forState:UIControlStateSelected];
        _agreeButton.adjustsImageWhenHighlighted = NO;
        _agreeButton.selected = YES;
    }
    return _agreeButton;
}

- (UILabel *)tipLabel
{
    if (_tipLabel == nil) {
        _tipLabel = [UILabel NNHWithTitle:@"我已阅读并同意《AAG注册协议》" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextTip]];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_tipLabel.text];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor akext_colorWithHex:@"c88f45"] range:NSMakeRange(7, 9)];
        _tipLabel.attributedText = attributedString;
        NNHWeakSelf(self)
        [_tipLabel nnh_addAttributeTapActionWithStrings:@[@"《AAG注册协议》"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
            NNWebViewController *vc = [[NNWebViewController alloc] init];
            vc.url = NNH_API_MemberAgreement;
            [weakself.navigationController pushViewController:vc animated:YES];
        }];
        _tipLabel.enabledTapEffect = NO;
    }
    
    return _tipLabel;
}

- (UIButton *)backButton
{
    if (_backButton == nil) {
        _backButton = [UIButton NNHBtnImage:@"ic_login_close" target:self action:@selector(backButtonClick)];
        _backButton.adjustsImageWhenHighlighted = NO;
    }
    return _backButton;
}

- (UIButton *)registerButton
{
    if (_registerButton == nil) {
        _registerButton = [UIButton NNHOperationBtnWithTitle:@"注册" target:self action:@selector(registerButtonClick) operationButtonType:NNHOperationButtonTypeBlue isAddCornerRadius:YES];
        [_registerButton setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:.4] forState:UIControlStateDisabled];
    }
    return _registerButton;
}

- (UIButton *)leftPointButton
{
    if (_leftPointButton == nil) {
        _leftPointButton = [UIButton NNHBtnTitle:@"左" titileFont:[UIConfigManager fontThemeTextDefault] backGround:[UIColor clearColor] titleColor:[UIConfigManager colorThemeRed]];
        [_leftPointButton addTarget:self action:@selector(selectedPointLocation:) forControlEvents:UIControlEventTouchUpInside];
        [_leftPointButton setImage:ImageName(@"ic_login_not_check") forState:UIControlStateNormal];
        [_leftPointButton setImage:ImageName(@"ic_login_check") forState:UIControlStateDisabled];
        [_leftPointButton nn_setImagePosition:NNImagePositionLeft spacing:5];
        _leftPointButton.enabled = NO;
    }
    return _leftPointButton;
}

- (UIButton *)rightPointButton
{
    if (_rightPointButton == nil) {
        _rightPointButton = [UIButton NNHBtnTitle:@"右" titileFont:[UIConfigManager fontThemeTextDefault] backGround:[UIColor clearColor] titleColor:[UIConfigManager colorThemeRed]];
        [_rightPointButton addTarget:self action:@selector(selectedPointLocation:) forControlEvents:UIControlEventTouchUpInside];
        [_rightPointButton setImage:ImageName(@"ic_login_not_check") forState:UIControlStateNormal];
        [_rightPointButton setImage:ImageName(@"ic_login_check") forState:UIControlStateDisabled];
        [_rightPointButton nn_setImagePosition:NNImagePositionLeft spacing:5];
    }
    return _rightPointButton;
}

- (NNCountDownButton *)codeButton
{
    if (_codeButton == nil) {
        NNHWeakSelf(self)
        _codeButton = [[NNCountDownButton alloc] initWithTotalTime:60 titleBefre:@"获取验证码" titleConting:@"s" titleAfterCounting:@"获取验证码" clickAction:^(NNCountDownButton *countBtn) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NNHStrongSelf(self)
                NNHApiSecurityTool *tool = [[NNHApiSecurityTool alloc] initWithMobile:strongself.phoneTextFiled.text verifyCodeType:NNHSendVerificationCodeType_userRegister countryCode:weakself.areaMenu.selectedModel.code];
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
        _codeButton.enabled = NO;
    }
    return _codeButton;
}

- (UIImageView *)arrowImageView
{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"mine_order_arrow"];
    }
    return _arrowImageView;
}

- (NNRegisterAreaView *)areaMenu
{
    if (_areaMenu == nil) {
        _areaMenu = [[NNRegisterAreaView alloc] init];
        _areaMenu.hidden = YES;
        NNHWeakSelf(self)
        _areaMenu.selectedCodeBlock = ^(NNHCountryCodeModel *countryCode) {
            
            weakself.areaTextFiled.text = [NSString stringWithFormat:@"%@  |   %@",weakself.areaMenu.selectedModel.scode, weakself.areaMenu.selectedModel.name];
            [weakself changeTableViewUIWithOpen:weakself.openFlag];
        };
    }
    return _areaMenu;
}

@end
