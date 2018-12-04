//
//  NNHSetUpPayPasswordViewController.m
//  NBTMill
//
//  Created by 来旭磊 on 2018/3/7.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNSetUpPayPasswordViewController.h"
#import "NNTextField.h"
#import "NNHApiSecurityTool.h"

@interface NNSetUpPayPasswordViewController ()

/** 第一次输入密码 */
@property (nonatomic, strong) NNTextField *payPasswordField;
/** 确认按钮 */
@property (nonatomic, strong) UIButton *ensureButton;
/** 从哪个页面跳转进来 */
@property (nonatomic, assign) NNHChangePayCodeFromType fromType;

@end

@implementation NNSetUpPayPasswordViewController

#pragma mark - Life Cycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"设置资金密码";
    
    [self setupChildView];
}

- (instancetype)initWithFromType:(NNHChangePayCodeFromType)fromType
{
    if (self = [super init]) {
        _fromType = fromType;
    }
    return self;
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    [self.view addSubview:self.payPasswordField];
    [self.payPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.right.equalTo(self.view).offset(-NNHMargin_15);
        make.height.equalTo(@44);
    }];
    
    [self.view addSubview:self.ensureButton];
    [self.ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payPasswordField.mas_bottom).offset(60);
        make.left.right.equalTo(self.payPasswordField);
        make.height.equalTo(self.payPasswordField);
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField
{
    self.ensureButton.enabled = textField.text.length == 6;
}

#pragma mark - Network Methods

#pragma mark - Target Methods
- (void)clickEnsureButton:(UIButton *)button
{
    NNHWeakSelf(self)
    
    BOOL isfirst = NO;
    if (self.fromType == NNHChangePayCodeFromType_FistChange) {
        isfirst = YES;
    }else {
        isfirst = NO;
    }
    
    NNHApiSecurityTool *userTool = [[NNHApiSecurityTool alloc] initWithSetupPaycode:self.payPasswordField.text isFirst:isfirst];
    
    [userTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [SVProgressHUD showMessage:@"设置成功"];
        NNHStrongSelf(self)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NNUserModel *userModel = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel;
            userModel.ispaypass = @"1";

            if (weakself.fromType == NNHChangePayCodeFromType_FistChange) {
                [strongself.navigationController popViewControllerAnimated:YES];
            }else {
                NSArray *array = weakself.navigationController.childViewControllers;
                if (array.count > 3) {
                    UIViewController *controller = array[array.count - 3];
                    [strongself.navigationController popToViewController:controller animated:YES];
                }else {
                    [strongself.navigationController popViewControllerAnimated:YES];
                }
            }

        });
    } failBlock:^(NNHRequestError *error) {

    } isCached:NO];
}

#pragma mark - Lazy Loads
- (NNTextField *)payPasswordField
{
    if (_payPasswordField == nil) {
        _payPasswordField = [[NNTextField alloc] init];
        _payPasswordField.placeholder = @"请输入6位数字资金密码";
        _payPasswordField.keyboardType = UIKeyboardTypeNumberPad;
        _payPasswordField.secureTextEntry = YES;
        [_payPasswordField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _payPasswordField.nn_maxLength = 6;
    }
    return _payPasswordField;
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

@end
