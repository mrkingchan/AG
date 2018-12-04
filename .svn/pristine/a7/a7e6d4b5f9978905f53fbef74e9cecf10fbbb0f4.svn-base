//
//  NNMineShareCommunityViewController.m
//  YWL
//
//  Created by 牛牛 on 2018/7/16.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMineShareCommunityViewController.h"
#import "NNAPIBlockPointTool.h"

@interface NNMineShareCommunityViewController ()

/** 分享值 */
@property (nonatomic, strong) UILabel *shareLabel;
/** 大区业绩 */
@property (nonatomic, strong) UILabel *bigLabel;
/** 小区业绩 */
@property (nonatomic, strong) UILabel *smallLabel;

@end

@implementation NNMineShareCommunityViewController
{
    BOOL _isShowSearch;
}

#pragma mark - Life Cycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"分享节点算力";
    
    [self setupChildView];
    [self requestPointDataSource];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    // 算力值
    UIView *shareView = [[UIView alloc] init];
    shareView.backgroundColor = [UIColor whiteColor];
    NNHViewRadius(shareView, 5.0);
    [self.view addSubview:shareView];
    [shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(15);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@110);
    }];
    
    [shareView addSubview:self.shareLabel];
    [self.shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(shareView.mas_centerY).offset(-5);
        make.centerX.equalTo(shareView);
    }];
    
    UILabel *shareDetailLabel = [UILabel NNHWithTitle:@"当前值为" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextTip]];
    [shareView addSubview:shareDetailLabel];
    [shareDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shareView.mas_centerY).offset(5);
        make.centerX.equalTo(shareView);
    }];
    
    // 社区
    UIView *communityView = [[UIView alloc] init];
    communityView.backgroundColor = [UIColor whiteColor];
    NNHViewRadius(communityView, 5.0);
    [self.view addSubview:communityView];
    [communityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shareView.mas_bottom).offset(10);
        make.left.right.equalTo(shareView);
        make.height.equalTo(@50);
    }];
    
    [communityView addSubview:self.bigLabel];
    [self.bigLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(communityView);
        make.left.equalTo(communityView);
        make.right.equalTo(communityView.mas_centerX);
    }];
    
    [communityView addSubview:self.smallLabel];
    [self.smallLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(communityView);
        make.right.equalTo(communityView);
        make.left.equalTo(communityView.mas_centerX);
    }];
    
    UIView *lineView = [UIView lineView];
    [communityView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(communityView);
        make.top.equalTo(communityView).offset(10);
        make.bottom.equalTo(communityView).offset(-10);
        make.width.equalTo(@.5);
    }];
}

#pragma mark - Network Methods
- (void)requestPointDataSource
{
    NSString *username = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.username;
    NNHWeakSelf(self)
    NNAPIBlockPointTool *searchTool = [[NNAPIBlockPointTool alloc] initSearchNodeWithNodeAccount:username];
    [searchTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        weakself.bigLabel.text = [NSString stringWithFormat:@"共享社区 %@",responseDic[@"data"][@"model_max"]];
        weakself.smallLabel.text = [NSString stringWithFormat:@"分享社区 %@",responseDic[@"data"][@"model_min"]];
        weakself.shareLabel.text = responseDic[@"data"][@"shareamount"];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (UILabel *)bigLabel
{
    if (_bigLabel == nil) {
        _bigLabel = [UILabel NNHWithTitle:@"共享社区 0" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextMain]];
        _bigLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bigLabel;
}

- (UILabel *)smallLabel
{
    if (_smallLabel == nil) {
        _smallLabel = [UILabel NNHWithTitle:@"分享社区 0" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextMain]];
        _smallLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _smallLabel;
}

- (UILabel *)shareLabel
{
    if (_shareLabel == nil) {
        _shareLabel = [UILabel NNHWithTitle:@"0.00" titleColor:[UIConfigManager colorThemeRed] font:[UIFont boldSystemFontOfSize:25]];
    }
    return _shareLabel;
}

@end
