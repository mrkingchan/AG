//
//  NNHomeViewController.m
//  YWL
//
//  Created by 牛牛 on 2018/4/23.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNHomeViewController.h"
#import "NNHomeListCell.h"
#import "NNHApiMarketHomeTool.h"
#import "NNHomeListModel.h"
#import "NNHApplicationHelper.h"
#import "NNBuyMinePayViewController.h"

@interface NNHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 展示列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 头部 */
@property (nonatomic, strong) UIView *headView;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataSource;
/** 提示 */
@property (nonatomic, weak) UILabel *promptLabel;
/** 预购数量 */
@property (nonatomic, weak) UILabel *ygLabel;
/** 投资结束数量 */
@property (nonatomic, weak) UILabel *totalLabel;

@end

@implementation NNHomeViewController
{
    NSInteger _page;
}

#pragma mark -
#pragma mark ---------Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"投资";
    
    [self setupChildView];
    
    // 配置上下拉刷新
    [self setupRefresh];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage nnh_imageWithColor:[UIConfigManager colorThemeRed]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],
    NSFontAttributeName:[UIFont systemFontOfSize:18]};
    
    [self requestMinelistData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage nnh_imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],
    NSFontAttributeName:[UIFont systemFontOfSize:18]};
}

#pragma mark -
#pragma mark ---------UserAction
- (void)setupChildView
{
    self.tableView.tableHeaderView = self.headView;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setupRefresh
{
    NNHWeakSelf(self)
    self.tableView.mj_header = [NNRefreshHeader headerWithRefreshingBlock:^{
        [weakself requestMinelistData];
    }];
}

#pragma mark - Network Methods
- (void)requestMinelistData
{
    NNHWeakSelf(self)
    NNHApiMarketHomeTool *mineTool = [[NNHApiMarketHomeTool alloc] initMineListData];
    [mineTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        weakself.dataSource = [NNHomeListModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
        
        weakself.promptLabel.text = [NSString stringWithFormat:@"    %@",responseDic[@"data"][@"topremark"]];
        weakself.ygLabel.text = responseDic[@"data"][@"waitorder"];
        weakself.totalLabel.text = responseDic[@"data"][@"outorder"];
        
        [weakself.tableView reloadData];
        [weakself.tableView.mj_header endRefreshing];
        
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNHomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNHomeListCell class])];
    NNHomeListModel *model = self.dataSource[indexPath.section];
    cell.homeListModel = model;
    NNHWeakSelf(self)
    cell.buyActionBlock = ^{
        NNBuyMinePayViewController *buyVC = [[NNBuyMinePayViewController alloc] initWithHomeModel:model];
        [weakself.navigationController pushViewController:buyVC animated:YES];
    };
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark -
#pragma mark ---------Getters & Setters

#pragma mark - Lazy Loads
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewGroup];
        _tableView.separatorColor = [UIConfigManager colorThemeWhite];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 120;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
        [_tableView setupEmptyDataText:@"暂无信息" emptyImage:ImageName(@"ic_none_record") tapBlock:nil];
        [_tableView registerClass:[NNHomeListCell class] forCellReuseIdentifier:NSStringFromClass([NNHomeListCell class])];

    }
    return _tableView;
}

- (UIView *)headView
{
    if (_headView == nil) {
        
        CGFloat viewW = (SCREEN_WIDTH - 3 *NNHMargin_15) / 2;
        CGFloat viewH = viewW *0.5;
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, viewH + 30 + 30)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UILabel *promptLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextTip]];
        promptLabel.backgroundColor = [UIColor akext_colorWithHex:@"d1d1da"];
        [_headView addSubview:promptLabel];
        _promptLabel = promptLabel;
        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_headView);
            make.height.equalTo(@30);
        }];
        
        UIButton *ygContentView = [UIButton NNHBtnImage:@"" target:self action:nil];
        [ygContentView setBackgroundImage:ImageName(@"home_nub_bg_green") forState:UIControlStateNormal];
        [_headView addSubview:ygContentView];
        [ygContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(promptLabel.mas_bottom).offset(15);
            make.left.equalTo(_headView).offset(15);
            make.width.equalTo(@(viewW));
            make.height.equalTo(@(viewH));
        }];
        
        UILabel *ygTitleLabel = [UILabel NNHWithTitle:@"当前预购数量" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextTip]];
        [ygContentView addSubview:ygTitleLabel];
        [ygTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ygContentView.mas_centerY).offset(5);
            make.centerX.equalTo(ygContentView);
        }];
        
        UILabel *ygLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextImportant]];
        [ygContentView addSubview:ygLabel];
        _ygLabel = ygLabel;
        [ygLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ygContentView.mas_centerY).offset(-5);
            make.centerX.equalTo(ygContentView);
        }];
        
        UIButton *totalContentView = [UIButton NNHBtnImage:@"" target:self action:nil];
        [totalContentView setBackgroundImage:ImageName(@"home_nub_bg_blue") forState:UIControlStateNormal];
        [_headView addSubview:totalContentView];
        [totalContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ygContentView);
            make.right.equalTo(_headView).offset(-15);
            make.size.equalTo(ygContentView);
        }];
        
        UILabel *totalTitleLabel = [UILabel NNHWithTitle:@"当日投资结束数量" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextTip]];
        [totalContentView addSubview:totalTitleLabel];
        [totalTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(totalContentView.mas_centerY).offset(5);
            make.centerX.equalTo(totalContentView);
        }];
        
        UILabel *totalLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextImportant]];
        [totalContentView addSubview:totalLabel];
        _totalLabel = totalLabel;
        [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(totalContentView.mas_centerY).offset(-5);
            make.centerX.equalTo(totalContentView);
        }];
        
    }
    return _headView;
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



