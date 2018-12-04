//
//  NNHMineAccountViewController.m
//  NNHBitooex
//
//  Created by 牛牛 on 2018/3/6.
//  Copyright © 2018年 深圳市云牛惠科技有限公司. All rights reserved.
//

#import "NNHMineAccountViewController.h"
#import "NNHMyGroup.h"
#import "NNHMyItem.h"
#import "NNHSetUpLoginPasswordViewController.h"
#import "NNHSetUpPayPasswordViewController.h"

@interface NNHMineAccountViewController ()

@end

@implementation NNHMineAccountViewController

#pragma mark -
#pragma mark ---------Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"安全中心";
    self.tableView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    [self setupGroups];
}

- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self.tableView reloadData];
}

- (void)setupGroup0
{
    // 1.创建组
    NNHMyGroup *group = [NNHMyGroup group];
    [self.groups addObject:group];
    
    NNHWeakSelf(self)
    
    // 2.设置组的所有行数据
    NNHMyItem *loginPwdItem = [NNHMyItem itemWithTitle:@"登录密码" itemAccessoryViewType:NNHItemAccessoryViewTypeArrow];
    loginPwdItem.operation = ^{
        NNHSetUpLoginPasswordViewController *passwordVC = [[NNHSetUpLoginPasswordViewController alloc] init];
        [weakself.navigationController pushViewController:passwordVC animated:YES];
    };
    
    NNHMyItem *walletPwdItem = [NNHMyItem itemWithTitle:@"资金密码" itemAccessoryViewType:NNHItemAccessoryViewTypeArrow];
    walletPwdItem.operation = ^{
        NNHSetUpPayPasswordViewController *payCodeVC = [[NNHSetUpPayPasswordViewController alloc] init];
        [weakself.navigationController pushViewController:payCodeVC animated:YES];
    };
    
    NNHMyItem *fingerprintItem = [NNHMyItem itemWithTitle:@"指纹解锁" itemAccessoryViewType:NNHItemAccessoryViewTypeSwitch];
    walletPwdItem.operation = ^{

    };
    
    group.items = @[loginPwdItem,walletPwdItem,fingerprintItem];
}

- (void)setupGroup1
{
    // 1.创建组
    NNHMyGroup *group = [NNHMyGroup group];
    [self.groups addObject:group];
    
    NNHWeakSelf(self)
    
    // 2.设置组的所有行数据
    NNHMyItem *phoneItem = [NNHMyItem itemWithTitle:@"手机绑定"  itemAccessoryViewType:NNHItemAccessoryViewTypeRightView];
    phoneItem.operation = ^{
        NNHSetUpLoginPasswordViewController *passwordVC = [[NNHSetUpLoginPasswordViewController alloc] init];
        [weakself.navigationController pushViewController:passwordVC animated:YES];
    };
    group.items = @[phoneItem];
}

@end
