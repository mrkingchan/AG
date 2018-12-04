//
//  NNHSetUpLoginPasswordViewController.m
//  NBTMill
//
//  Created by 来旭磊 on 2018/3/7.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNSetUpLoginPasswordViewController.h"
#import "NNHApiSecurityTool.h"
#import "NNHAlertTool.h"
#import "UIWindow+NNExtension.h"

@interface NNSetUpLoginPasswordViewController ()

/** 第一次输入密码 */
@property (nonatomic, strong) UITextField *firstField;
/** 第二次输入密码 */
@property (nonatomic, strong) UITextField *secondField;
/** 确认按钮 */
@property (nonatomic, strong) UIButton *ensureButton;
/** 取消按钮 */
@property (nonatomic, strong) UIButton *cancleButton;

@end

@implementation NNSetUpLoginPasswordViewController
{
    BOOL _registeredSetUp;
}

#pragma mark - Life Cycle Methods
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (instancetype)initWithRegisteredSetUp:(BOOL)registeredSetUp
{
    if (self = [super init]) {
        _registeredSetUp = registeredSetUp;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backAction) image:@"ic_nav_back" highImage:@"ic_nav_back"];
    self.navigationItem.title = @"设置登录密码";
    
    [self setupChildView];
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIConfigManager colorThemeWhite];
    [self.view addSubview:topView];
    topView.layer.cornerRadius = NNHMargin_5;
    topView.layer.masksToBounds = YES;
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.right.equalTo(self.view).offset(-NNHMargin_15);
        make.top.equalTo(self.view).offset(50);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [topView addSubview:self.firstField];
    [self.firstField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(topView);
        make.left.equalTo(topView).offset(NNHMargin_15);
        make.right.equalTo(topView).offset(-NNHMargin_15);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIConfigManager colorThemeWhite];
    [self.view addSubview:bottomView];
    bottomView.layer.cornerRadius = NNHMargin_5;
    bottomView.layer.masksToBounds = YES;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.right.equalTo(self.view).offset(-NNHMargin_15);
        make.top.equalTo(topView.mas_bottom).offset(NNHMargin_15);
        make.height.equalTo(@(NNHNormalViewH));
    }];

    [bottomView addSubview:self.secondField];
    [self.secondField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bottomView);
        make.left.equalTo(bottomView).offset(NNHMargin_15);
        make.right.equalTo(bottomView).offset(-NNHMargin_15);
    }];
    
    if (_registeredSetUp) {
        [self.view addSubview:self.ensureButton];
        [self.ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topView);
            make.height.equalTo(@(NNHNormalViewH));
            make.top.equalTo(bottomView.mas_bottom).offset(60);
            make.right.equalTo(self.view.mas_centerX).offset(-7.5f);
        }];
        
        [self.view addSubview:self.cancleButton];
        [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(topView);
            make.height.equalTo(@(NNHNormalViewH));
            make.centerY.equalTo(self.ensureButton);
            make.left.equalTo(self.view.mas_centerX).offset(7.5f);
        }];
    }else{
        [self.view addSubview:self.ensureButton];
        [self.ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(NNHMargin_15);
            make.right.equalTo(self.view).offset(-NNHMargin_15);
            make.top.equalTo(bottomView.mas_bottom).offset(60);
            make.height.equalTo(@(NNHNormalViewH));
        }];
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField
{
    self.ensureButton.enabled = self.firstField.hasText && self.secondField.hasText;
}

#pragma mark - Target Methods
- (void)backAction
{
    if (_registeredSetUp) {
        [self cancleButtonAction];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)cancleButtonAction
{
    [[NNHAlertTool shareAlertTool] showAlertView:self title:@"确定现在放弃设置密码？" message:@"可在设置中心设置登录密码" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
        [[UIApplication sharedApplication].keyWindow loadRootViewController];
    } cancle:^{
        
    }];
}

- (void)clickEnsureButton:(UIButton *)button
{
    NNHApiSecurityTool *userTool = [[NNHApiSecurityTool alloc] initUpdatePwdWithMobile:self.mobile encrypt:self.encrypt pwd:self.firstField.text confirmpwd:self.secondField.text];
    
    if (self.isFirstSetUpPassword) {
        userTool = [[NNHApiSecurityTool alloc] initSetUpPasswordWithPassword:self.firstField.text confirmpwd:self.secondField.text];
    }
    
    NNHWeakSelf(self)
    [userTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [SVProgressHUD showMessage:@"设置成功"];
        if (weakself.isFirstSetUpPassword) {
            [[UIApplication sharedApplication].keyWindow loadRootViewController];
        }else{          
            NSArray *array = weakself.navigationController.childViewControllers;
            if (array.count > 3) {
                UIViewController *controller = array[array.count - 3];
                [weakself.navigationController popToViewController:controller animated:YES];
            }else {
                [weakself.navigationController popViewControllerAnimated:YES];
            }
        }
    } failBlock:^(NNHRequestError *error) {

    } isCached:NO];
}

#pragma mark - Lazy Loads
- (UITextField *)firstField
{
    if (_firstField == nil) {
        _firstField = [[UITextField alloc] init];
        _firstField.font = [UIConfigManager fontThemeTextDefault];
        _firstField.placeholder = @"请输入登录密码";
        [_firstField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _firstField.secureTextEntry = YES;
    }
    return _firstField;
}

- (UITextField *)secondField
{
    if (_secondField == nil) {
        _secondField = [[UITextField alloc] init];
        _secondField.font = [UIConfigManager fontThemeTextDefault];
        _secondField.placeholder = @"请再次输入登录密码";
        [_secondField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _secondField.secureTextEntry = YES;
    }
    return _secondField;
}

- (UIButton *)ensureButton
{
    if (_ensureButton == nil) {
        _ensureButton = [UIButton NNHOperationBtnWithTitle:@"确定" target:self action:@selector(clickEnsureButton:) operationButtonType:NNHOperationButtonTypeBlue isAddCornerRadius:YES];
        _ensureButton.nn_acceptEventInterval = NNHAcceptEventInterval;
        _ensureButton.enabled = NO;
    }
    return _ensureButton;
}

- (UIButton *)cancleButton
{
    if (_cancleButton == nil) {
        _cancleButton = [UIButton NNHOperationBtnWithTitle:@"以后再说" target:self action:@selector(cancleButtonAction) operationButtonType:NNHOperationButtonTypeGrey isAddCornerRadius:YES];
    }
    return _cancleButton;
}

@end
