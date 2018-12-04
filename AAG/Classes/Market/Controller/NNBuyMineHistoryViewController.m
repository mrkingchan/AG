//
//  NNBuyMineHistoryViewController.m
//  NBTMill
//
//  Created by 来旭磊 on 2018/5/3.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNBuyMineHistoryViewController.h"
#import "NNBuyMineHistoryTableViewCell.h"
#import "NNHApiMarketHomeTool.h"
#import "NNHMineBuyRecordModel.h"

@interface NNBuyMineHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 展示列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataSource;
/** 列表头部视图 */
@property (nonatomic, strong) UIView *headerView;

@end

@implementation NNBuyMineHistoryViewController
{
    NSInteger _page;
}

#pragma mark -
#pragma mark ---------Life Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"购机记录";
    
    [self setupChildView];
    
    [self setupRefresh];
    
    [self loadListDataRefresh:YES];
}

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

#pragma mark - Network Methods

- (void)loadListDataRefresh:(BOOL)isRefresh
{
    NNHWeakSelf(self)
    _page = isRefresh ? 1 : _page + 1;
    NNHApiMarketHomeTool *recordTool = [[NNHApiMarketHomeTool alloc] initBuyMineRecordWithPage:_page];
    [recordTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        
        NNHStrongSelf(self)
        if (isRefresh) {
            [strongself loadCoinListData:responseDic];
        }else{
            // 数据转化
            if (responseDic[@"data"][@"userlist"] == nil) return;
            NSArray *array = [NNHMineBuyRecordModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
            [strongself.dataSource addObjectsFromArray:array];
            [strongself.tableView reloadData];
            
            if ([responseDic[@"data"][@"userlist"][@"total"] integerValue] == strongself.dataSource.count) {
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
    self.dataSource = [NNHMineBuyRecordModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
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
    NNBuyMineHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNBuyMineHistoryTableViewCell class])];
    cell.recordModel = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -
#pragma mark ---------Getters & Setters

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewPlain];
        _tableView.separatorColor = [UIConfigManager colorThemeSeperatorLightGray];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 68;
        [_tableView registerClass:[NNBuyMineHistoryTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NNBuyMineHistoryTableViewCell class])];
        [_tableView setupEmptyDataText:@"暂无记录" emptyImage:ImageName(@"ic_none_record") tapBlock:nil];
        _tableView.contentInset = UIEdgeInsetsMake(NNHMargin_10, 0, 0, 0);
    }
    return _tableView;
}

- (UIView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NNHNormalViewH)];
        _headerView.backgroundColor = [UIConfigManager colorThemeWhite];
        
        UILabel *timeLabel = [UILabel NNHWithTitle:@"日期" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel *modelLabel = [UILabel NNHWithTitle:@"机型" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
        modelLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel *countLabel = [UILabel NNHWithTitle:@"数量" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
        countLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel *amountLabel = [UILabel NNHWithTitle:@"金额" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
        amountLabel.textAlignment = NSTextAlignmentCenter;
        
        [_headerView addSubview:timeLabel];
        [_headerView addSubview:modelLabel];
        [_headerView addSubview:countLabel];
        [_headerView addSubview:amountLabel];
        
        CGFloat width = (SCREEN_WIDTH - NNHMargin_15 * 2) * 0.25;
        
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headerView).offset(NNHMargin_15);
            make.centerY.equalTo(_headerView);
            make.width.equalTo(@(width));
        }];
        [modelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(timeLabel.mas_right);
            make.centerY.equalTo(_headerView);
            make.width.equalTo(@(width));
        }];
        [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(modelLabel.mas_right);
            make.centerY.equalTo(_headerView);
            make.width.equalTo(@(width));
        }];
        [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(countLabel.mas_right);
            make.centerY.equalTo(_headerView);
            make.width.equalTo(@(width));
        }];
        
        UIView *lineView = [[UIView alloc] init];
        [_headerView addSubview:lineView];
        lineView.backgroundColor = [UIConfigManager colorThemeSeperatorLightGray];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(_headerView);
            make.height.equalTo(@(NNHLineH));
        }];
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

@end
