//
//  NNChargeAccountDetailViewController.m
//  YWL
//
//  Created by 牛牛 on 2018/7/10.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNChargeAccountDetailViewController.h"
#import "NNCoinAssetsDetailCell.h"
#import "NNCoinAssetsDetailModel.h"
#import "NNHApiMarketHomeTool.h"

@interface NNChargeAccountDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 展示列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray <NNCoinAssetsDetailListModel *> *dataSource;
/** 当前转账类型 */
@property (nonatomic, assign) NNHWalletTransferType currentTransferType;

@end

@implementation NNChargeAccountDetailViewController
{
    NSInteger _page;
}

#pragma mark - Life Cycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"记账明细";
    
    UIImage *backImage = [[UIImage imageNamed:@"ic_nav_back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    [self setupChildView];
    [self setupRefresh];
    [self loadListDataRefresh:YES];
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

- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Network Methods
- (void)loadListDataRefresh:(BOOL)isRefresh
{
    NNHWeakSelf(self)
    _page = isRefresh ? 1 : _page + 1;
    NNHApiMarketHomeTool *tool = [[NNHApiMarketHomeTool alloc] initHomePowerFlowDetailWithID:self.powerID Page:_page];
    [tool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        
        NNHStrongSelf(self)
        if (isRefresh) {
            [strongself loadCoinListData:responseDic];
        }else{
            // 数据转化
            if (responseDic[@"data"][@"list"] == nil) return;
            NSArray *array = [NNCoinAssetsDetailListModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
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
    self.dataSource = [NNCoinAssetsDetailListModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
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
    NNCoinAssetsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNCoinAssetsDetailCell class])];
    cell.assetsDetailListModel = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

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
        [_tableView registerClass:[NNCoinAssetsDetailCell class] forCellReuseIdentifier:NSStringFromClass([NNCoinAssetsDetailCell class])];
    }
    return _tableView;
}

- (NSMutableArray<NNCoinAssetsDetailListModel *> *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
