//
//  NNSetPhoneViewController.m
//  YWL
//
//  Created by 牛牛 on 2018/7/16.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNSetPhoneViewController.h"
#import "NNTextField.h"
#import "NNCountDownButton.h"
#import "NNHApiSecurityTool.h"

@interface NNSetPhoneViewController ()

/** 确认按钮 */
@property (nonatomic, strong) UIButton *ensureButton;
/** 手机号码 */
@property (nonatomic, strong) NNTextField *phoneField;
/** 验证码 */
@property (nonatomic, strong) NNTextField *codeField;
/** 获取验证码 */
@property (nonatomic, strong) NNCountDownButton *codeButton;

@end

@implementation NNSetPhoneViewController
{
    NSString *_currentPhoneNumber;
}

#pragma mark - Life Cycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"修改手机";
    
    [self setupChildView];
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    [self.view addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@44);
    }];
    
    UIView *codeView = [[UIView alloc] init];
    codeView.backgroundColor = [UIConfigManager colorThemeWhite];
    [self.view addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.phoneField);
        make.top.equalTo(self.phoneField.mas_bottom).offset(15);
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
        make.right.equalTo(codeView).offset(-NNHMargin_10);
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
    self.codeButton.enabled = self.phoneField.text.length  > 5;
    self.ensureButton.enabled = self.phoneField.text.length  > 5 && self.codeField.hasText;
}

#pragma mark - Target Methods
- (void)clickEnsureButton:(UIButton *)button
{
    NNHWeakSelf(self)
    NNHApiSecurityTool *apiTool = [[NNHApiSecurityTool alloc] initUpdatePhoneWithMobile:self.phoneField.text valicode:self.codeField.text];
    [apiTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [SVProgressHUD showMessage:@"修改成功"];
        [weakself.navigationController popToRootViewControllerAnimated:YES];
    } failBlock:^(NNHRequestError *error) {

    } isCached:NO];
}

#pragma mark - Lazy Loads
- (NNTextField *)phoneField
{
    if (_phoneField == nil) {
        _phoneField = [[NNTextField alloc] init];
        _phoneField.placeholder = @"请输入您的手机号码";
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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
        _ensureButton = [UIButton NNHOperationBtnWithTitle:@"确定" target:self action:@selector(clickEnsureButton:) operationButtonType:NNHOperationButtonTypeBlue isAddCornerRadius:YES];
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
            NNHStrongSelf(self)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NNHApiSecurityTool *apiTool = [[NNHApiSecurityTool alloc] initWithMobile:strongself.phoneField.text verifyCodeType:NNHSendVerificationCodeType_updatePhone countryCode:nil];
                [apiTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
                    [countBtn startCounting];
                    [SVProgressHUD showMessage:@"获取验证码成功 请注意查收"];
                } failBlock:^(NNHRequestError *error) {
                    [countBtn resetButton];
                } isCached:NO];
            });
        }];
        _codeButton.layer.cornerRadius = 2.5f;
        _codeButton.layer.masksToBounds = YES;
        _codeButton.enabled = ![NSString isEmptyString:_currentPhoneNumber];
    }
    return _codeButton;
}

@end
