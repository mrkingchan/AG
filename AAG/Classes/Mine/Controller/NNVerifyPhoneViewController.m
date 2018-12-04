//
//  NNHVerifyPhoneViewController.m
//  NBTMill
//
//  Created by 来旭磊 on 2018/3/7.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNVerifyPhoneViewController.h"
#import "NNTextField.h"
#import "NNCountDownButton.h"
#import "NNHApiSecurityTool.h"
#import "NNSetUpLoginPasswordViewController.h"
#import "NNSetUpPayPasswordViewController.h"

@interface NNVerifyPhoneViewController ()

/** 手机号码 */
@property (nonatomic, strong) UILabel *phoneNumLabel;
/** 确认按钮 */
@property (nonatomic, strong) UIButton *ensureButton;
/** 手机号码 */
@property (nonatomic, strong) NNTextField *phoneField;
/** 验证码 */
@property (nonatomic, strong) NNTextField *codeField;
/** 获取验证码 */
@property (nonatomic, strong) NNCountDownButton *codeButton;
/** 发送验证码类型 */
@property (nonatomic, assign) NNHSendVerificationCodeType type;
@end

@implementation NNVerifyPhoneViewController
{
    NSString *_currentPhoneNumber;
}

#pragma mark - Life Cycle Methods
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (instancetype)initWithType:(NNHSendVerificationCodeType)type
{
    if (self = [super init]) {
        _type = type;
        _currentPhoneNumber = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.moble;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"验证手机";
    
    [self setupChildView];
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    if (![NSString isEmptyString:_currentPhoneNumber]) {
        UILabel *titleLabel = [UILabel NNHWithTitle:@"手机号码：" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
        [self.view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(NNHMargin_10);
            make.left.equalTo(self.view).offset(NNHMargin_15);
            make.height.equalTo(@44);
        }];
        
        [self.view addSubview:self.phoneNumLabel];
        [self.phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(NNHMargin_5);
            make.centerY.equalTo(titleLabel);
        }];
    }else{
        [self.view addSubview:self.phoneField];
        [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(NNHMargin_10);
            make.left.right.equalTo(self.view);
            make.height.equalTo(@44);
        }];
    }
    
    UIView *codeView = [[UIView alloc] init];
    codeView.backgroundColor = [UIConfigManager colorThemeWhite];
    [self.view addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(10 + 44 + 10);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [codeView addSubview:self.codeField];
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(codeView);
        make.top.bottom.equalTo(codeView);
        make.width.equalTo(@(SCREEN_WIDTH - 120));
    }];
    
    [codeView addSubview:self.codeButton];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(codeView).offset(-NNHMargin_15);
        make.centerY.equalTo(codeView);
        make.height.equalTo(@(30));
        make.width.equalTo(@80);
    }];
    
    [self.view addSubview:self.ensureButton];
    [self.ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.right.equalTo(self.view).offset(-NNHMargin_15);
        make.top.equalTo(codeView.mas_bottom).offset(60);
        make.height.equalTo(@(NNHNormalViewH));
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField
{
    if (![NSString isEmptyString:_currentPhoneNumber]) {
        self.ensureButton.enabled = self.codeField.hasText;
    }else{
        self.ensureButton.enabled = self.phoneField.text.length  > 10 && self.codeField.hasText;
    }
}

#pragma mark - Target Methods
- (void)clickEnsureButton:(UIButton *)button
{
    NNHWeakSelf(self)
    NNHApiSecurityTool *apiTool = [[NNHApiSecurityTool alloc] initSetUpLoginPasswordWithMobile:![NSString isEmptyString:_currentPhoneNumber] ? _currentPhoneNumber : self.phoneField.text  code:self.codeField.text];
    [apiTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        if (weakself.type == NNHSendVerificationCodeType_changeLoginPassword || weakself.type == NNHSendVerificationCodeType_userForgetpwd) {
            NNSetUpLoginPasswordViewController *setVc = [[NNSetUpLoginPasswordViewController alloc] init];
            setVc.encrypt = responseDic[@"data"][@"encrypt"];
            setVc.mobile = responseDic[@"data"][@"moble"];
            [weakself.navigationController pushViewController:setVc animated:YES];
        }else if (weakself.type == NNHSendVerificationCodeType_changePayPassword) {
            NNSetUpPayPasswordViewController *setVc = [[NNSetUpPayPasswordViewController alloc] initWithFromType:NNHChangePayCodeFromType_Other];
            [weakself.navigationController pushViewController:setVc animated:YES];
        }
    } failBlock:^(NNHRequestError *error) {

    } isCached:NO];
}

#pragma mark - Lazy Loads
- (UILabel *)phoneNumLabel
{
    if (_phoneNumLabel == nil) {
        _phoneNumLabel = [UILabel NNHWithTitle:_currentPhoneNumber titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _phoneNumLabel;
}

- (NNTextField *)phoneField
{
    if (_phoneField == nil) {
        _phoneField = [[NNTextField alloc] init];
        _phoneField.placeholder = @"请输入您的手机号码";
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _phoneField.nn_maxLength = 11;
    }
    return _phoneField;
}

- (NNTextField *)codeField
{
    if (_codeField == nil) {
        _codeField = [[NNTextField alloc] init];
        _codeField.placeholder = @"请输入验证码";
        _codeField.keyboardType = UIKeyboardTypeNumberPad;
        [_codeField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _codeField.nn_maxLength = 6;
    }
    return _codeField;
}

- (UIButton *)ensureButton
{
    if (_ensureButton == nil) {
        _ensureButton = [UIButton NNHOperationBtnWithTitle:@"下一步" target:self action:@selector(clickEnsureButton:) operationButtonType:NNHOperationButtonTypeBlue isAddCornerRadius:YES];
        _ensureButton.enabled = NO;
        _ensureButton.nn_acceptEventInterval = NNHAcceptEventInterval;
    }
    return _ensureButton;
}

/** 获取验证码按钮 */
- (NNCountDownButton *)codeButton
{
    if (_codeButton == nil) {
        NNHWeakSelf(self)
        _codeButton = [[NNCountDownButton alloc] initWithTotalTime:60 titleBefre:@"获取验证码" titleConting:@"s" titleAfterCounting:@"获取验证码" clickAction:^(NNCountDownButton *countBtn) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NNHApiSecurityTool *apiTool = [[NNHApiSecurityTool alloc] initWithMobile:![NSString isEmptyString:_currentPhoneNumber] ? _currentPhoneNumber : weakself.phoneField.text verifyCodeType:weakself.type];

                [apiTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
                    [countBtn startCounting];
                    [SVProgressHUD showMessage:@"获取验证码成功 请注意查收"];
                } failBlock:^(NNHRequestError *error) {
                    [countBtn resetButton];
                } isCached:NO];
            });
        }];
        _codeButton.bgNormalColor = _codeButton.bgCountingColor = [UIConfigManager colorThemeRed];
        _codeButton.lbNormalColor = _codeButton.lbCountingColor = [UIConfigManager colorThemeWhite];
        _codeButton.layer.cornerRadius = 2.5f;
        _codeButton.layer.masksToBounds = YES;
        _codeButton.enabled = NO;
    }
    return _codeButton;
}


@end
