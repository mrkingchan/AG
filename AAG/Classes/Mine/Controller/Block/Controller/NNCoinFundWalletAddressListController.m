//
//  NNCoinFundWalletAddressListController.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/12.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNCoinFundWalletAddressListController.h"
#import "NNCoinFundWalletAddressListCell.h"
#import "NNAPIBlockFundTool.h"
#import "NNWalletAddressModel.h"

@interface NNCoinFundWalletAddressListController ()<UITableViewDelegate,UITableViewDataSource>

/** 展示列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation NNCoinFundWalletAddressListController

#pragma mark -
#pragma mark ---------Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"钱包地址";
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    
    [self setupChildView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self loadWalletAddressListData];
}


- (void)setupChildView
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Network Methods
/** 加载钱包列表 */
- (void)loadWalletAddressListData
{
    NNHWeakSelf(self)
    NNAPIBlockFundTool *fundTool = [[NNAPIBlockFundTool alloc] initUserWalletAddressListData];
    [fundTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [weakself.dataSource removeAllObjects];
        weakself.dataSource = [NNWalletAddressModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"]];
        [weakself.tableView reloadData];

    } failBlock:^(NNHRequestError *error) {

    } isCached:NO];
}

/** 删除钱包地址 */
- (void)deleteWalletAddressWithAddressID:(NSString *)addressID
{
    NNHWeakSelf(self)
    NNAPIBlockFundTool *fundTool = [[NNAPIBlockFundTool alloc] initDeleteWalletAddressWithAddressID:addressID];
    [fundTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [SVProgressHUD showMessage:@"删除成功"];
        [weakself loadWalletAddressListData];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

#pragma mark -
#pragma mark ---------UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNCoinFundWalletAddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNCoinFundWalletAddressListCell class])];
    cell.addressModel = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNWalletAddressModel *addressModel = self.dataSource[indexPath.row];
    if (self.selectAddressBlock) {
        self.selectAddressBlock(addressModel.addr);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNWalletAddressModel *addressModel = self.dataSource[indexPath.row];
    [self deleteWalletAddressWithAddressID:addressModel.addressID];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
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
        _tableView.rowHeight = NNHNormalViewH;
        [_tableView setupEmptyDataText:@"暂无记录" emptyImage:ImageName(@"ic_none_record") tapBlock:nil];
        [_tableView registerClass:[NNCoinFundWalletAddressListCell class] forCellReuseIdentifier:NSStringFromClass([NNCoinFundWalletAddressListCell class])];
        _tableView.contentInset = UIEdgeInsetsMake(NNHMargin_10, 0, 0, 0);
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
