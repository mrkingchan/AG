//
//  NNBalanceFundTranferToConsumeFundViewController.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/23.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNBalanceFundTranferToConsumeFundViewController.h"
#import "NNAPIBlockFundTransferTool.h"
#import "NNHEnterPasswordView.h"
#import "NNBalanceFundTranferRecordViewController.h"
#import "NNAPIBlockFundTool.h"
#import "NNVerifyPhoneViewController.h"
#import "NNSetUpPayPasswordViewController.h"

@interface NNBalanceFundTranferToConsumeFundViewController ()

/** 账户view */
@property (nonatomic, strong) UIView *accountView;
/** 提币数量 */
@property (nonatomic, strong) UIView *countView;
/** 填写提币数量 */
@property (nonatomic, strong) UITextField *countField;
/** 确认按钮 */
@property (nonatomic, strong) UIButton *ensureButton;
/** 输入密码 */
@property (nonatomic, strong) NNHEnterPasswordView *enterView;
/** 转出资产类型 */
@property (nonatomic, strong) UILabel *fundTypeLabel;
/** 资产类型 */
@property (nonatomic, copy) NSString *fundType;

/** 可用资产 */
@property (nonatomic, copy) NSString *balance;
/** 记账资产 */
@property (nonatomic, copy) NSString *blockBalance;

/** 显示可用余额 */
@property (nonatomic, strong) UILabel *availableAmountLabel;

@end

@implementation NNBalanceFundTranferToConsumeFundViewController

#pragma mark - Life Cycle Methods
- (void)dealloc
{
    
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
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightItemAction) title:@"记录"];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.accountView];
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(NNHMargin_10);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self.view addSubview:self.countView];
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.accountView.mas_bottom).offset(NNHLineH);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self.view addSubview:self.ensureButton];
    [self.ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.right.equalTo(self.view).offset(-NNHMargin_15);
        make.top.equalTo(self.countView.mas_bottom).offset(60);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self.view addSubview:self.availableAmountLabel];
    [self.availableAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ensureButton);
        make.top.equalTo(self.countView.mas_bottom).offset(NNHMargin_10);
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField
{
    self.ensureButton.enabled = self.countField.hasText && self.fundType.length;
}

#pragma mark - Network Methods
/** 请求可用余额数据 */
- (void)requestBalanceData
{
    NNHWeakSelf(self)
    NNAPIBlockFundTool *fundTool = [[NNAPIBlockFundTool alloc] initBlockFundBalance];
    [fundTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        weakself.balance = responseDic[@"data"][@"balance"];
        weakself.blockBalance = responseDic[@"data"][@"blockBalance"];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

#pragma mark - Target Methods
- (void)rightItemAction
{
    NNBalanceFundTranferRecordViewController *recordVC = [[NNBalanceFundTranferRecordViewController alloc]  init];
    [self.navigationController pushViewController:recordVC animated:YES];
}

/** 选择转账资产类型 */
- (void)selectedFundType
{
    NSArray *array = @[@"可用资产", @"记账资产"];
    NNHWeakSelf(self);
    [[NNHAlertTool shareAlertTool] showActionSheet:self title:nil message:nil acttionTitleArray:array confirm:^(NSInteger index) {
        
        weakself.fundTypeLabel.text = array[index];
        
        if (index == 0) {
            weakself.availableAmountLabel.text = [NSString stringWithFormat:@"可用：%@",weakself.balance];
            weakself.fundType = @"1";
        }else {
            weakself.availableAmountLabel.text = [NSString stringWithFormat:@"可用：%@",weakself.blockBalance];
            weakself.fundType = @"2";
        }
        
        weakself.ensureButton.enabled = weakself.countField.hasText && weakself.fundType.length;
        
    } cancle:^{
        
    }];
}

- (void)clickEnsureButton:(UIButton *)button
{
    if (![NNHApplicationHelper sharedInstance].isRealName) return;
    
    [self.enterView showInFatherView:self.view];
}

/** 输入交易密码 */
- (void)inputPayCode:(NSString *)paycode
{
    NNHWeakSelf(self)
    NNAPIBlockFundTransferTool *blockTool = [[NNAPIBlockFundTransferTool alloc] initBalanceFundTransferToConsumeFundWithNum:self.countField.text type:self.fundType paypwd:paycode];
    [blockTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [weakself.enterView dissmissWithCompletion:nil];
        [SVProgressHUD showMessage:@"转账成功"];
        [weakself.navigationController popViewControllerAnimated:YES];
    } failBlock:^(NNHRequestError *error) {
        [weakself.enterView resetStatus];
    } isCached:NO];
}

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Lazy Loads

- (UIView *)accountView
{
    if (_accountView == nil) {
        _accountView = [[UIView alloc] init];
        _accountView.backgroundColor = [UIConfigManager colorThemeWhite];
        _accountView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedFundType)];
        [_accountView addGestureRecognizer:tap];
        
        UILabel *titleLabel = [UILabel NNHWithTitle:@"转出资产" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
        [_accountView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_accountView).offset(NNHMargin_15);
            make.centerY.equalTo(_accountView);
        }];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:ImageName(@"mine_order_arrow")];
        [_accountView addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_accountView);
            make.right.equalTo(_accountView).offset(-15);
        }];
        
        [_accountView addSubview:self.fundTypeLabel];
        [self.fundTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(arrowImageView.mas_left).offset(-NNHMargin_10);
            make.centerY.equalTo(_accountView);
        }];
    
    }
    return _accountView;
}


- (UIView *)countView
{
    if (_countView == nil) {
        _countView = [[UIView alloc] init];
        _countView.backgroundColor = [UIConfigManager colorThemeWhite];
        
        UILabel *titleLabel = [UILabel NNHWithTitle:@"提出数量" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
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

- (UILabel *)fundTypeLabel
{
    if (_fundTypeLabel == nil) {
        _fundTypeLabel = [UILabel NNHWithTitle:@"请选择要转出的资产类型" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _fundTypeLabel;
}

- (UILabel *)availableAmountLabel
{
    if (_availableAmountLabel == nil) {
        _availableAmountLabel = [UILabel NNHWithTitle:@"" titleColor:[UIColor redColor] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _availableAmountLabel;
}



- (UITextField *)countField
{
    if (_countField == nil) {
        _countField = [[UITextField alloc] init];
        _countField.font = [UIConfigManager fontThemeTextDefault];
        _countField.placeholder = @"请输入转出数量";
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

@end
