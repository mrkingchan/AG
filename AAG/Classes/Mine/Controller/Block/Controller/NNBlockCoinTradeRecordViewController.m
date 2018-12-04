//
//  NNBlockCoinTradeRecordViewController.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/4.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNBlockCoinTradeRecordViewController.h"
#import "NNHPageTitleView.h"
#import "NNTransferRecordListTableViewCell.h"
#import "NNRefreshHeader.h"
#import "NNAPIBlockFundTool.h"

@interface NNBlockCoinTradeRecordViewController ()<NNHPageTitleViewDelegate, UITableViewDelegate, UITableViewDataSource>

/** 选项卡 */
@property (nonatomic, strong) NNHPageTitleView *pageTitleView;
/** 展示列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataSource;
/** 当前操作类型 */
@property (nonatomic, assign) NNMineFundOperationType operationType;
@end

@implementation NNBlockCoinTradeRecordViewController
{
    NSInteger _page;
}

#pragma mark - Life Cycle Methods
- (void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"收支明细";
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    [self setupChildView];
    
    [self loadListDataRefresh:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    [self.view addSubview:self.pageTitleView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.pageTitleView.mas_bottom);
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

#pragma mark -
#pragma mark ---------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *array = self.dataSource[self.operationType];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNTransferRecordListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNTransferRecordListTableViewCell class])];
    NSMutableArray *array = self.dataSource[self.operationType];
    cell.recordModel = array[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - NNHPageTitleViewDelegate
- (void)nnh_pageTitleView:(NNHPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex
{
    self.operationType = selectedIndex;
    [self.tableView reloadData];
    [self loadListDataRefresh:YES];
}

#pragma mark - Network Methods
- (void)loadListDataRefresh:(BOOL)isRefresh
{
    NNHWeakSelf(self)
    _page = isRefresh ? 1 : _page + 1;
    NNAPIBlockFundTool *fundTool = [[NNAPIBlockFundTool alloc] initBlockFundCoinTransferRecordWithType:self.operationType page:_page];
    [fundTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        
        NNHStrongSelf(self)
        if (isRefresh) {
            [strongself loadCoinListData:responseDic];
        }else{
            // 数据转化
            if (responseDic[@"data"][@"list"] == nil) return;
            NSArray *array = [NNTransferRecordModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
            [strongself.dataSource[self.operationType] addObjectsFromArray:array];
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
    self.dataSource[self.operationType] = [NNTransferRecordModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];

    if ([responseDic[@"data"][@"total"] integerValue] == self.dataSource.count) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    // 重置刷新状态
    [self.tableView.mj_footer resetNoMoreData];
}



#pragma mark - Target Methods

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Lazy Loads

#pragma mark - NSObject  Methods

- (NNHPageTitleView *)pageTitleView
{
    if (_pageTitleView == nil) {
        NSArray *titleArray = @[@"全部", @"充资产", @"提资产"];
        _pageTitleView = [NNHPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NNHNormalViewH) delegate:self titleNames:titleArray];
        _pageTitleView.indicatorStyle = NNHIndicatorTypeEqual;
        _pageTitleView.backgroundColor = [UIConfigManager colorThemeWhite];
        _pageTitleView.titleColorStateNormal = [UIConfigManager colorThemeBlack];
        _pageTitleView.titleColorStateSelected = [UIConfigManager colorThemeRed];
        _pageTitleView.indicatorColor = [UIConfigManager colorThemeRed];
    }
    return _pageTitleView;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewPlain];
        _tableView.separatorColor = [UIConfigManager colorThemeSeperatorLightGray];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        [_tableView setupEmptyDataText:@"暂无记录" emptyImage:ImageName(@"ic_none_record") tapBlock:nil];
        _tableView.contentInset = UIEdgeInsetsMake(NNHMargin_10, 0, 0, 0);
        [_tableView registerClass:[NNTransferRecordListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NNTransferRecordListTableViewCell class])];
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            NSMutableArray *array = [NSMutableArray array];
            [_dataSource addObject:array];
        }
    }
    return _dataSource;
}

@end
