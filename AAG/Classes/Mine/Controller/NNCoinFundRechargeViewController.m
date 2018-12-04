//
//  NNCoinFundRechargeViewController.m
//  NBTMill
//
//  Created by 来旭磊 on 2018/4/28.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNCoinFundRechargeViewController.h"

@interface NNCoinFundRechargeViewController ()

/** 充值地址 */
@property (nonatomic, strong) UIImageView *addressImageView;

/**  */
@property (nonatomic, strong) UILabel *messageLabel;
@end

@implementation NNCoinFundRechargeViewController

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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


#pragma mark - Initial Methods
- (void)setupChildView
{
    UIView *messageView = [[UIView alloc] init];
    [self.view addSubview:messageView];
    messageView.backgroundColor = [UIColor akext_colorWithHex:@"#dde2f4"];
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    UILabel *messageLabel = [UILabel NNHWithTitle:@"NBT钱包地址禁止充值除NBT之外的其他资产，任何非NBT资产充值将不可找回" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextTip]];
    messageLabel.numberOfLines = 2;
    [messageView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(messageView).offset(NNHMargin_15);
        make.top.height.equalTo(messageView);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIConfigManager colorThemeWhite];
    contentView.layer.cornerRadius = NNHMargin_5;
    contentView.layer.masksToBounds = YES;
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(messageView.mas_bottom).offset(NNHMargin_15);
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
        make.height.equalTo(contentView.mas_width);
    }];
    
    [contentView addSubview:self.addressImageView];
    [self.addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(contentView);
        make.width.equalTo(contentView.mas_width).multipliedBy(0.5);
        make.height.equalTo(self.addressImageView.mas_width);
    }];

    [self.view addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom);
        make.centerX.equalTo(contentView);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    UIView *addressView = [[UIView alloc] init];
    addressView.backgroundColor = [UIConfigManager colorThemeWhite];
    addressView.layer.cornerRadius = NNHMargin_5;
    addressView.layer.masksToBounds = YES;
    [self.view addSubview:addressView];
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLabel.mas_bottom);
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    UILabel *addressLabel = [UILabel NNHWithTitle:@"地址：jsdfgjsdgfjhdsgjhfjdsgfhdshjfgdshjfghjdsg" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
    [addressView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressView).offset(NNHMargin_10);
        make.centerY.equalTo(addressView);
        make.width.equalTo(@(SCREEN_WIDTH - 50));
    }];
    
    UIButton *copyButton = [self createButtonWithTitle:@"复制链接" action:@selector(copyAction)];
    [self.view addSubview:copyButton];
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_centerX).offset(-NNHMargin_10);
        make.top.equalTo(addressView.mas_bottom).offset(NNHMargin_15);
        make.size.mas_equalTo(CGSizeMake(75, 24));
    }];
    
    UIButton *downloadButton = [self createButtonWithTitle:@"下载图片" action:@selector(downloadAction)];
    [self.view addSubview:downloadButton];
    [downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).offset(NNHMargin_10);
        make.top.equalTo(addressView.mas_bottom).offset(NNHMargin_15);
        make.size.mas_equalTo(CGSizeMake(75, 24));
    }];
}

- (void)copyAction
{
    [SVProgressHUD showMessage:@"复制成功"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"";
}

- (void)downloadAction
{
    UIImageWriteToSavedPhotosAlbum(self.addressImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error == nil) {
        
        [SVProgressHUD showMessage:@"已存入手机相册"];
    }else{
        [SVProgressHUD showMessage:@"保存失败"];
    }
}
#pragma mark - UITableViewDataSource

#pragma mark - UITableViewDelegate

#pragma mark - UITextFieldDelegate

#pragma mark - Network Methods

#pragma mark - Target Methods

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Lazy Loads

- (UIImageView *)addressImageView
{
    if (_addressImageView == nil) {
        _addressImageView = [[UIImageView alloc] init];
        _addressImageView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    }
    return _addressImageView;
}

- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        _messageLabel = [UILabel NNHWithTitle:@"我的充资产地址（点击复制）" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _messageLabel;
}

- (UIButton *)createButtonWithTitle:(NSString *)title action:(nonnull SEL)sel
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIConfigManager fontThemeTextTip];
    button.backgroundColor = [UIConfigManager colorThemeRed];
    button.layer.cornerRadius = 4;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}


@end
