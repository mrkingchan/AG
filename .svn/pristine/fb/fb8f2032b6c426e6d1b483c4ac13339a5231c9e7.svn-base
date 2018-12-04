//
//  NNHConsumerCurrentEntrustViewController.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/15.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNHConsumerCurrentEntrustViewController.h"
#import "NNHConsumerCurrentEntrustTableViewCell.h"
#import "NNHAPIConsumerTradeTool.h"
#import "NNHConsumerTradeOrderModel.h"
#import "NNHCustomerTradeOrderOperationHelper.h"

@interface NNHConsumerCurrentEntrustViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray *dataSource;
/** 交易币种名称 */
@property (nonatomic, copy) NSString *coinID;
/** 市场名称 */
@property (nonatomic, copy) NSString *marketName;

/** 辅助类 */
@property (nonatomic, strong) NNHCustomerTradeOrderOperationHelper *operationHelper;
@end

@implementation NNHConsumerCurrentEntrustViewController
{
    NSInteger _page;
}

#pragma mark - Life Cycle Methods

- (void)dealloc
{
    NNHLog(@"销毁当前委托页面");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupChildView];
    
    [self setupRefresh];
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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

//请求数据
- (void)loadListDataRefresh:(BOOL)isRefresh
{
    NNHWeakSelf(self)
    _page = isRefresh ? 1 : _page + 1;
    NNHAPIConsumerTradeTool *tradingTool = [[NNHAPIConsumerTradeTool alloc] initTradeCurrentEntrusetListDataWithPage:_page];
    [tradingTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        
        NNHStrongSelf(self)
        if (isRefresh) {
            [strongself loadCoinListData:responseDic];
        }else{
            // 数据转化
            if (responseDic[@"data"][@"list"] == nil) return;
            NSArray *array = [NNHConsumerTradeOrderModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
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
    self.dataSource = [NNHConsumerTradeOrderModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    
    if ([responseDic[@"data"][@"total"] integerValue] == self.dataSource.count) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    // 重置刷新状态
    [self.tableView.mj_footer resetNoMoreData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNHConsumerCurrentEntrustTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNHConsumerCurrentEntrustTableViewCell class])];
    NNHConsumerTradeOrderModel *orderModel =  self.dataSource[indexPath.row];
    cell.orderModel = orderModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNHConsumerTradeOrderModel *orderModel =  self.dataSource[indexPath.row];
    [self.operationHelper orderListOperationWithOrderModel:orderModel];
}

#pragma mark - Network Methods

#pragma mark - Target Methods

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Lazy Loads

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewPlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 130;
        _tableView.contentInset = UIEdgeInsetsMake(NNHMargin_10, 0, 0, 0);
        _tableView.emptyOffset = -50;
        [_tableView setupEmptyDataText:@"暂无记录" emptyImage:ImageName(@"ic_none_record") tapBlock:nil];
        [_tableView registerClass:[NNHConsumerCurrentEntrustTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NNHConsumerCurrentEntrustTableViewCell class])];
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

- (NNHCustomerTradeOrderOperationHelper *)operationHelper
{
    if (_operationHelper == nil) {
        _operationHelper = [[NNHCustomerTradeOrderOperationHelper alloc] init];
        _operationHelper.currentViewController = self;
        NNHWeakSelf(self)
        _operationHelper.reloadDataBlock = ^{
            [weakself loadListDataRefresh:YES];
        };
    }
    return _operationHelper;
}

@end
