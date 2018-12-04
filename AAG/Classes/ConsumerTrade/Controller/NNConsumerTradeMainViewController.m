//
//  NNConsumerTradeMainViewController.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/15.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNConsumerTradeMainViewController.h"
#import "NNPageContentView.h"
#import "NNHPageTitleView.h"
#import "NNAPIBlockFundTool.h"

#import "NNHConsumerCurrentEntrustViewController.h"
#import "NNHConsumerHistoryEntrustViewController.h"
#import "NNConsumerReleaseOrderViewController.h"
#import "NNCoinChartViewController.h"
#import "NNConsumerMatchOrderViewController.h"
#import "NNWebViewController.h"
#import "NNConsumerTradeTitleAmountView.h"
#import "NNTransferTradingViewController.h"
#import "NNTransferWFCCWalletViewController.h"

@interface NNConsumerTradeMainViewController ()<NNHPageTitleViewDelegate, NNHPageContentViewDelegare>

/**  包含控制前视图 */
@property (nonatomic, strong) NNPageContentView *pageContentView;
/** 头部菜单 */
@property (nonatomic, strong) NNHPageTitleView *pageTitleView;
@property (nonatomic, strong) NNConsumerTradeTitleAmountView *titleAmountView;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataSource;
/** 保存控制器的数组 */
@property (nonatomic, strong) NSMutableArray *controllerArray;
/** 当前页面 */
@property (nonatomic, assign) NSInteger selectedIndex;
/** 操作说明按钮 */
@property (nonatomic, strong) UIButton *explainButton;

@end

@implementation NNConsumerTradeMainViewController


#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"AAG交易区";
    [self setupChildView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.explainButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // 获取交易钱包余额
    [self requestTradingBalanceDataSource];
    
    NNBaseViewController *vc = self.controllerArray[self.selectedIndex];
    [vc loadNetworkData];
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    // 交易余额
    [self.view addSubview:self.titleAmountView];
    [self.titleAmountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(50));
    }];
    
    NSArray *titleArray = @[@"行情", @"交易", @"当前委托", @"历史记录"];
    self.pageTitleView = [NNHPageTitleView pageTitleViewWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, NNHNormalViewH) delegate:self titleNames:titleArray];
    self.pageTitleView.indicatorStyle = NNHIndicatorTypeEqual;
    self.pageTitleView.backgroundColor = [UIConfigManager colorThemeWhite];
    self.pageTitleView.titleColorStateNormal = [UIConfigManager colorThemeBlack];
    self.pageTitleView.titleColorStateSelected = [UIConfigManager colorThemeRed];
    self.pageTitleView.indicatorColor = [UIConfigManager colorThemeRed];
    [self.view addSubview:self.pageTitleView];
    
    // k线图
    NNCoinChartViewController *buyVC = [[NNCoinChartViewController alloc] init];
    [self.controllerArray addObject:buyVC];
    
    // 买入卖出撮合页面
    NNConsumerMatchOrderViewController *sellVC = [[NNConsumerMatchOrderViewController alloc] init];
    [self.controllerArray addObject:sellVC];
    
    // 当前委托
    NNHConsumerCurrentEntrustViewController *entrustVC = [[NNHConsumerCurrentEntrustViewController alloc] init];
    [self.controllerArray addObject:entrustVC];
    
    // 历史委托
    NNHConsumerHistoryEntrustViewController *historyVC = [[NNHConsumerHistoryEntrustViewController alloc] init];
    [self.controllerArray addObject:historyVC];
    
    CGFloat contentViewHeight = self.view.nnh_height - self.pageTitleView.nnh_height - 60 - 49 - (NNHNavBarViewHeight) - (NNHBottomSafeHeight);
    self.pageContentView = [[NNPageContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pageTitleView.frame), self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:self.controllerArray];
    self.pageContentView.pageContentViewDelegate = self;
    self.pageContentView.scrollEnabled = NO;
    [self.view addSubview:self.pageContentView];
    
    // 操作说明
    [self.view addSubview:self.explainButton];
    [self.explainButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(54, 44));
        make.right.equalTo(self.view).offset(-15);
        make.bottom.equalTo(self.view).offset(-30);
    }];
    
    NNHWeakSelf(self)
    NNHWeakSelf(sellVC)
    buyVC.operationActionBlock = ^(NSInteger index) {
        if (index == 0) {
            [weakself rightItemAction];
        }else {
            [weakself.pageTitleView setSelectedIndex:1];
            weaksellVC.selectedIndex = index - 1;
        }
    };
}

- (void)requestTradingBalanceDataSource
{
    NNHWeakSelf(self)
    NNAPIBlockFundTool *fundTool = [[NNAPIBlockFundTool alloc] initWalletTransferWithType:NNHWalletTransferTypeTradingLT];
    [fundTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        weakself.titleAmountView.balance = responseDic[@"data"][@"balance"];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

#pragma mark - NNHPageTitleViewDelegate
- (void)nnh_pageTitleView:(NNHPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex
{
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
    
    if (self.controllerArray.count == 4) {
        NNBaseViewController *childVC = self.controllerArray[selectedIndex];
        [childVC loadNetworkData];
    }
    
    self.selectedIndex = selectedIndex;
}

#pragma mark - NNHPageContentViewDelegare
- (void)nnh_pageContentView:(NNPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex
{
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

#pragma mark - Network Methods

#pragma mark - Target Methods
/** 点击操作说明 */
- (void)explainButtonAction
{
    NNUserModel *userModel = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel;
    NNWebViewController *webVC = [[NNWebViewController alloc] init];
    webVC.url = userModel.tradeoperurl;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)rightItemAction
{
    if (![NNHApplicationHelper sharedInstance].isRealName) return;
    NNConsumerReleaseOrderViewController *orderVC = [[NNConsumerReleaseOrderViewController alloc] init];
    [self.navigationController pushViewController:orderVC animated:YES];
}

#pragma mark - Lazy Loads
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)controllerArray
{
    if (_controllerArray == nil) {
        _controllerArray = [NSMutableArray array];
    }
    return _controllerArray;
}

- (UIButton *)explainButton
{
    if (_explainButton == nil) {
        _explainButton = [UIButton NNHBtnTitle:@"操作说明" titileFont:[UIConfigManager fontThemeTextDefault] backGround:[UIConfigManager colorThemeWhite] titleColor:[UIConfigManager colorThemeRed]];
        _explainButton.adjustsImageWhenHighlighted = NO;
        [_explainButton addTarget:self action:@selector(explainButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _explainButton.frame = CGRectMake(0, 0, 60, 30);
    }
    return _explainButton;
}

- (NNConsumerTradeTitleAmountView *)titleAmountView
{
    if (_titleAmountView == nil) {
        _titleAmountView = [[NNConsumerTradeTitleAmountView alloc] init];
        NNHWeakSelf(self)
        _titleAmountView.takeinActionBlock = ^{
            NNTransferTradingViewController *vc = [[NNTransferTradingViewController alloc] initWithTransferType:NNHWalletTransferTypeLTTrading];
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        _titleAmountView.takeoutActionBlock = ^{
            NNTransferWFCCWalletViewController *vc = [[NNTransferWFCCWalletViewController alloc] initWithTransferType:NNHWalletTransferTypeTradingWFCC];
            [weakself.navigationController pushViewController:vc animated:YES];
        };
    }
    return _titleAmountView;
}

@end
