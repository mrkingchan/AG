//
//  NNMineSettingController.m
//  NBTMill
//
//  Created by 牛牛 on 2018/5/7.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMineSettingViewController.h"
#import "NNRealNameAuthenticationViewController.h"
#import "NNMineAccountSecurityViewController.h"
#import "NNHAlertTool.h"
#import "UIWindow+NNExtension.h"

@interface NNMineSettingViewController ()

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *logoutButton;

@end

@implementation NNMineSettingViewController

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
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"设置";
    self.tableView.tableFooterView = self.footerView;
    
    [self setupGroups];
}

- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroup0
{
    // 1.创建组
    NNHMyGroup *group = [NNHMyGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    NNHMyItem *realItem = [NNHMyItem itemWithTitle:@"实名认证" itemAccessoryViewType:NNHItemAccessoryViewTypeRightView];
    NNHMyItem *accountItem = [NNHMyItem itemWithTitle:@"账户安全" itemAccessoryViewType:NNHItemAccessoryViewTypeArrow];
    
    NNUserModel *userModel = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel;
    realItem.rightTitle = userModel.idcardStatus;
    
    if ([userModel.idcardauth integerValue] != 2) {        
        realItem.destVcClass = [NNRealNameAuthenticationViewController class];
    }
    accountItem.destVcClass = [NNMineAccountSecurityViewController class];
    
    group.items = @[realItem,accountItem];
}

- (void)setupGroup1
{
    // 1.创建组
    NNHMyGroup *group = [NNHMyGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    NNHMyItem *cacheItem = [NNHMyItem itemWithTitle:@"清除缓存" itemAccessoryViewType:NNHItemAccessoryViewTypeRightView];
    NNHMyItem *currentVersionItem = [NNHMyItem itemWithTitle:@"当前版本" itemAccessoryViewType:NNHItemAccessoryViewTypeRightLabel];
    
    CGFloat cacheNum = [[SDImageCache sharedImageCache] getSize] / 1000.0 / 1024.0;
    cacheItem.rightTitle = cacheNum >= 1 ? [NSString stringWithFormat:@"%.2fM",cacheNum] : [NSString stringWithFormat:@"%.2fK",cacheNum * 1024];
    currentVersionItem.rightTitle = [NSString stringWithFormat:@"V%@",[NNHProjectControlCenter sharedControlCenter].currentVersion];
    
    NNHWeakSelf(self)
    NNHWeakSelf(cacheItem)
    cacheItem.operation = ^{
        NNHStrongSelf(self)
        NNHStrongSelf(cacheItem)
        dispatch_async(dispatch_get_main_queue(),^{
            [[NNHAlertTool shareAlertTool] showAlertView:strongself title:@"提示" message:@"确定清除本地缓存?" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
                [SVProgressHUD showMessage:@"清除成功"];
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
                strongcacheItem.rightTitle = @"0M";
                [strongself.tableView reloadData];
                
            } cancle:^{
            }];
        });
    };
    
    group.items = @[cacheItem,currentVersionItem];
}

#pragma mark -
#pragma mark ---------UserAction
- (void)loginAction
{
    [[NNHAlertTool shareAlertTool] showAlertView:self title:@"确定要退出登录吗?" message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{

        [[NNHProjectControlCenter sharedControlCenter].userControl logOut];
        [[UIApplication sharedApplication].keyWindow loadRootViewController];
        
    } cancle:^{
        
    }];
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (UIView *)footerView
{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NNHOperationButtonH + NNHMargin_20 *2)];
        
        [_footerView addSubview:self.logoutButton];
        [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(NNHMargin_15);
            make.right.mas_equalTo(-NNHMargin_15);
            make.top.equalTo(_footerView).offset(NNHMargin_20 *2);
            make.bottom.equalTo(_footerView);
        }];
    }
    return _footerView;
}

- (UIButton *)logoutButton
{
    if (_logoutButton == nil) {
        _logoutButton = [UIButton NNHOperationBtnWithTitle:@"退出登录" target:self action:@selector(loginAction) operationButtonType:NNHOperationButtonTypeGrey isAddCornerRadius:YES];
    }
    return _logoutButton;
}

@end
