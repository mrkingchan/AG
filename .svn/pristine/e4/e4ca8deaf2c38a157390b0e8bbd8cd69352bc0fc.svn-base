//
//  NNCoinFundWithdrawViewController.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/4.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNCoinFundWithdrawViewController.h"
#import "NNMineFundtTransferAvailableView.h"
#import "NNHEnterPasswordView.h"
#import "NNCoinFundAddWalletAddressController.h"
#import "NNCoinFundWalletAddressListController.h"
#import "NNAPIBlockFundTool.h"
#import "NNVerifyPhoneViewController.h"
#import "NNSetUpPayPasswordViewController.h"

@interface NNCoinFundWithdrawViewController ()

/** 可用余额view */
@property (nonatomic, strong) NNMineFundtTransferAvailableView *availableView;
/** 地址view*/
@property (nonatomic, strong) UIView *addressView;
/** 填写地址 */
@property (nonatomic, strong) UITextField *addressField;
/** 提币数量 */
@property (nonatomic, strong) UIView *countView;
/** 填写提币数量 */
@property (nonatomic, strong) UITextField *countField;
/** 确认按钮 */
@property (nonatomic, strong) UIButton *ensureButton;
/** 输入密码 */
@property (nonatomic, strong) NNHEnterPasswordView *enterView;
/** 手续费view */
@property (nonatomic, strong) UIView *feeView;
/** 手续费label */
@property (nonatomic, strong) UILabel *feeLabel;
/** 手续费说明 */
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation NNCoinFundWithdrawViewController

#pragma mark - Life Cycle Methods
- (void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"提取资产";
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightItemAction) title:@"添加地址"];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self setupChildView];
    
    //请求余额
    [self requestBalanceData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    [self.view addSubview:self.availableView];
    [self.availableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(NNHMargin_10);
        make.height.equalTo(@(NNHNormalViewH * 2));
    }];
    
    [self.view addSubview:self.addressView];
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.availableView.mas_bottom).offset(NNHLineH);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self.view addSubview:self.countView];
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.addressView.mas_bottom).offset(NNHLineH);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self.view addSubview:self.feeView];
    [self.feeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.countView.mas_bottom).offset(NNHLineH);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self.view addSubview:self.ensureButton];
    [self.ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.right.equalTo(self.view).offset(-NNHMargin_15);
        make.top.equalTo(self.feeView.mas_bottom).offset(60);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self.view addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ensureButton);
        make.top.equalTo(self.feeView.mas_bottom).offset(NNHMargin_10);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
    }];
}

- (void)rightItemAction
{
    NNCoinFundAddWalletAddressController *addAddressVC = [[NNCoinFundAddWalletAddressController alloc] init];
    [self.navigationController pushViewController:addAddressVC animated:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField
{
    self.ensureButton.enabled = self.addressField.hasText && self.countField.hasText;
}

#pragma mark - Network Methods
/** 请求可用余额数据 */
- (void)requestBalanceData
{
    self.addressField.text = @"";
    self.countField.text = @"";
    
    NNHWeakSelf(self)
    NNAPIBlockFundTool *fundTool = [[NNAPIBlockFundTool alloc] initFundDetailInfoWithFundType:NNFundBanlanceType_withdrawFund];
    [fundTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [weakself.availableView configCoinName:responseDic[@"data"][@"abb"] count:responseDic[@"data"][@"amount"]];
        weakself.feeLabel.text = responseDic[@"data"][@"zcfee_str"];
        weakself.contentLabel.text = responseDic[@"data"][@"content"];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
    
}

#pragma mark - Target Methods

- (void)selectAddressAction
{
    NNCoinFundWalletAddressListController *addressVC = [[NNCoinFundWalletAddressListController alloc] init];
    [self.navigationController pushViewController:addressVC animated:YES];
    NNHWeakSelf(self)
    addressVC.selectAddressBlock = ^(NSString *address) {
        weakself.addressField.text = address;
    };
}

- (void)clickEnsureButton:(UIButton *)button
{
    if (![NNHApplicationHelper sharedInstance].isRealName) return;
    
    [self.enterView showInFatherView:self.view];
}

/** 输入交易密码 */
- (void)inputPayCode:(NSString *)paycode
{
    NNHLog(@"paycode = %@",paycode);
    NNHWeakSelf(self)
    NNAPIBlockFundTool *fundTool = [[NNAPIBlockFundTool alloc] initBlockFundCoinWithdrawWithAddress:self.addressField.text coinamount:self.countField.text paypwd:paycode];
    [fundTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [weakself.enterView dissmissWithCompletion:nil];
        [SVProgressHUD showMessage:@"提现成功"];
        [weakself requestBalanceData];
    } failBlock:^(NNHRequestError *error) {
        [weakself.enterView resetStatus];
    } isCached:NO];
}

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Lazy Loads

- (NNMineFundtTransferAvailableView *)availableView
{
    if (_availableView == nil) {
        _availableView = [[NNMineFundtTransferAvailableView alloc] init];
    }
    return _availableView;
}

- (UIView *)addressView
{
    if (_addressView == nil) {
        _addressView = [[UIView alloc] init];
        _addressView.backgroundColor = [UIConfigManager colorThemeWhite];
        _addressView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAddressAction)];
        [_addressView addGestureRecognizer:tap];
        
        UILabel *titleLabel = [UILabel NNHWithTitle:@"提资产地址" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
        [_addressView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_addressView).offset(NNHMargin_15);
            make.centerY.equalTo(_addressView);
            make.width.equalTo(@(70));
        }];
        
        UIButton *addressButton = [UIButton NNHBtnImage:@"mine_order_arrow" target:self action:@selector(selectAddressAction)];
        addressButton.userInteractionEnabled = NO;
        [_addressView addSubview:addressButton];
        [addressButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_addressView);
            make.width.equalTo(@(NNHNormalViewH));
            make.right.equalTo(_addressView);
        }];
        
        [_addressView addSubview:self.addressField];
        [self.addressField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right);
            make.centerY.equalTo(_addressView);
            make.width.equalTo(@(SCREEN_WIDTH - 140));
            make.height.equalTo(_addressView.mas_height);
        }];
    }
    return _addressView;
}

- (UITextField *)addressField
{
    if (_addressField== nil) {
        _addressField = [[UITextField alloc] init];
        _addressField.font = [UIConfigManager fontThemeTextDefault];
        _addressField.placeholder = @"";
        _addressField.userInteractionEnabled = NO;
        [_addressField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _addressField;
}

- (UIView *)countView
{
    if (_countView == nil) {
        _countView = [[UIView alloc] init];
        _countView.backgroundColor = [UIConfigManager colorThemeWhite];
        
        UILabel *titleLabel = [UILabel NNHWithTitle:@"提资产数量" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
        [_countView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_countView).offset(NNHMargin_15);
            make.centerY.equalTo(_countView);
            make.width.equalTo(@(70));
        }];
        
        [_countView addSubview:self.countField];
        [self.countField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right);
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
        _countField.placeholder = @"请输入提资产数量";
        _countField.keyboardType = UIKeyboardTypeDecimalPad;
        [_countField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _countField;
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

- (UIView *)feeView
{
    if (_feeView == nil) {
        _feeView = [[UIView alloc] init];
        _feeView.backgroundColor = [UIConfigManager colorThemeWhite];
        
        UILabel *titleLabel = [UILabel NNHWithTitle:@"手续费" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
        [_feeView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_feeView).offset(NNHMargin_15);
            make.centerY.equalTo(_feeView);
            make.width.equalTo(@(70));
        }];
        
        [_feeView addSubview:self.feeLabel];
        [self.feeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right);
            make.centerY.equalTo(_feeView);
        }];
        
    }
    return _feeView;
}

- (UILabel *)feeLabel
{
    if (_feeLabel == nil) {
        _feeLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _feeLabel;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [UILabel NNHWithTitle:@"" titleColor:[UIColor redColor] font:[UIConfigManager fontThemeTextTip]];
        _contentLabel.numberOfLines = 2;
    }
    return _contentLabel;
}

@end
