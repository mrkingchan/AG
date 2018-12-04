//
//  NNMyOrderViewController.m
//  WTA
//
//  Created by 牛牛 on 2018/9/10.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMyOrderViewController.h"
#import "NNHEnterPasswordView.h"
#import "NNMyOrderCell.h"
#import "NNMyOrderModel.h"
#import "NNAPIMineTool.h"
#import "NNHAlertTool.h"

@interface NNMyOrderViewController () <UITableViewDelegate, UITableViewDataSource>

/** 列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 输入密码 */
@property (nonatomic, strong) NNHEnterPasswordView *enterView;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray <NNMyOrderModel *> *dataSource;
/** 当前订单 */
@property (nonatomic, strong) NNMyOrderModel *currentOrderModel;
/** 撤单提示信息 */
@property (nonatomic, copy) NSString *revokeremark;
/** 撤单是否需要输入支付密码(1需要 0不需要) */
@property (nonatomic, assign) BOOL isrevokepaypwd;

@end

@implementation NNMyOrderViewController
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
    
    self.navigationItem.title = @"我的订单";
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    
    [self setupChildView];
    [self setupRefresh];
    [self requestOrderListDataRefresh:YES];
}

- (void)setupChildView
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
}

- (void)setupRefresh
{
    NNHWeakSelf(self)
    self.tableView.mj_header = [NNRefreshHeader headerWithRefreshingBlock:^{
        [weakself requestOrderListDataRefresh:YES];
    }];
    
    self.tableView.mj_footer = [NNRefreshFooter footerWithRefreshingBlock:^{
        [weakself requestOrderListDataRefresh:NO];
    }];
}


- (void)requestOrderListDataRefresh:(BOOL)isRefresh
{
    NNHWeakSelf(self)
    _page = isRefresh ? 1 : _page + 1;
    NNAPIMineTool *tool = [[NNAPIMineTool alloc] initMyOrderListWithPage:_page];
    [tool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        
        NNHStrongSelf(self)
        if (isRefresh) {
            [strongself loadMyOrderListData:responseDic];
        }else{
            // 数据转化
            if (responseDic[@"data"][@"list"] == nil) return;
            NSArray *array = [NNMyOrderModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
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

- (void)loadMyOrderListData:(NSDictionary *)responseDic
{
    self.dataSource = [NNMyOrderModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
    self.revokeremark = responseDic[@"data"][@"revokeremark"];
    self.isrevokepaypwd = [responseDic[@"data"][@"isrevokepaypwd"] boolValue];
    
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
/** 输入交易密码 */
- (void)inputPayCode:(NSString *)paycode
{
    [self cacleOrderWithPaypwd:paycode];
}

- (void)cacleOrderWithPaypwd:(NSString *)paypwd
{
    NNHWeakSelf(self)
    [SVProgressHUD nn_showWithStatus:nil];
    NNAPIMineTool *tool = [[NNAPIMineTool alloc] initCancleMyOrderWitID:self.currentOrderModel.orderno payPwd:paypwd];
    [tool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [SVProgressHUD showMessage:@"已撤销"];
        [weakself.enterView dissmissWithCompletion:nil];
        [weakself requestOrderListDataRefresh:YES];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

#pragma mark -
#pragma mark --------- UITableViewDataSource
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
    NNMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNMyOrderCell class])];
    
    NNMyOrderModel *orderModel = self.dataSource[indexPath.section];
    cell.orderModel = orderModel;
    NNHWeakSelf(self)
    cell.cancleOrderBlock = ^(NNMyOrderModel *currentOrderModel){
        NNHStrongSelf(self)
        strongself.currentOrderModel = currentOrderModel;
        if (strongself.isrevokepaypwd) {
            [[NNHAlertTool shareAlertTool] showAlertView:strongself title:strongself.revokeremark message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"确认" confirm:^{
                [strongself.enterView showInFatherView:strongself.view];
            } cancle:^{
                
            }];
        }else {
            [strongself cacleOrderWithPaypwd:@""];
        }
    };
    return cell;
}

#pragma mark -
#pragma mark --------- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? NNHMargin_10 : 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return NNHMargin_10;
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewGroup];
        _tableView.rowHeight = 150;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setupEmptyDataText:@"暂无订单" emptyImage:ImageName(@"ic_none_record") tapBlock:nil];
        [_tableView registerClass:[NNMyOrderCell class] forCellReuseIdentifier:NSStringFromClass([NNMyOrderCell class])];
    }
    return _tableView;
}

- (NNHEnterPasswordView *)enterView
{
    if (_enterView == nil) {
        _enterView = [[NNHEnterPasswordView alloc] init];
        NNHWeakSelf(self)
        _enterView.didEnterCodeBlock = ^(NSString *password){
            NNHStrongSelf(self)
            [strongself inputPayCode:password];
        };
    }
    
    return _enterView;
}

- (NSMutableArray<NNMyOrderModel *> *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
