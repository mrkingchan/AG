//
//  NNHMineAccountViewController.m
//  NBTMill
//
//  Created by 牛牛 on 2018/3/6.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNMineAccountSecurityViewController.h"
#import "NNSetUpLoginPasswordViewController.h"
#import "NNSetUpPayPasswordViewController.h"
#import "NNVerifyPhoneViewController.h"

@interface NNMineAccountSecurityViewController ()

@end

@implementation NNMineAccountSecurityViewController

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
    
    self.navigationItem.title = @"安全中心";
    self.tableView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    [self setupGroups];
}

- (void)setupGroups
{
    [self setupGroup0];
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
        if ([[NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.isloginpwd boolValue]) {
            NNVerifyPhoneViewController *phoneVC = [[NNVerifyPhoneViewController alloc] initWithType:NNHSendVerificationCodeType_changeLoginPassword];
            [weakself.navigationController pushViewController:phoneVC animated:YES];
        }else{
            NNSetUpLoginPasswordViewController *vc = [[NNSetUpLoginPasswordViewController alloc] init];
            vc.firstSetUpPassword = YES;
            [weakself.navigationController pushViewController:vc animated:YES];
        }
    };
    
    NNUserModel *userModel = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel;
    
    NNHMyItem *walletPwdItem = [NNHMyItem itemWithTitle:@"支付密码" itemAccessoryViewType:NNHItemAccessoryViewTypeArrow];
    walletPwdItem.rightTitle = [userModel.ispaypass boolValue] ? @"已设置" : @"未设置";
    walletPwdItem.operation = ^{
        if ([userModel.ispaypass isEqualToString:@"1"]) {
            NNVerifyPhoneViewController*verifyMobileVC = [[NNVerifyPhoneViewController alloc] initWithType:NNHSendVerificationCodeType_changePayPassword];
            [self.navigationController pushViewController:verifyMobileVC animated:YES];
        }else {
            NNSetUpPayPasswordViewController *changPayCodeVc = [[NNSetUpPayPasswordViewController alloc] initWithFromType:NNHChangePayCodeFromType_FistChange];
            [self.navigationController pushViewController:changPayCodeVc animated:YES];
        }
    };
    
    group.items = @[loginPwdItem,walletPwdItem];
}


@end
