//
//  NNBalanceFundTranferRecordViewController.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/23.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNBalanceFundTranferRecordViewController.h"
#import "NNBlockFundTransferReocrdCell.h"
#import "NNAPIBlockFundTransferTool.h"
#import "NNBlockFundTransferReocrdModel.h"

@interface NNBalanceFundTranferRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 展示列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation NNBalanceFundTranferRecordViewController
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
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"转账记录";
    [self setupChildView];
    
    [self setupRefresh];
    
    [self loadListDataRefresh:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


#pragma mark - Initial Methods
- (void)setupChildView
{
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

#pragma mark -
#pragma mark ---------UserAction

#pragma mark - Network Methods

- (void)loadListDataRefresh:(BOOL)isRefresh
{
    NNHWeakSelf(self)
    _page = isRefresh ? 1 : _page + 1;
    NNAPIBlockFundTransferTool *blockTool = [[NNAPIBlockFundTransferTool alloc] initConsumeFundTransferRecordWithPage:_page];
    [blockTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        
        NNHStrongSelf(self)
        if (isRefresh) {
            [strongself loadCoinListData:responseDic];
        }else{
            // 数据转化
            if (responseDic[@"data"][@"list"] == nil) return;
            NSArray *array = [NNBlockFundTransferReocrdModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
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
    self.dataSource = [NNBlockFundTransferReocrdModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    
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
    NNBlockFundTransferReocrdCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNBlockFundTransferReocrdCell class])];
    cell.consumeFundFlag = YES;
    cell.recordModel = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITextFieldDelegate

#pragma mark - Network Methods

#pragma mark - Target Methods

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Lazy Loads

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
        [_tableView registerClass:[NNBlockFundTransferReocrdCell class] forCellReuseIdentifier:NSStringFromClass([NNBlockFundTransferReocrdCell class])];
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


@end
