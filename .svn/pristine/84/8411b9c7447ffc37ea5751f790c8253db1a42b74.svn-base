//
//  NNMineViewController.m
//  YWL
//
//  Created by 牛牛 on 2018/3/2.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNMineViewController.h"
#import "NNMyOrderViewController.h"
#import "NNMineShareCommunityViewController.h"
#import "NNCoinFundRechargeViewController.h"
#import "NNCoinAssetsDetailViewController.h"
#import "NNHMyBankCardController.h"
#import "NNMinePointSearchViewController.h"
#import "NNMineCommunityViewController.h"
#import "NNMineSettingViewController.h"
#import "NNMineNoticeViewController.h"
#import "NNMineQrCodeViewController.h"
#import "NNHMineTopView.h"
#import "NNMineModel.h"
#import "NNAPIMineTool.h"

@interface NNMineViewController ()

/* 顶部view */
@property (nonatomic, strong) NNHMineTopView *topView;
/* 会员中心数据模型 */
@property (nonatomic, strong) NNMineModel *mineModel;
/* 银行模块 */
@property (nonatomic, strong) NNHMyItem *bankItem;

@end

@implementation NNMineViewController

#pragma mark -
#pragma mark ---------Life Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self requestMyDataSource];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.tableView.tableHeaderView = self.topView;
    
    [self setupGroups];
}

- (void)requestMyDataSource
{
    NNHWeakSelf(self)
    NNAPIMineTool *userTool = [[NNAPIMineTool alloc] initMemberDataSource];
    [userTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        
        weakself.mineModel = [NNMineModel mj_objectWithKeyValues:responseDic[@"data"]];
        
        // 保存用户资料
        [[NNHProjectControlCenter sharedControlCenter] userControl_saveUserDataWithUserInfo:weakself.mineModel.userModel];
        
        weakself.bankItem.rightTitle = [weakself.mineModel.userModel.banknumber integerValue] > 0 ? @"已添加" : @"未添加";
        
        // 重置相关数据
        weakself.topView.mineModel = weakself.mineModel;
        weakself.topView.mj_h = weakself.mineModel.topViewH;
        weakself.tableView.tableHeaderView = weakself.topView;
        [weakself.tableView reloadData];
        
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self.tableView reloadData];
}

- (void)setupGroup0
{
    // 1.创建组
    NNHMyGroup *group = [NNHMyGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    NNHMyItem *orderItem = [NNHMyItem itemWithTitle:@"我的订单" icon:@"ic_orders" itemAccessoryViewType:NNHItemAccessoryViewTypeArrow];
    NNHMyItem *fillingItem = [NNHMyItem itemWithTitle:@"钱包地址" icon:@"ic_wallet" itemAccessoryViewType:NNHItemAccessoryViewTypeArrow];
    
    orderItem.destVcClass = [NNMyOrderViewController class];
    fillingItem.destVcClass = [NNCoinFundRechargeViewController class];
    
    group.items = @[orderItem, fillingItem];
}

- (void)setupGroup1
{
    // 1.创建组
    NNHMyGroup *group = [NNHMyGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    NNHMyItem *item0 = [NNHMyItem itemWithTitle:@"社群" icon:@"ic_group" itemAccessoryViewType:NNHItemAccessoryViewTypeArrow];
    NNHMyItem *item1 = [NNHMyItem itemWithTitle:@"分享节点算力" icon:@"ic_node" itemAccessoryViewType:NNHItemAccessoryViewTypeArrow];
    NNHMyItem *item2 = [NNHMyItem itemWithTitle:@"接点查询" icon:@"ic_search" itemAccessoryViewType:NNHItemAccessoryViewTypeArrow];
    
    item0.destVcClass = [NNMineCommunityViewController class];
    item1.destVcClass = [NNMineShareCommunityViewController class];
    NNHWeakSelf(self)
    item2.operation = ^{
        NNMinePointSearchViewController *vc = [[NNMinePointSearchViewController alloc] initWithShowSearch:[weakself.mineModel.isshowsearch boolValue]];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    
    group.items = @[item0,item1,item2];
}

- (void)setupGroup2
{
    // 1.创建组
    NNHMyGroup *group = [NNHMyGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    self.bankItem = [NNHMyItem itemWithTitle:@"我的银行卡" icon:@"ic_card" itemAccessoryViewType:NNHItemAccessoryViewTypeRightView];
    NNHMyItem *qrItem = [NNHMyItem itemWithTitle:@"我的二维码" icon:@"ic_code" itemAccessoryViewType:NNHItemAccessoryViewTypeRightView];

    qrItem.rightTitle = @"邀请好友";
    
    self.bankItem.destVcClass = [NNHMyBankCardController class];
    qrItem.destVcClass = [NNMineQrCodeViewController class];
    
    group.items = @[self.bankItem, qrItem];
}

#pragma mark -
#pragma mark ---------UserAction
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 上下滑动的距离
    CGFloat off_y = scrollView.contentOffset.y;
    
    // 如果off_y小于0，则为向下滑动，然后再用setContentOffset方法设置整个tableview的偏移量为（0，0）
    if (off_y < 0) {
        self.tableView.contentOffset = CGPointZero;
    }
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (NNHMineTopView *)topView
{
    if (_topView == nil) {
        _topView = [[NNHMineTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
        NNHWeakSelf(self)
        _topView.mineTopViewJumpBlock = ^(NNHMineTopJumpType type) {
            if (type == NNHMineTopJumpNotice) {
                NNMineNoticeViewController *vc = [[NNMineNoticeViewController alloc] init];
                [weakself.navigationController pushViewController:vc animated:YES];
            }else{
                NNMineSettingViewController *vc = [[NNMineSettingViewController alloc] init];
                [weakself.navigationController pushViewController:vc animated:YES];
            }
        };
        _topView.mineAssetsDetailJumpBlock = ^(NNHMineAssetsType type, NSString *title) {
            NNCoinAssetsDetailViewController *vc = [[NNCoinAssetsDetailViewController alloc] initWithCoinAssetsDetailType:type];
            vc.navigationItem.title = title;
            [weakself.navigationController pushViewController:vc animated:YES];
        };
    }
    return _topView;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
