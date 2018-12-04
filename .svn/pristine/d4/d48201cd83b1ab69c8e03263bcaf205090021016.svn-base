//
//  NNConsumerTradeAppealResultViewController.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/23.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNConsumerTradeAppealResultViewController.h"

@interface NNConsumerTradeAppealResultViewController ()

@end

@implementation NNConsumerTradeAppealResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"提交成功";
    
    UIImage *backImage = [[UIImage imageNamed:@"ic_nav_back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(leftItemClick)];
    
    [self setupChildView];
}

- (void)leftItemClick
{
    NSArray *array = self.navigationController.viewControllers;
    UIViewController *viewController = array[array.count - 3];
    
    [self.navigationController popToViewController:viewController animated:YES];
}

- (void)setupChildView
{
    UIView *contentViw = [[UIView alloc] init];
    [self.view addSubview:contentViw];
    contentViw.backgroundColor = [UIConfigManager colorThemeWhite];
    [contentViw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
    }];
    
    UIImageView *statusImageView = [[UIImageView alloc] init];
    [contentViw addSubview:statusImageView];
    statusImageView.image = [UIImage imageNamed:@"ic_successful"];
    [statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentViw);
        make.top.equalTo(contentViw).offset(60);
    }];
    
    UILabel *titleLabel = [UILabel NNHWithTitle:@"申请提交成功，工作人员确认中" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
    [contentViw addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentViw);
        make.top.equalTo(statusImageView.mas_bottom).offset(40);
    }];
    
    UILabel *messageLabel = [UILabel NNHWithTitle:@"1-5个工作日会和您联系，请耐心等候！" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
    [contentViw addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentViw);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.bottom.equalTo(contentViw).offset(-60);
    }];
}


@end
