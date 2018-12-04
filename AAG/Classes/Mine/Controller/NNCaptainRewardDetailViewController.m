//
//  NNCaptainRewardDetailViewController.m
//  SuperWallet
//
//  Created by 牛牛 on 2018/3/21.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNCaptainRewardDetailViewController.h"
#import "NNHTopToolbar.h"
#import "NNCaptainRewardDetailCell.h"

@interface NNCaptainRewardDetailViewController ()<UITableViewDataSource, UITableViewDelegate,NNHTopToolbarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
/** toolbar */
@property (nonatomic, strong) NNHTopToolbar *toobar;
/** 记录当前选中toobar的index */
@property (nonatomic, copy) NSString *toolbarIndex;

@end

@implementation NNCaptainRewardDetailViewController
{
    NSUInteger _page;
    NSUInteger _total;
}

#pragma mark -
#pragma mark ---------Life Cycle
- (void)dealloc
{
    NNHLog(@"--------%s-----",__func__);
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
    
    if (!_toolbarIndex) {
        _toolbarIndex = @"1";
        
    }
    _page = 1;
    
    // 初始化UI
    [self setupUI];
    
    // 配置上下拉刷新
    [self setupRefresh];
}

- (void)setupUI
{
    self.navigationItem.title = @"奖励明细";
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(44);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    [self.view addSubview:self.toobar];
}

- (void)setupRefresh
{
    NNHWeakSelf(self)
    self.tableView.mj_header = [NNRefreshHeader headerWithRefreshingBlock:^{
        [weakself loadMyEvaluateDataWithType:weakself.toolbarIndex refresh:YES];
    }];
    
    self.tableView.mj_footer = [NNRefreshFooter footerWithRefreshingBlock:^{
        [weakself loadMyEvaluateDataWithType:weakself.toolbarIndex refresh:NO];
    }];
}

#pragma mark -
#pragma mark ---------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNCaptainRewardDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNCaptainRewardDetailCell class])];
    return cell;
}

#pragma mark -
#pragma mark ---------ZPMainTopToolbarDelegate
- (void)topToolbar:(NNHTopToolbar *)toolbar didSelectedButton:(UIButton *)button
{
    self.toolbarIndex = [NSString stringWithFormat:@"%zd",button.tag + 1];
    
    // 让列表回到顶部
    self.tableView.contentOffset =  CGPointMake(0, 0);
    
    [self loadMyEvaluateDataWithType:self.toolbarIndex refresh:YES];
}

- (void)loadMyEvaluateDataWithType:(NSString *)type refresh:(BOOL)isRefresh
{
//    _page = isRefresh ? 1 : _page + 1;
//    
//    NNHAPICommentsTool *commentsTool = [[NNHAPICommentsTool alloc] initWithType:self.toolbarIndex page:_page];
//    NNHWeakSelf(self)
//    [commentsTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
//        NNHStrongSelf(self)
//        if (isRefresh) {
//            [strongself loadMyEvaluateData:responseDic];
//        }else{
//            // 数据转化
//            if (responseDic[@"data"][@"list"] == nil) return;
//            [strongself.dataSource addObjectsFromArray:[NNHMyEvaluateListModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]]];
//            [strongself.tableView reloadData];
//            
//            if (_total == strongself.dataSource.count) {
//                [self.tableView.mj_footer endRefreshingWithNoMoreData];
//                return;
//            }
//            // 结束刷新
//            [strongself.tableView.mj_footer endRefreshing];
//        }
//        
//    } failBlock:^(NNHRequestError *error) {
//        NNHStrongSelf(self)
//        [strongself.tableView.mj_header endRefreshing];
//        [strongself.tableView.mj_footer endRefreshing];
//    } isCached:NO];
}

- (void)loadMyEvaluateData:(NSDictionary *)responseDic
{
//    self.dataSource = [NNHMyEvaluateListModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
//    _total = [responseDic[@"data"][@"total"] integerValue];
//    [self.tableView reloadData];
//    [self.tableView.mj_header endRefreshing];
//
//    if (_total == self.dataSource.count) {
//        [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        return;
//    }
//    // 重置刷新状态
//    [self.tableView.mj_footer resetNoMoreData];
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewPlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
        [_tableView setupEmptyDataText:@"暂无明细" emptyImage:ImageName(@"ic_evaluate_none") tapBlock:nil];
        [_tableView registerClass:[NNCaptainRewardDetailCell class] forCellReuseIdentifier:NSStringFromClass([NNCaptainRewardDetailCell class])];
    }
    return _tableView;
}

- (NNHTopToolbar *)toobar
{
    if (_toobar == nil) {
        CGRect tooBarRect = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        _toobar = [[NNHTopToolbar alloc] initWithFrame:tooBarRect
                                                titles:@[@"佣金奖励",@"持仓奖励"]];
        _toobar.delegate = self;
    }
    return _toobar;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
