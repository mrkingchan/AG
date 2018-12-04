//
//  NNCoinAssetsDetailViewController.m
//  YWL
//
//  Created by 牛牛 on 2018/5/15.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNCoinAssetsDetailViewController.h"
#import "NNTransferTradingViewController.h"
#import "NNTransferWFCCWalletViewController.h"
#import "NNBlockFundTransferViewController.h"
#import "NNCoinAssetsDetailTopView.h"
#import "NNCoinAssetsDetailCell.h"
#import "NNCoinAssetsDetailModel.h"
#import "NNAPIBlockFundTool.h"

@interface NNCoinAssetsDetailViewController () <UITableViewDataSource, UITableViewDelegate>

/** 列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 头部view */
@property (nonatomic, strong) NNCoinAssetsDetailTopView *topView;
/** 数据 */
@property (nonatomic, strong) NNCoinAssetsDetailModel *assetsDetailModel;
/** 资产类型 */
@property (nonatomic, assign) NNHMineAssetsType assetsType;

@end

@implementation NNCoinAssetsDetailViewController
{
    NSUInteger _page;
    NSUInteger _total;
}

#pragma mark -
#pragma mark ---------Life Cycle
- (void)dealloc
{
    NNHLog(@"-------%s------",__func__);
}

- (instancetype)initWithCoinAssetsDetailType:(NNHMineAssetsType)type
{
    if (self = [super init]) {
        _assetsType = type;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    // 获取数据
    [self loadAssetsDetailDataWithRefresh:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    _page = 1;
    
    // 初始化UI
    [self setupUI];

    // 配置上下拉刷新
    [self setupRefresh];
}

- (void)setupUI
{
    CGFloat topViewH = 258 + (NNHSTATUSBARDifference);
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(topViewH));
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)setupRefresh
{
    NNHWeakSelf(self)
    self.tableView.mj_header = [NNRefreshHeader headerWithRefreshingBlock:^{
        [weakself loadAssetsDetailDataWithRefresh:YES];
    }];
    
    self.tableView.mj_footer = [NNRefreshFooter footerWithRefreshingBlock:^{
        [weakself loadAssetsDetailDataWithRefresh:NO];
    }];
}

#pragma mark -
#pragma mark ---------UserAction


#pragma mark -
#pragma mark ---------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.assetsDetailModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNCoinAssetsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNCoinAssetsDetailCell class])];
    cell.assetsDetailListModel = self.assetsDetailModel.list[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark ---------UITableViewDelegate
- (void)loadAssetsDetailDataWithRefresh:(BOOL)isRefresh
{
    _page = isRefresh ? 1 : _page + 1;

    NNAPIBlockFundTool *tool = [[NNAPIBlockFundTool alloc] initCoinAssetsDetailWithType:self.assetsType flowType:@"1" page:_page];
    NNHWeakSelf(self)
    [tool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        NNHStrongSelf(self)
        if (isRefresh) {
            [strongself loadNewAssetsData:responseDic];
        }else{
            // 数据转化
            if (responseDic[@"data"][@"list"] == nil) return;
            [strongself.assetsDetailModel.list addObjectsFromArray:[NNCoinAssetsDetailListModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]]];
            [strongself.tableView reloadData];

            if ([self.assetsDetailModel.total integerValue] == self.assetsDetailModel.list.count) {
                [strongself.tableView.mj_footer endRefreshingWithNoMoreData];
                return;
            }
            // 结束刷新
            [strongself.tableView.mj_footer endRefreshing];
        }

    } failBlock:^(NNHRequestError *error) {
        NNHStrongSelf(self)
        [strongself.tableView.mj_header endRefreshing];
        [strongself.tableView.mj_footer endRefreshing];
    } isCached:NO];
}

- (void)loadNewAssetsData:(NSDictionary *)responseDic
{
    self.assetsDetailModel = [NNCoinAssetsDetailModel mj_objectWithKeyValues:responseDic[@"data"]];
    self.topView.assetsDetailModel = self.assetsDetailModel;

    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];

    if ([self.assetsDetailModel.total integerValue] == self.assetsDetailModel.list.count) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    // 重置刷新状态
    [self.tableView.mj_footer resetNoMoreData];
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewPlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        _tableView.emptyOffset = -70;
        [_tableView setupEmptyDataText:@"暂无明细" emptyImage:ImageName(@"ic_none_record") tapBlock:nil];
        [_tableView registerClass:[NNCoinAssetsDetailCell class] forCellReuseIdentifier:NSStringFromClass([NNCoinAssetsDetailCell class])];
    }
    return _tableView;
}

- (NNCoinAssetsDetailTopView *)topView
{
    if (_topView == nil) {
        _topView = [[NNCoinAssetsDetailTopView alloc] initWithTopAssetsType:_assetsType title:self.navigationItem.title];
        NNHWeakSelf(self)
        _topView.backActionBlock = ^{
            [weakself.navigationController popViewControllerAnimated:YES];
        };
        _topView.extractionAssetsBlock = ^(NNHMineAssetsType currentAssetsType){
            if (currentAssetsType == NNHMineAssetsType_lt) {
                NNBlockFundTransferViewController *vc = [[NNBlockFundTransferViewController alloc] initWithTransferType:NNHWalletTransferTypeLTTransfer];
                [weakself.navigationController pushViewController:vc animated:YES];
            }else if (currentAssetsType == NNHMineAssetsType_zz) {
                NNBlockFundTransferViewController *vc = [[NNBlockFundTransferViewController alloc] initWithTransferType:NNHWalletTransferTypeZZTransfer];
                [weakself.navigationController pushViewController:vc animated:YES];
            }else{
                NNBlockFundTransferViewController *vc = [[NNBlockFundTransferViewController alloc] initWithTransferType:NNHWalletTransferTypeWFCCTransfer];
                [weakself.navigationController pushViewController:vc animated:YES];
            }
        };
        _topView.rollOutActionBlock = ^(NNHMineAssetsType type) {
            if (type == NNHMineAssetsType_lt) {
                NNTransferWFCCWalletViewController *vc = [[NNTransferWFCCWalletViewController alloc] initWithTransferType:NNHWalletTransferTypeLTWFCC];
                [weakself.navigationController pushViewController:vc animated:YES];
            }else if (type == NNHMineAssetsType_xf) {
                NNTransferWFCCWalletViewController *vc = [[NNTransferWFCCWalletViewController alloc] initWithTransferType:NNHWalletTransferTypeXFWFCC];
                [weakself.navigationController pushViewController:vc animated:YES];
            }else{
                NNTransferWFCCWalletViewController *vc = [[NNTransferWFCCWalletViewController alloc] initWithTransferType:NNHWalletTransferTypeZZAAG];
                [weakself.navigationController pushViewController:vc animated:YES];
            }
        };
    }
    return _topView;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
