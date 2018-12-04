//
//  NNMineFundScanViewController.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/4.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMineFundScanViewController.h"
#import "NNHAPITradingTool.h"

@interface NNMineFundScanViewController ()

/** 充值地址 */
@property (nonatomic, strong) UIImageView *addressImageView;

@end

@implementation NNMineFundScanViewController

#pragma mark - Life Cycle Methods
- (void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"充值资产";
    [self setupChildView];
    
    [self requestCodeData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIConfigManager colorThemeWhite];
    contentView.layer.cornerRadius = NNHMargin_5;
    contentView.layer.masksToBounds = YES;
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NNHMargin_15);
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
        make.height.equalTo(@(SCREEN_WIDTH + 30));
    }];
    
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIConfigManager colorThemeWhite];
    [contentView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(contentView);
        make.height.equalTo(@(60));
    }];
    
    UIView *addressView = [[UIView alloc] init];
    addressView.backgroundColor = [UIConfigManager colorThemeWhite];
    [contentView addSubview:addressView];
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(contentView);
        make.top.equalTo(titleView.mas_bottom);
    }];

    [addressView addSubview:self.addressImageView];
    [self.addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(addressView);
        make.width.equalTo(addressView.mas_width).multipliedBy(0.75);
        make.height.equalTo(self.addressImageView.mas_width);
    }];
    
    UILabel *infoLabel = [UILabel NNHWithTitle:@"扫一扫向我转账" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
    [addressView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressImageView.mas_bottom);
        make.centerX.equalTo(addressView);
        make.bottom.equalTo(addressView);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    [contentView addSubview:lineView];
    lineView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.height.equalTo(@(1));
        make.top.equalTo(titleView.mas_bottom);
    }];
    
    UIImageView *titleImageView = [[UIImageView alloc] init];
    titleImageView.image = [UIImage imageNamed:@"head_small_transfer"];
    [titleView addSubview:titleImageView];
    [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView).offset(NNHMargin_15);
        make.centerY.equalTo(titleView);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    UILabel *nameLabel = [UILabel NNHWithTitle:@"NBT" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextMain]];
    [titleView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleImageView.mas_right).offset(NNHMargin_10);
        make.bottom.equalTo(titleView.mas_centerY).offset(-NNHMargin_5);
    }];
    
    UILabel *messageLabel = [UILabel NNHWithTitle:@"C2C转账" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
    [titleView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.top.equalTo(titleView.mas_centerY).offset(NNHMargin_5);
    }];
}

#pragma mark - Network Methods
- (void)requestCodeData
{
    NNHWeakSelf(self)
    NNHAPITradingTool *tradeTool = [[NNHAPITradingTool alloc] initCreatReciveMineFundCodeImage];
    [tradeTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [weakself.addressImageView sd_setImageWithURL:[NSURL URLWithString:responseDic[@"data"][@"url"]]];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

#pragma mark - Target Methods
- (void)copyAction
{
    [SVProgressHUD showMessage:@"复制成功"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"";
}

#pragma mark - Lazy Loads


- (UIImageView *)addressImageView
{
    if (_addressImageView == nil) {
        _addressImageView = [[UIImageView alloc] init];
        _addressImageView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    }
    return _addressImageView;
}


@end
