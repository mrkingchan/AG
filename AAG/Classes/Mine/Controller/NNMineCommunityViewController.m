//
//  NNMineCommunityViewController.m
//  YWL
//
//  Created by 牛牛 on 2018/7/9.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMineCommunityViewController.h"
#import "NNMineCommunityCell.h"
#import "NNMineCommunityModel.h"
#import "NNAPIMineTool.h"

@interface NNMineCommunityViewController () <UITableViewDataSource, UITableViewDelegate>

/** 列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSMutableArray <NNMineCommunityModel *> *dataSource;

@end

@implementation NNMineCommunityViewController
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"社群明细";
    _page = 1;
    
    // 初始化UI
    [self setupUI];
    
    // 配置上下拉刷新
    [self setupRefresh];
    [self loadAssetsDetailDataWithRefresh:YES];
}

- (void)setupUI
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
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
    NNMineCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNMineCommunityCell class])];
    cell.communityModel = self.dataSource[indexPath.section];
    return cell;
}

#pragma mark -
#pragma mark ---------UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)loadAssetsDetailDataWithRefresh:(BOOL)isRefresh
{
    _page = isRefresh ? 1 : _page + 1;
    
    NNAPIMineTool *tool = [[NNAPIMineTool alloc] initMyCommunityWithPage:_page];
    NNHWeakSelf(self)
    [tool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        NNHStrongSelf(self)
        if (isRefresh) {
            [strongself loadNewAssetsData:responseDic];
        }else{
            // 数据转化
            if (responseDic[@"data"][@"list"] == nil) return;
            [strongself.dataSource addObjectsFromArray:[NNMineCommunityModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]]];
            [strongself.tableView reloadData];
            
            if (_total == strongself.dataSource.count) {
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
    self.dataSource = [NNMineCommunityModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
    _total = [responseDic[@"data"][@"total"] integerValue];
    
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    
    if (_total == self.dataSource.count) {
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
        _tableView = [UITableView nnhTableViewGroup];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        [_tableView setupEmptyDataText:@"暂无明细" emptyImage:ImageName(@"ic_none_record") tapBlock:nil];
        [_tableView registerClass:[NNMineCommunityCell class] forCellReuseIdentifier:NSStringFromClass([NNMineCommunityCell class])];
    }
    return _tableView;
}

@end
