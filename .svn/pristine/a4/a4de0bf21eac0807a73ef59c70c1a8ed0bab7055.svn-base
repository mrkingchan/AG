//
//  NNMineOperationDeatilViewController.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/10.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMineOperationDeatilViewController.h"
#import "NNChargeAccountDetailViewController.h"
#import "NNHApiMarketHomeTool.h"
#import "NNMineOperationModel.h"
#import "NNMineOperationDeatilCell.h"
#import "NNMineOperationBackgroundView.h"
#import "NNMineOperationDeatilTableHeaderView.h"

@interface NNMineOperationDeatilViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 背景view */
@property (nonatomic, strong) NNMineOperationBackgroundView *backgroundView;
/** 展示列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 矿机ID */
@property (nonatomic, copy) NSString *mineID;
/** 运行模型 */
@property (nonatomic, strong) NNMineOperationModel *operationModel;
/** 头部view */
@property (nonatomic, strong) NNMineOperationDeatilTableHeaderView *headerView;

@end

@implementation NNMineOperationDeatilViewController


#pragma mark - Life Cycle Methods
- (void)dealloc
{
    NNHLog(@"矿机详情页释放");
}

- (instancetype)initWithMineID:(NSString *)mineID
{
    self = [super init];
    if (self) {
        _mineID = mineID;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"AAG 记账";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(accountDetailAction) title:@"明细"];
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    
    [self setupChildView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    [self loadMineOperationData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.backgroundView stopTimer];
}

- (void)setupChildView
{
    [self.view addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark -
#pragma mark ---------UserAction
- (void)accountDetailAction
{
    NNChargeAccountDetailViewController *vc = [[NNChargeAccountDetailViewController alloc] init];
    vc.powerID = self.mineID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Network Methods

- (void)loadMineOperationData
{
    NNHWeakSelf(self)
    NNHApiMarketHomeTool *forceTool = [[NNHApiMarketHomeTool alloc] initMineOperationDataWithMineID:self.mineID];
    [forceTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        
        weakself.operationModel = [NNMineOperationModel mj_objectWithKeyValues:responseDic[@"data"]];
        weakself.tableView.tableHeaderView = weakself.headerView;
        weakself.headerView.operationModel = weakself.operationModel;
        [weakself.tableView reloadData];
        
    } failBlock:^(NNHRequestError *error) {
        NNHStrongSelf(self)
        [strongself.tableView.mj_header endRefreshing];
        [strongself.tableView.mj_footer endRefreshing];
    } isCached:NO];
}

#pragma mark -
#pragma mark ---------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.operationModel.serverinfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNMineOperationDeatilCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNMineOperationDeatilCell class])];
    cell.nodeModel = self.operationModel.serverinfo[indexPath.row];    
    return cell;
}

#pragma mark -
#pragma mark ---------Getters & Setters

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewPlain];
        _tableView.separatorColor = [[UIConfigManager colorThemeSeperatorLightGray] colorWithAlphaComponent:0.3];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 66;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[NNMineOperationDeatilCell class] forCellReuseIdentifier:NSStringFromClass([NNMineOperationDeatilCell class])];
    }
    return _tableView;
}

- (NNMineOperationBackgroundView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [[NNMineOperationBackgroundView alloc] init];
    }
    return _backgroundView;
}

- (NNMineOperationDeatilTableHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[NNMineOperationDeatilTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.85 + 70)];
    }
    return _headerView;
    
}

@end
