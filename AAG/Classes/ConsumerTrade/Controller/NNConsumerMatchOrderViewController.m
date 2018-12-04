//
//  NNConsumerMatchOrderViewController.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/18.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNConsumerMatchOrderViewController.h"
#import "NNConsumerMatchOrderTableViewCell.h"
#import "NNHAPIConsumerTradeTool.h"
#import "NNHAPITradingTool.h"
#import "NNHConsumerTradeOrderModel.h"
#import "NNConsumerMatchOrderCoinPriceView.h"
#import "NNHPageTitleView.h"
#import "NNConsumerTradeDetailViewController.h"
#import "NNConsumerMatchOrderModel.h"
#import "NNConsumerOrderDetailModel.h"
#import "NNConsumerTradeDetailViewController.h"
#import "NNHEnterPasswordView.h"
#import "NNVerifyPhoneViewController.h"
#import "NNSetUpPayPasswordViewController.h"
#import "NNCoinMarketModel.h"
#import "NNConsumerMatchOrderTypeView.h"
#import "NNBlockFundTransferReocrdViewController.h"
#import "NNHMyBankCardController.h"

@interface NNConsumerMatchOrderViewController ()<UITableViewDelegate, UITableViewDataSource, NNHPageTitleViewDelegate>

/** 列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray *dataSource;
/** 交易币种名称 */
@property (nonatomic, copy) NSString *coinID;
/** 市场名称 */
@property (nonatomic, copy) NSString *marketName;
/** 交易类型 */
@property (nonatomic, assign) NNConsumerTradeType tradeType;
/** 输入密码 */
@property (nonatomic, strong) NNHEnterPasswordView *enterView;
/** NNConsumerMatchOrderTypeView */
@property (nonatomic, strong) NNConsumerMatchOrderTypeView *orderTypeView;

@end

@implementation NNConsumerMatchOrderViewController
{
    NSInteger _page;
}

#pragma mark - Life Cycle Methods

- (void)dealloc
{
    NNHLog(@"撮合页面销毁");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupChildView];
    [self setupRefresh];
    [self loadListDataRefresh:YES];

}

#pragma mark - Initial Methods
- (void)setupChildView
{
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    
    [self.view addSubview:self.orderTypeView];
    [self.orderTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.orderTypeView.mas_bottom);
    }];
    
    UIButton *tradingDetailButton = [UIButton NNHBtnImage:@"ic_trade_list" target:self action:@selector(tradingDetailAction)];
    [self.view addSubview:tradingDetailButton];
    [tradingDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.bottom.equalTo(self.view).offset(-30);
    }];
}

- (void)setupRefresh
{
    NNHWeakSelf(self)
    self.tableView.mj_header = [NNRefreshHeader headerWithRefreshingBlock:^{
        [weakself loadListDataRefresh:YES];
    }];
    
    self.tableView.mj_footer = [NNRefreshFooter footerWithRefreshingBlock:^{
        [weakself loadListDataRefresh:NO];
    }];
}

- (void)loadNetworkData
{
    [self loadListDataRefresh:YES];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    self.orderTypeView.selectedIndex = selectedIndex;
}

//请求数据
- (void)loadListDataRefresh:(BOOL)isRefresh
{
    NNHWeakSelf(self)
    _page = isRefresh ? 1 : _page + 1;
    NNHAPIConsumerTradeTool *tradingTool = [[NNHAPIConsumerTradeTool alloc] initMatchOrderListDataWithTradeType:self.tradeType page:_page];
    [tradingTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        
        NNHStrongSelf(self)
        if (isRefresh) {
            [strongself loadCoinListData:responseDic];
        }else{
            // 数据转化
            if (responseDic[@"data"][@"list"] == nil) return;
            NSArray *array = [NNConsumerMatchOrderModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
            [strongself.dataSource addObjectsFromArray:array];
            [strongself.tableView reloadData];
            
            if ([responseDic[@"data"][@"total"] integerValue] == self.dataSource.count) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                return;
            }
            // 结束刷新
            [strongself.tableView.mj_footer endRefreshing];
        }
        [weakself.tableView reloadData];
    } failBlock:^(NNHRequestError *error) {
        NNHStrongSelf(self)
        [strongself.tableView.mj_header endRefreshing];
        [strongself.tableView.mj_footer endRefreshing];
    } isCached:NO];
}

- (void)loadCoinListData:(NSDictionary *)responseDic
{
    self.dataSource = [NNConsumerMatchOrderModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    
    if ([responseDic[@"data"][@"total"] integerValue] == self.dataSource.count) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    // 重置刷新状态
    [self.tableView.mj_footer resetNoMoreData];
}

- (void)tradingDetailAction
{
    NNBlockFundTransferReocrdViewController *recordVC = [[NNBlockFundTransferReocrdViewController alloc]  initTransferRecordWithTransferType:NNHWalletTransferTypeC2C];
    recordVC.navigationItem.title = @"C2C交易中心明细";
    [self.navigationController pushViewController:recordVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNConsumerMatchOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNConsumerMatchOrderTableViewCell class])];
    cell.orderModel = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![NNHApplicationHelper sharedInstance].isRealName) return;
    
    if ([[NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.banknumber integerValue] == 0) {
        NNHWeakSelf(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            NNHStrongSelf(self)
            [[NNHAlertTool shareAlertTool] showAlertView:strongself title:@"请添加银行卡" message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
                NNHMyBankCardController *vc = [[NNHMyBankCardController alloc] init];
                [strongself.navigationController pushViewController:vc animated:YES];
            } cancle:^{
                
            }];
            return;
        });
    }
    NNConsumerMatchOrderModel *orderModel = self.dataSource[indexPath.row];
    [self requestOrderDetailDataWithOrderModel:orderModel];    
}

#pragma mark - Network Methods

- (void)requestOrderDetailDataWithOrderModel:(NNConsumerMatchOrderModel *)orderModel
{
    dispatch_async(dispatch_get_main_queue(), ^{ 
        
        NSString *title = @"您确认要买入吗？";
        if (self.tradeType == NNConsumerTradeType_sell) {
            title = @"您确认要卖出吗？";
        }
        
        NNHWeakSelf(self)
        [[NNHAlertTool shareAlertTool] showAlertView:self title:title message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
            NNHAPIConsumerTradeTool *tradeTool = [[NNHAPIConsumerTradeTool alloc] initDoDealTradeID:orderModel.orderID];
            [tradeTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {                
                NNConsumerOrderDetailModel *orderModel = [NNConsumerOrderDetailModel mj_objectWithKeyValues:responseDic[@"data"]];
                NNConsumerTradeDetailViewController *detailVc = [[NNConsumerTradeDetailViewController alloc] initWithOrderModel:orderModel];
                [weakself.navigationController pushViewController:detailVc animated:YES];
            } failBlock:^(NNHRequestError *error) {
                
            } isCached:NO];
        } cancle:^{
            
        }];
    });
}

#pragma mark - NNHPageTitleViewDelegate
- (void)nnh_pageTitleView:(NNHPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex
{
    self.tradeType = selectedIndex;
    [self loadListDataRefresh:YES];
}

#pragma mark - Lazy Loads

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewPlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 75;
        _tableView.emptyOffset = -50;
        [_tableView setupEmptyDataText:@"暂无记录" emptyImage:ImageName(@"ic_none_record") tapBlock:nil];
        [_tableView registerClass:[NNConsumerMatchOrderTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NNConsumerMatchOrderTableViewCell class])];
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(NNConsumerMatchOrderTypeView *)orderTypeView
{
    if (_orderTypeView == nil) {
        _orderTypeView = [[NNConsumerMatchOrderTypeView alloc] init];
        NNHWeakSelf(self)
        _orderTypeView.selectedButtonBlock = ^(NSInteger index) {
            weakself.tradeType = index;
            [weakself loadListDataRefresh:YES];
        };
    }
    return _orderTypeView;
}

@end
