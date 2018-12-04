//
//  NNMineNoticeViewController.m
//  YWL
//
//  Created by 牛牛 on 2018/4/27.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMineNoticeViewController.h"
#import "NNMineNoticeCell.h"
#import "NNMineNoticeModel.h"
#import "NNAPIMineTool.h"
#import "NNWebViewController.h"

@interface NNMineNoticeViewController () <UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSMutableArray <NNMineNoticeModel *> *dataSource;

@end

@implementation NNMineNoticeViewController
{
    NSUInteger _page;
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
    
    self.navigationItem.title = @"公告中心";
    self.view.backgroundColor = [UIColor akext_colorWithHex:@"#eeeeee"];
    
    [self setupChildView];
    [self setupRefresh];
    [self requestDatasourceWithRefresh:YES];
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
        [weakself requestDatasourceWithRefresh:YES];
    }];
    
    self.tableView.mj_footer = [NNRefreshFooter footerWithRefreshingBlock:^{
        [weakself requestDatasourceWithRefresh:NO];
    }];
}

- (void)requestDatasourceWithRefresh:(BOOL)isRefresh
{
    _page = isRefresh ? 1 : _page + 1;

    NNAPIMineTool *tool = [[NNAPIMineTool alloc] initMyNoticeWithPage:_page];

    NNHWeakSelf(self)
    [tool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        if (isRefresh) {
            [weakself loadNewDataSource:responseDic];
        }else{
            // 数据转化
            if (responseDic[@"data"] == nil) return;
            NSArray *newsArr = [NNMineNoticeModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
            [weakself.dataSource addObjectsFromArray:newsArr];
            [weakself.tableView reloadData];

            if ([responseDic[@"data"][@"total"] integerValue] == self.dataSource.count) {
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
                return;
            }
            // 结束刷新
            [weakself.tableView.mj_footer endRefreshing];
        }
    } failBlock:^(NNHRequestError *error) {
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
    } isCached:NO];
}

- (void)loadNewDataSource:(NSDictionary *)responseDic
{
    self.dataSource = [NNMineNoticeModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
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
#pragma mark ---------UserAction

#pragma mark -
#pragma mark ---------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNMineNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNMineNoticeCell class])];
    cell.mineNoticeModel = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark ---------UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNMineNoticeModel *model = self.dataSource[indexPath.row];
    NNWebViewController *vc = [[NNWebViewController alloc] init];
    vc.url = model.url;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNMineNoticeModel *noticeModel = self.dataSource[indexPath.row];
    return noticeModel.cellHeight;
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewPlain];
        _tableView.backgroundColor = [UIColor akext_colorWithHex:@"#eeeeee"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setupEmptyDataText:@"暂无公告" emptyImage:ImageName(@"ic_none_record") tapBlock:nil];
        [_tableView registerClass:[NNMineNoticeCell class] forCellReuseIdentifier:NSStringFromClass([NNMineNoticeCell class])];
    }
    return _tableView;
}

- (NSMutableArray<NNMineNoticeModel *> *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
        
    }
    return _dataSource;
}

@end
