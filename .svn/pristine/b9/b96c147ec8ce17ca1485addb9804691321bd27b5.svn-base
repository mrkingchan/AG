//
//  NNCoinFundAddWalletAddressController.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/12.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNCoinFundAddWalletAddressController.h"
#import "NNHScanCodeController.h"
#import "NNAPIBlockFundTool.h"

@interface NNCoinFundAddWalletAddressController ()

/** 地址view */
@property (nonatomic, strong) UIView *addressView;
/** 填写地址 */
@property (nonatomic, strong) UITextField *addressField;

/** 账户view */
@property (nonatomic, strong) UIView *accountView;
/** 填写账户 */
@property (nonatomic, strong) UITextField *accountField;

/** 添加按钮 */
@property (nonatomic, strong) UIButton *addButton;
@end

@implementation NNCoinFundAddWalletAddressController

#pragma mark - Life Cycle Methods
- (void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"添加地址";
    
    [self setupChildView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    [self.view addSubview:self.accountView];
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(NNHMargin_10);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self.view addSubview:self.addressView];
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.accountView.mas_bottom).offset(NNHLineH);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self.view addSubview:self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.right.equalTo(self.view).offset(-NNHMargin_15);
        make.top.equalTo(self.addressView.mas_bottom).offset(44);
        make.height.equalTo(@(NNHNormalViewH));
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField
{
    self.addButton.enabled = self.accountField.hasText && self.addressField.hasText;
}

#pragma mark - Network Methods
/** 添加钱包地址 */
- (void)requestAddNewWalletAddressData
{
    NNHWeakSelf(self)
    NNAPIBlockFundTool *blockTool = [[NNAPIBlockFundTool alloc] initAddWalletAddrrssWithRemark:self.accountField.text address:self.addressField.text];
    [blockTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [SVProgressHUD showMessage:@"添加成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself.navigationController popViewControllerAnimated:YES];
        });
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

#pragma mark - Target Methods

- (void)clickAddButton
{
    [self requestAddNewWalletAddressData];
}

- (void)codeButtonAction
{
    NNHScanCodeController *scanVc = [[NNHScanCodeController alloc] init];
    [self.navigationController pushViewController:scanVc animated:YES];
    NNHWeakSelf(self)
    scanVc.getQrCodeBlock = ^(NSString *code) {
        weakself.addressField.text = code;
    };
}

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Lazy Loads

- (UIView *)accountView
{
    if (_accountView == nil) {
        _accountView = [[UIView alloc] init];
        _accountView.backgroundColor = [UIConfigManager colorThemeWhite];
        UILabel *titleLabel = [UILabel NNHWithTitle:@"钱包备注" titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextDefault]];
        [_accountView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_accountView).offset(NNHMargin_15);
            make.centerY.equalTo(_accountView);
        }];
    
        [_accountView addSubview:self.accountField];
        [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(NNHMargin_10);
            make.centerY.equalTo(_accountView);
            make.width.equalTo(@(SCREEN_WIDTH - 80));
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
        _accountField.placeholder = @"";
        [_accountField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _accountField;
}

- (UIView *)addressView
{
    if (_addressView == nil) {
        _addressView = [[UIView alloc] init];
        _addressView.backgroundColor = [UIConfigManager colorThemeWhite];
        
        UILabel *titleLabel = [UILabel NNHWithTitle:@"添加地址" titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextDefault]];
        [_addressView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_addressView).offset(NNHMargin_15);
            make.centerY.equalTo(_addressView);
        }];
        
        UIButton *codeButton = [UIButton NNHBtnImage:@"ic_scan" target:self action:@selector(codeButtonAction)];
        [_addressView addSubview:codeButton];
        [codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_addressView);
            make.width.equalTo(@(NNHNormalViewH));
            make.right.equalTo(_addressView).offset(-NNHMargin_5);
        }];
        
        [_addressView addSubview:self.addressField];
        [self.addressField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(NNHMargin_10);
            make.centerY.equalTo(_addressView);
            make.width.equalTo(@(SCREEN_WIDTH - 130));
            make.height.equalTo(_addressView.mas_height);
        }];
    }
    return _addressView;
}

- (UITextField *)addressField
{
    if (_addressField == nil) {
        _addressField = [[UITextField alloc] init];
        _addressField.font = [UIConfigManager fontThemeTextDefault];
        _addressField.placeholder = @"";
        _addressField.keyboardType = UIKeyboardTypeEmailAddress;
        [_addressField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _addressField;
}

- (UIButton *)addButton
{
    if (_addButton == nil) {
        _addButton = [UIButton NNHOperationBtnWithTitle:@"添加钱包地址" target:self action:@selector(clickAddButton) operationButtonType:NNHOperationButtonTypeBlue isAddCornerRadius:YES];
        _addButton.enabled = NO;
        _addButton.nn_acceptEventInterval = 1;
    }
    return _addButton;
}


@end
