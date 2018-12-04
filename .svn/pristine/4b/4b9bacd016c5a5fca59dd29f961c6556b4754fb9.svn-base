//
//  NNMineQrCodeViewController.m
//  NBTMill
//
//  Created by 牛牛 on 2018/3/20.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNMineQrCodeViewController.h"
#import "NNAPIMineTool.h"

@interface NNMineQrCodeViewController ()

/** 二维码 */
@property (nonatomic, strong) UIImageView *qrCodeView;
/** 二维码地址 */
@property (nonatomic, strong) UILabel *addressLabel;
/** 提示 */
@property (nonatomic, strong) UILabel *promptLabel;
/** 手机 */
@property (nonatomic, strong) UILabel *phoneLabel;

@end

@implementation NNMineQrCodeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeWhite];
    
    [self setupChildView];
    
    [self requestDataSource];
}

- (void)setupChildView
{
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"code_bg" ofType:@"png"]]];
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    NNHViewRadius(contentView, 10.0);
    [self.view addSubview:contentView];
    
    [contentView addSubview:self.promptLabel];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(50);
        make.centerX.equalTo(contentView);
    }];
    
    [contentView addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.promptLabel.mas_bottom).offset(20);
        make.centerX.equalTo(contentView);
    }];
    
    [self.view addSubview:self.qrCodeView];
    [self.qrCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLabel.mas_bottom).offset(20);
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    
    [contentView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qrCodeView.mas_bottom).offset(20);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
        make.height.equalTo(@34);
    }];
    
    UIView *lineView = [UIView lineView];
    [contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressLabel.mas_bottom).offset(20);
        make.left.right.equalTo(self.addressLabel);
        make.height.equalTo(@(NNHLineH));
    }];
    
    UIButton *copyButton = [UIButton NNHOperationBtnWithTitle:@"复制链接" target:self action:@selector(copyAddressAction) operationButtonType:NNHOperationButtonTypeBlue isAddCornerRadius:YES];
    [copyButton.titleLabel setFont:[UIConfigManager fontThemeTextTip]];
    [contentView addSubview:copyButton];
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(20);
        make.left.equalTo(self.qrCodeView);
        make.right.equalTo(self.addressLabel.mas_centerX).offset(-20);
        make.height.equalTo(@34);
    }];
    
    UIButton *saveButton = [UIButton NNHOperationBtnWithTitle:@"下载图片" target:self action:@selector(saveQRCodeAction) operationButtonType:NNHOperationButtonTypeBlue isAddCornerRadius:YES];
    [saveButton.titleLabel setFont:[UIConfigManager fontThemeTextTip]];
    [contentView addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(copyButton);
        make.right.equalTo(self.qrCodeView);
        make.left.equalTo(self.addressLabel.mas_centerX).offset(20);
        make.height.equalTo(copyButton);
    }];
    
    // 根据最后一个控件计算当前控件约束
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(40);
        make.width.equalTo(@(SCREEN_WIDTH - 40));
        make.bottom.equalTo(saveButton).offset(50);
    }];
    
}

- (void)requestDataSource
{
    NNAPIMineTool *userTool = [[NNAPIMineTool alloc] initMyQrCode];
    NNHWeakSelf(self)
    [userTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        
        weakself.promptLabel.text = responseDic[@"data"][@"topcontent"];
        weakself.phoneLabel.text = responseDic[@"data"][@"moble"];
        weakself.addressLabel.text = [NSString stringWithFormat:@"地址：%@",responseDic[@"data"][@"address"]];
        [weakself.qrCodeView sd_setImageWithURL:[NSURL URLWithString:responseDic[@"data"][@"url"]] placeholderImage:ImageName(@"ic_mine_QrCode")];
        
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (void)copyAddressAction
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.addressLabel.text;
    [SVProgressHUD showMessage:@"复制成功"];
}

- (void)saveQRCodeAction
{
    UIImage *image = self.qrCodeView.image;
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        [SVProgressHUD showMessage:@"保存成功"];
    }
}

- (UIImageView *)qrCodeView
{
    if (_qrCodeView == nil) {
        _qrCodeView = [[UIImageView alloc] initWithImage:ImageName(@"ic_mine_QrCode")];
    }
    return _qrCodeView;
}

- (UILabel *)addressLabel
{
    if (_addressLabel == nil) {
        _addressLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextTip]];
        _addressLabel.backgroundColor = [UIColor akext_colorWithHex:@"#eeeeee"];
        _addressLabel.textAlignment = NSTextAlignmentCenter;
        NNHViewRadius(_addressLabel, 2);
    }
    return _addressLabel;
}

- (UILabel *)promptLabel
{
    if (_promptLabel == nil) {
        _promptLabel = [UILabel NNHWithTitle:@"扫描二维码注册NBT" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeLargerBtnTitles]];
    }
    return _promptLabel;
}

- (UILabel *)phoneLabel
{
    if (_phoneLabel == nil) {
        _phoneLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextImportant]];
    }
    return _phoneLabel;
}

@end
