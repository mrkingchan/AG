//
//  NNWalletViewController.m
//  YWL
//
//  Created by 牛牛 on 2018/3/2.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNWalletViewController.h"
#import "NNHomeTopView.h"
#import "NNWalletTableViewCell.h"
#import "NNWalletTableHeaderView.h"
#import "NNHApiMarketHomeTool.h"
#import "NNHomeListModel.h"
#import "NNMineOperationDeatilViewController.h"

@interface NNWalletViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 展示列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NNHomeTopView *topView;
/** 列表头部视图 */
@property (nonatomic, strong) NNWalletTableHeaderView *headerView;
/** 矿机运行状态 */
@property (nonatomic, assign) NNHMineOperationType operationType;
@end

@implementation NNWalletViewController
{
    NSInteger _page;
}

#pragma mark -
#pragma mark ---------Life Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [self loadListDataRefresh:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.operationType = NNHMineOperationType_progress;
    
    [self setupChildView];
    
    [self setupRefresh];
}

- (void)setupChildView
{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark -
#pragma mark ---------UserAction

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

#pragma mark -
#pragma mark ---------UserAction

#pragma mark - Network Methods

- (void)loadListDataRefresh:(BOOL)isRefresh
{
    NNHWeakSelf(self)
    _page = isRefresh ? 1 : _page + 1;
    NNHApiMarketHomeTool *mainTool = [[NNHApiMarketHomeTool alloc] initMineOperationListDataWithType:self.operationType page:_page];
    [mainTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        
        NNHStrongSelf(self)
        if (isRefresh) {
            [strongself loadCoinListData:responseDic];
        }else{
            // 数据转化
            if (responseDic[@"data"][@"list"] == nil) return;
            NSArray *array = [NNHomeListModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
            [strongself.dataSource addObjectsFromArray:array];
            [strongself.tableView reloadData];
            
            if ([responseDic[@"data"][@"total"] integerValue] == strongself.dataSource.count) {
                [strongself.tableView.mj_footer endRefreshingWithNoMoreData];
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
    self.dataSource = [NNHomeListModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    
    [self.headerView configPower:responseDic[@"data"][@"all_power"] output:responseDic[@"data"][@"all_out"]];
    
    if ([responseDic[@"data"][@"total"] integerValue] == self.dataSource.count) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    // 重置刷新状态
    [self.tableView.mj_footer resetNoMoreData];
}


#pragma mark -
#pragma mark ---------UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNWalletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNWalletTableViewCell class])];
    cell.mineModel = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNMineOperationDeatilViewController *operationVC = [[NNMineOperationDeatilViewController alloc] initWithMineID:@"22"];
    [self.navigationController pushViewController:operationVC animated:YES];
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (NNHomeTopView *)topView
{
    if (_topView == nil) {
        _topView = [[NNHomeTopView alloc] initWithTitle:self.navigationItem.title detailTitles:@[@"进行中",@"已停止"]];
        NNHWeakSelf(self)
        _topView.selectedSegmentIndexBlock = ^(NSInteger index) {
            NNHLog(@"------%zd------", index);
            weakself.operationType = index;
            [weakself loadListDataRefresh:YES];
        };
    }
    return _topView;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewPlain];
        _tableView.separatorColor = [UIConfigManager colorThemeSeperatorLightGray];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 66;
        [_tableView registerClass:[NNWalletTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NNWalletTableViewCell class])];
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (NNWalletTableHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[NNWalletTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    }
    return _headerView;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
