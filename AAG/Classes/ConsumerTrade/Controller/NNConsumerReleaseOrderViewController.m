//
//  NNConsumerReleaseOrderViewController.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/17.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#define myDotNumbers     @"0123456789.\n"
#define myNumbers          @"0123456789\n"

#import "NNConsumerReleaseOrderViewController.h"
#import "NNHPageTitleView.h"
#import "NNHAPIConsumerTradeTool.h"
#import "NNConsumerReleaseOrderPriceModel.h"
#import "NNHEnterPasswordView.h"
#import "NNVerifyPhoneViewController.h"
#import "NNSetUpPayPasswordViewController.h"
#import "NNHMyBankCardController.h"
#import "NNHAlertTool.h"

@interface NNConsumerReleaseOrderViewController ()<NNHPageTitleViewDelegate, UITextFieldDelegate>

/** 头部菜单 */
@property (nonatomic, strong) NNHPageTitleView *pageTitleView;
/** 当前币价 */
@property (nonatomic, copy) UILabel *currentPriceLabel;
/** 数量 */
@property (nonatomic, strong) UITextField *countField;
/** 单价 */
@property (nonatomic, strong) UITextField *priceField;
/** 总金额 */
@property (nonatomic, strong) UILabel *totalAmountLabel;
/** 确认按钮 */
@property (nonatomic, strong) UIButton *ensureButton;
/** 手续费 */
@property (nonatomic, strong) UILabel *feeLabel;
/** 保证金 */
@property (nonatomic, strong) UILabel *bailLabel;
/** 全部卖出按钮 */
@property (nonatomic, strong) UIButton *operationButton;
/** 价格模型 */
@property (nonatomic, strong) NNConsumerReleaseOrderPriceModel *priceModel;
/** 交易类型 */
@property (nonatomic, assign) NNConsumerTradeType tradeType;
/** 输入密码 */
@property (nonatomic, strong) NNHEnterPasswordView *enterView;
/** 交易提示 */
@property (nonatomic, weak) UILabel *tipLabel;

// 新增 奖励数量
/** 奖励数量标题 */
@property (nonatomic, weak) UILabel *feeTitleLabel;

@end

@implementation NNConsumerReleaseOrderViewController

#pragma mark - Life Cycle Methods
- (void)dealloc
{
    NNHLog(@"-----%s------",__func__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"发布交易单";
    
    [self setupChildView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestCurrentCoinData];
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    [self.view addSubview:self.pageTitleView];
    
    UIView *titlePriceView = [[UIView alloc] init];
    [self.view addSubview:titlePriceView];
    titlePriceView.backgroundColor = [UIConfigManager colorThemeWhite];
    [titlePriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.pageTitleView.mas_bottom).offset(NNHMargin_10);
        make.height.equalTo(@(60));
    }];
    
    UILabel *titleLabel = [UILabel NNHWithTitle:@"当前价" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextMain]];
    [titlePriceView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titlePriceView).offset(NNHMargin_15);
        make.centerY.equalTo(titlePriceView);
    }];
    
    [titlePriceView addSubview:self.currentPriceLabel];
    [self.currentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titlePriceView).offset(-NNHMargin_15);
        make.centerY.equalTo(titlePriceView);
    }];
    
    UIView *orderView = [[UIView alloc] init];
    orderView.backgroundColor = [UIConfigManager colorThemeWhite];
    [self.view addSubview:orderView];
    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titlePriceView.mas_bottom).offset(NNHMargin_10);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(NNHNormalViewH *4));
    }];
    
    NSArray *titleArray = @[@"价格", @"数量", @"金额", @"奖励数量"];
    for (int i = 0; i < titleArray.count; i ++) {
        UILabel *messageLabel = [UILabel NNHWithTitle:titleArray[i] titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextMain]];
        [orderView addSubview:messageLabel];
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(orderView).offset(NNHMargin_15);
            make.centerY.equalTo(orderView.mas_top).offset((i + 0.5)* NNHNormalViewH);
            make.width.equalTo(@(60));
        }];
        
        if (i == titleArray.count - 1) {
            self.feeTitleLabel = messageLabel;
        }

        if (i > 0) {
            UIView *lineView = [[UIView alloc] init];
            [orderView addSubview:lineView];
            lineView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(orderView);
                make.height.equalTo(@(NNHLineH));
                make.top.equalTo(orderView).offset(i * NNHNormalViewH);
            }];
        }
    }
    
    [orderView addSubview:self.priceField];
    [self.priceField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orderView).offset(80);
        make.top.equalTo(orderView);
        make.height.equalTo(@(NNHNormalViewH));
        make.width.equalTo(@(SCREEN_WIDTH  * 0.5));
    }];
    
    [orderView addSubview:self.countField];
    [self.countField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceField);
        make.top.equalTo(orderView).offset(NNHNormalViewH);
        make.height.equalTo(@(NNHNormalViewH));
        make.width.equalTo(@(SCREEN_WIDTH  * 0.5));
    }];
    
    [orderView addSubview:self.totalAmountLabel];
    [self.totalAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceField);
        make.centerY.equalTo(orderView.mas_bottom).offset(-NNHNormalViewH * 1.5);
        make.height.equalTo(@(30));
        make.right.equalTo(orderView).offset(NNHMargin_15);
    }];
    
    [orderView addSubview:self.feeLabel];
    [self.feeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceField);
        make.centerY.equalTo(orderView.mas_bottom).offset(-NNHNormalViewH * 0.5);
        make.height.equalTo(@(30));
        make.right.equalTo(orderView).offset(NNHMargin_15);
    }];
    
    [orderView addSubview:self.operationButton];
    [self.operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(orderView).offset(-NNHMargin_15);
        make.centerY.equalTo(orderView.mas_top).offset(NNHNormalViewH * 1.5);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    UILabel *tipLabel = [UILabel NNHWithTitle:@"注：手续费在可用余额中扣除" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextTip]];
    tipLabel.numberOfLines = 2;
    [self.view addSubview:tipLabel];
    _tipLabel = tipLabel;
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.right.equalTo(self.view).offset(-NNHMargin_15);
    }];
    
    [self.view addSubview:self.ensureButton];
    [self.ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
        make.top.equalTo(tipLabel.mas_bottom).offset(30);
        make.height.equalTo(@(NNHNormalViewH));
    }];

    [self.view addSubview:self.bailLabel];
    [self.bailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.ensureButton);
        make.top.equalTo(self.ensureButton.mas_bottom).offset(NNHMargin_10);
    }];
}

#pragma mark - Network Methods

- (void)requestCurrentCoinData
{
    NNHWeakSelf(self)
    NNHAPIConsumerTradeTool *tradeTool = [[NNHAPIConsumerTradeTool alloc] initOrderCoinData];
    [tradeTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        weakself.priceModel = [NNConsumerReleaseOrderPriceModel mj_objectWithKeyValues:responseDic[@"data"]];
        [weakself configPriceData];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (void)configPriceData
{
    self.currentPriceLabel.text = self.priceModel.lastPrice;
    self.priceField.text = self.priceModel.lastPrice;
    
    if (self.tradeType == NNConsumerTradeType_buy) {
        
        self.countField.placeholder = @"请输入您要买入的数量";
        
//        CGFloat feeFloat = [self.priceModel.fee_buy floatValue] * 100;
//        self.feeLabel.text = [NSString stringWithFormat:@"%.2f%%",feeFloat];
        
        self.bailLabel.hidden = NO;
        self.bailLabel.text = self.priceModel.sell_bail_str;
        self.operationButton.hidden = YES;
        self.tipLabel.text = self.priceModel.fee_buy_str;
        
    }else {

        self.countField.placeholder = self.priceModel.trade_max.length ? [NSString stringWithFormat:@"最大可卖%@",self.priceModel.trade_max] : @"请输入您要卖出的数量";
        
//        CGFloat feeFloat = [self.priceModel.fee_sell floatValue] * 100;
//        self.feeLabel.text = [NSString stringWithFormat:@"%.2f%%",feeFloat];
        
        self.bailLabel.hidden = YES;
        self.operationButton.hidden = self.priceModel.trade_max.length == 0;
        
        self.tipLabel.text = self.priceModel.fee_sell_str;
    }
    
    self.feeLabel.text = @"0.00";
}

#pragma mark - Target Methods

- (void)sellAllCoinAction
{
    self.countField.text = self.priceModel.trade_max;
    self.ensureButton.enabled = self.countField.hasText && self.priceField.hasText;
    [self calculateTotalAmount];
}

- (void)clickEnsureButton:(UIButton *)button
{
    NNUserModel *userModel = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel;
    if ([userModel.banknumber integerValue] > 0) {
        [self.enterView showInFatherView:self.view];
    }else {
        NNHWeakSelf(self)
        [[NNHAlertTool shareAlertTool] showAlertView:self title:@"请添加银行卡" message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
            NNHMyBankCardController *cardVC = [[NNHMyBankCardController alloc] init];
            [weakself.navigationController pushViewController:cardVC animated:YES];
        } cancle:^{
            
        }];
    }
}

/** 输入交易密码 */
- (void)inputPayCode:(NSString *)paycode
{
    NNHWeakSelf(self)
    NNHAPIConsumerTradeTool *tradeTool = [[NNHAPIConsumerTradeTool alloc] initReleaseOrderWithTradeType:self.tradeType paypassword:paycode price:self.priceField.text num:self.countField.text];
    [tradeTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [SVProgressHUD showMessage:@"下单成功"];
        [weakself.enterView dissmissWithCompletion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself.navigationController popViewControllerAnimated:YES];
        });
    } failBlock:^(NNHRequestError *error) {
        [weakself.enterView resetStatus];
    } isCached:NO];
}

/** 计算总的金额 */
- (void)calculateTotalAmount
{
    if (!self.countField.hasText || !self.priceField.hasText) {
        self.totalAmountLabel.text = @"0.00";
        return;
    };
    
    CGFloat priceFloat = [self.priceField.text floatValue];
    
    CGFloat countFloat = [self.countField.text floatValue];
    
    CGFloat totalAmount = priceFloat * countFloat;
    
    self.totalAmountLabel.text = [NSString stringWithFormat:@"%.2f",totalAmount];
}

/** 计算手续费 */
- (void)calculateFeeAmount
{
    if (self.countField.text.length) {
        
        CGFloat amount = [self.countField.text floatValue];
        
        if (self.tradeType == NNConsumerTradeType_buy) {
            
            CGFloat fee = [self.priceModel.fee_buy floatValue];
            
            
            CGFloat totalAmount = fee * amount;
            self.feeLabel.text = [NSString stringWithFormat:@"%.2f",totalAmount];
            
        }else {
            CGFloat fee = [self.priceModel.fee_sell floatValue];
            CGFloat totalAmount = fee * amount;
            self.feeLabel.text = [NSString stringWithFormat:@"%.2f",totalAmount];
        }
            
    }else {
        self.feeLabel.text = @"0.00";
//        if (self.tradeType == NNConsumerTradeType_buy) {
//            CGFloat feeFloat = [self.priceModel.fee_buy floatValue] * 100;
//            self.feeLabel.text = [NSString stringWithFormat:@"%.2f%%",feeFloat];
//        }else {
//            CGFloat feeFloat = [self.priceModel.fee_sell floatValue] * 100;
//            self.feeLabel.text = [NSString stringWithFormat:@"%.2f%%",feeFloat];
//        }
    }
}

#pragma mark - Public Methods

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField
{
    self.ensureButton.enabled = self.countField.hasText && self.priceField.hasText;
    
    [self calculateTotalAmount];
    
    if (textField == self.countField) {
        [self calculateFeeAmount];
    }
}

#pragma mark - NNHPageTitleViewDelegate
- (void)nnh_pageTitleView:(NNHPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex
{
    self.tradeType = selectedIndex;
    self.feeTitleLabel.text = selectedIndex == 0 ? @"奖励数量" : @"手续费";
    
    [self configPriceData];
    
    [self calculateTotalAmount];
    [self calculateFeeAmount];
}

#pragma mark - Lazy Loads
- (NNHPageTitleView *)pageTitleView
{
    if (_pageTitleView == nil) {
        _pageTitleView = [NNHPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NNHNormalViewH) delegate:self titleNames:@[@"挂单买入", @"挂单卖出"]];
        _pageTitleView.indicatorStyle = NNHIndicatorTypeEqual;
        _pageTitleView.backgroundColor = [UIConfigManager colorThemeWhite];
        _pageTitleView.titleColorStateNormal = [UIConfigManager colorThemeBlack];
        _pageTitleView.titleColorStateSelected = [UIConfigManager colorThemeRed];
        _pageTitleView.indicatorColor = [UIConfigManager colorThemeRed];
    }
    return _pageTitleView;
}

- (UILabel *)currentPriceLabel
{
    if (_currentPriceLabel == nil) {
        _currentPriceLabel = [UILabel NNHWithTitle:@"0.00" titleColor:[UIConfigManager colorThemeRed] font:[UIFont boldSystemFontOfSize:18]];
    }
    return _currentPriceLabel;
}

- (UITextField *)countField
{
    if (_countField == nil) {
        _countField = [[UITextField alloc] init];
        _countField.font = [UIConfigManager fontThemeTextDefault];
        _countField.placeholder = @"请输入您预期买入数量";
        _countField.keyboardType = UIKeyboardTypeDecimalPad;
        _countField.delegate = self;
        [_countField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _countField;
}

- (UITextField *)priceField
{
    if (_priceField == nil) {
        _priceField = [[UITextField alloc] init];
        _priceField.font = [UIConfigManager fontThemeTextDefault];
        _priceField.delegate = self;
        _priceField.keyboardType = UIKeyboardTypeDecimalPad;
        _priceField.enabled = NO;
        [_priceField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _priceField;
}

- (UILabel *)totalAmountLabel
{
    if (_totalAmountLabel == nil) {
        _totalAmountLabel = [UILabel NNHWithTitle:@"0.00" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _totalAmountLabel;
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

- (UILabel *)feeLabel
{
    if (_feeLabel == nil) {
        _feeLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _feeLabel;
}

- (UILabel *)bailLabel
{
    if (_bailLabel == nil) {
        _bailLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextTip]];
    }
    return _bailLabel;
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

- (UIButton *)operationButton
{
    if (_operationButton == nil) {
        _operationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _operationButton.titleLabel.font = [UIConfigManager fontThemeTextTip];
        _operationButton.layer.cornerRadius = NNHMargin_5 * 0.5;
        _operationButton.layer.masksToBounds = YES;
        [_operationButton setBackgroundColor:[UIConfigManager colorThemeWhite] forState:UIControlStateNormal];
        _operationButton.adjustsImageWhenHighlighted = NO;
        [_operationButton setTitleColor:[UIConfigManager colorThemeRed] forState:UIControlStateNormal];
        [_operationButton setTitle:@"全部卖出" forState:UIControlStateNormal];
        _operationButton.layer.borderWidth = NNHLineH;
        _operationButton.layer.borderColor = [UIConfigManager colorThemeRed].CGColor;
        [_operationButton addTarget:self action:@selector(sellAllCoinAction) forControlEvents:UIControlEventTouchUpInside];
        _operationButton.hidden = YES;
    }
    return _operationButton;
}

#pragma mark -
#pragma mark --------- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // 判断是否输入内容，或者用户点击的是键盘的删除按钮
    if (![string isEqualToString:@""]) {
        NSCharacterSet *cs;
        // 小数点在字符串中的位置 第一个数字从0位置开始
        NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
        // 判断字符串中是否有小数点，并且小数点不在第一位
        // NSNotFound 表示请求操作的某个内容或者item没有发现，或者不存在
        // range.location 表示的是当前输入的内容在整个字符串中的位置，位置编号从0开始
        if (dotLocation == NSNotFound && range.location != 0) {
            // 取只包含“myDotNumbers”中包含的内容，其余内容都被去掉
            /* [NSCharacterSet characterSetWithCharactersInString:myDotNumbers]的作用是去掉"myDotNumbers"中包含的所有内容，只要字符串中有内容与"myDotNumbers"中的部分内容相同都会被舍去在上述方法的末尾加上invertedSet就会使作用颠倒，只取与“myDotNumbers”中内容相同的字符
             */
            cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
            if (range.location >= 9) {
                NNHLog(@"单笔金额不能超过亿位");
                if ([string isEqualToString:@"."] && range.location == 9) {
                    return YES;
                }
                return NO;
            }
        }else {
            cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
        }
        // 按cs分离出数组,数组按@""分离出字符串
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if (!basicTest) {
            NNHLog(@"只能输入数字和小数点");
            return NO;
        }
        if (dotLocation != NSNotFound && range.location > dotLocation + 4) {
            NNHLog(@"小数点后最多两位");
            return NO;
        }
        if (textField.text.length > 11) {
            return NO;
        }
    }
    return YES;
}

@end
