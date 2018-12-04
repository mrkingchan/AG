//
//  NNConsumerTradeDetailViewController.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/21.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNConsumerTradeDetailViewController.h"
#import "NNConsumerTradeDetailTitleTipView.h"
#import "NNConsumerTradeDetailOrderInfoView.h"
#import "NNConsumerTradeDetailOrderPayMessageView.h"
#import "NNHCustomerTradeOrderOperationHelper.h"
#import "NNHAPIConsumerTradeTool.h"
#import "NNConsumerTradeAppealViewController.h"

@interface NNConsumerTradeDetailViewController ()

/** 交易类型 */
@property (nonatomic, assign) NNConsumerTradeType tradeType;
/** 顶部提示view */
@property (nonatomic, strong) NNConsumerTradeDetailTitleTipView *titleTipView;
/** 订单信息 */
@property (nonatomic, strong) NNConsumerTradeDetailOrderInfoView *orderInfoView;
/** 支付信息 */
@property (nonatomic, strong) NNConsumerTradeDetailOrderPayMessageView *payMessageView;
/** 订单数据 */
@property (nonatomic, strong) NNConsumerOrderDetailModel *orderModel;
/** scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 确认按钮 */
@property (nonatomic, strong) UIButton *confirmButton;
/** 申诉按钮 */
@property (nonatomic, strong) UIButton *appealButton;
/** 辅助类 */
@property (nonatomic, strong) NNHCustomerTradeOrderOperationHelper *operationHelper;
/** 保存支付方式 */
@property (nonatomic, strong) NNConsumerOrderDetailPayTypeModel *selectedPayModel;

@end

@implementation NNConsumerTradeDetailViewController

#pragma mark - Life Cycle Methods
- (void)dealloc
{
    NNHLog(@"-----%s-----",__func__);
}

- (instancetype)initWithOrderModel:(NNConsumerOrderDetailModel *)orderModel
{
    self = [super init];
    if (self) {
        _orderModel = orderModel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightItemAction) title:@"联系对方"];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.title = @"订单详情";
    
    [self setupChildView];
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [scrollView addSubview:self.titleTipView];
    [scrollView addSubview:self.orderInfoView];
    [scrollView addSubview:self.payMessageView];
    
    [self.payMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView);
        make.top.equalTo(self.orderInfoView.mas_bottom).offset(NNHMargin_10);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    [scrollView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payMessageView.mas_bottom).offset(40);
        make.left.equalTo(scrollView).offset(NNHMargin_15);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    
    [scrollView addSubview:self.appealButton];
    [self.appealButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.confirmButton);
        make.top.equalTo(self.confirmButton.mas_bottom);
        make.height.equalTo(@(30));
        make.width.equalTo(@(80));
        make.bottom.equalTo(scrollView).offset(-NNHNormalViewH * 2);
    }];
    
    [scrollView setNeedsLayout];
    [scrollView layoutIfNeeded];
    
    CGFloat height = CGRectGetMaxY(self.confirmButton.frame) + NNHNormalViewH * 2;
    
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, height);
    
    [self configViewData];
}

#pragma mark - Network Methods

- (void)reloadOrderDatailData
{
    NNHWeakSelf(self)
    NNHAPIConsumerTradeTool *tradeTool = [[NNHAPIConsumerTradeTool alloc] initWithTradeInfoDatailDataWithTradeID:self.orderModel.tradeid];
    [tradeTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        weakself.orderModel = [NNConsumerOrderDetailModel mj_objectWithKeyValues:responseDic[@"data"]];
        
        [weakself configViewData];
        
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (void)loadNetworkData
{
    [self reloadOrderDatailData];
}

/**  */
- (void)configViewData
{
    if (self.selectedPayModel) {
        self.orderModel.selectedPaytypeModel = self.selectedPayModel;
    }

    self.titleTipView.message = self.orderModel.warning;
    self.orderInfoView.orderModel = self.orderModel;
    self.payMessageView.orderModel = self.orderModel;
    
    if (self.orderModel.warning.length) {
        self.titleTipView.hidden = NO;
        [self.orderInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleTipView.mas_bottom).offset(NNHMargin_10);
            make.left.equalTo(self.view);
            make.width.equalTo(@(SCREEN_WIDTH));
        }];
    }else {
        self.titleTipView.hidden = YES;
        [self.orderInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.view);
            make.width.equalTo(@(SCREEN_WIDTH));
        }];
    }
    
    //未成交
    if (self.orderModel.payTypeArray.count == 0) {
        self.payMessageView.hidden = YES;
        [self.confirmButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderInfoView.mas_bottom).offset(40);
            make.left.equalTo(self.scrollView).offset(NNHMargin_15);
            make.width.equalTo(@(SCREEN_WIDTH - 30));
            make.height.equalTo(@(NNHNormalViewH));
        }];
    }else {
        self.payMessageView.hidden = NO;
        [self.confirmButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.payMessageView.mas_bottom).offset(40);
            make.left.equalTo(self.scrollView).offset(NNHMargin_15);
            make.width.equalTo(@(SCREEN_WIDTH - 30));
            make.height.equalTo(@(NNHNormalViewH));
        }];
    }
    
    if (self.orderModel.orderstatus.actstr.length) {
        self.confirmButton.hidden = NO;
        
        [self.confirmButton setTitle:self.orderModel.orderstatus.actstr forState:UIControlStateNormal];
    }else {
        self.confirmButton.hidden = YES;
    }
    
    self.appealButton.hidden = ![self.orderModel.isexplain isEqualToString:@"1"];
        
    if (self.confirmButton.hidden) {
        
        
        if (self.payMessageView.hidden) {
            [self.appealButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.view).offset(-NNHMargin_15);
                make.top.equalTo(self.orderInfoView.mas_bottom).offset(NNHMargin_10);
                make.height.equalTo(@(30));
                make.width.equalTo(@(80));
                make.bottom.equalTo(self.scrollView).offset(-NNHNormalViewH * 2);
            }];
        }else {
            [self.appealButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.view).offset(-NNHMargin_15);
                make.top.equalTo(self.payMessageView.mas_bottom).offset(NNHMargin_10);
                make.height.equalTo(@(30));
                make.width.equalTo(@(80));
                make.bottom.equalTo(self.scrollView).offset(-NNHNormalViewH * 2);
            }];
        }

    }else {
        [self.appealButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.confirmButton);
            make.top.equalTo(self.confirmButton.mas_bottom);
            make.height.equalTo(@(30));
            make.width.equalTo(@(80));
            make.bottom.equalTo(self.scrollView).offset(-NNHNormalViewH * 2);
        }];
    }
}

#pragma mark - Target Methods
- (void)clickConfirmButton:(UIButton *)button
{
    [self.operationHelper orderDetailOperationWithOrderDetailModel:self.orderModel];
}

- (void)rightItemAction
{
    [self.operationHelper callConsumerWithMobile:self.orderModel.trademobile];
}

- (void)appealButtonAction
{
    NNConsumerTradeAppealViewController *appealVC = [[NNConsumerTradeAppealViewController alloc] initWithOrderID:self.orderModel.tradeid];
    [self.navigationController pushViewController:appealVC animated:NO];
    NNHWeakSelf(self)
    appealVC.reloadDataBlock = ^{
        [weakself reloadOrderDatailData];
    };
}

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Lazy Loads

- (NNConsumerTradeDetailTitleTipView *)titleTipView
{
    if (_titleTipView == nil) {
        _titleTipView = [[NNConsumerTradeDetailTitleTipView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    }
    return _titleTipView;
}

- (NNConsumerTradeDetailOrderInfoView *)orderInfoView
{
    if (_orderInfoView == nil) {
        _orderInfoView = [[NNConsumerTradeDetailOrderInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleTipView.frame) + 10, SCREEN_WIDTH, 40)];
    }
    return _orderInfoView;
}

- (NNConsumerTradeDetailOrderPayMessageView *)payMessageView
{
    if (_payMessageView == nil) {
        _payMessageView = [[NNConsumerTradeDetailOrderPayMessageView alloc] init];
        NNHWeakSelf(self)
        _payMessageView.voucherActionBlock = ^(UIImageView *imageView) {
            [weakself.operationHelper uploadTradeVoucherWithOrderDetailModel:weakself.orderModel fromImageView:imageView];
        };
        _payMessageView.uploadAgainActionBlock = ^{
            [weakself.operationHelper uploadNewTradeVoucherImageWithOrderDetailModel:weakself.orderModel];
        };
        
        _payMessageView.changedPaytypeBlock = ^(NNConsumerOrderDetailPayTypeModel *payModel) {
            weakself.selectedPayModel = payModel;
        };
    }
    return _payMessageView;
}

- (UIButton *)confirmButton
{
    if (_confirmButton == nil) {
        _confirmButton = [UIButton NNHOperationBtnWithTitle:@"确认付款" target:self action:@selector(clickConfirmButton:) operationButtonType:NNHOperationButtonTypeBlue isAddCornerRadius:YES];
        _confirmButton.nn_acceptEventInterval = 1;
    }
    return _confirmButton;
}

- (UIButton *)appealButton
{
    if (_appealButton == nil) {
        _appealButton = [UIButton NNHBtnTitle:@"我要申诉" titileFont:[UIConfigManager fontThemeTextTip] backGround:[UIColor clearColor] titleColor:[UIConfigManager colorThemeRed]];
        [_appealButton addTarget:self action:@selector(appealButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _appealButton;
}

- (NNHCustomerTradeOrderOperationHelper *)operationHelper
{
    if (_operationHelper == nil) {
        _operationHelper = [[NNHCustomerTradeOrderOperationHelper alloc] init];
        _operationHelper.currentViewController = self;
        NNHWeakSelf(self)
        _operationHelper.reloadDataBlock = ^{
            [weakself reloadOrderDatailData];
        };
    }
    return _operationHelper;
}


@end
