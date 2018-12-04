//
//  NNMineQrCodeViewController.m
//  YWL
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
@property (nonatomic, strong) UITextField *addressTextField;
/** 提示 */
@property (nonatomic, strong) UILabel *promptLabel;
/** 手机 */
@property (nonatomic, strong) UILabel *phoneLabel;
/** 地址 */
@property (nonatomic, copy) NSString *addressStr;

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
    
    UIView *addressView = [[UIView alloc] init];
    addressView.backgroundColor = [UIColor akext_colorWithHex:@"#eeeeee"];
    NNHViewRadius(addressView, 2);
    [contentView addSubview:addressView];
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qrCodeView.mas_bottom).offset(20);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
        make.height.equalTo(@34);
    }];
    [addressView addSubview:self.addressTextField];
    [self.addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(addressView);
        make.left.equalTo(addressView).offset(10);
        make.right.equalTo(addressView).offset(-10);
    }];
    
    UIView *lineView = [UIView lineView];
    [contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressTextField.mas_bottom).offset(20);
        make.left.right.equalTo(self.addressTextField);
        make.height.equalTo(@(NNHLineH));
    }];
    
    UIButton *copyButton = [UIButton NNHBtnTitle:@"复制链接" titileFont:[UIConfigManager fontThemeTextTip] backGround:[UIColor akext_colorWithHex:@"#d1d1da"] titleColor:[UIConfigManager colorThemeRed]];
    [copyButton addTarget:self action:@selector(copyAddressAction) forControlEvents:UIControlEventTouchUpInside];
    NNHViewRadius(copyButton, NNHOperationButtonRadiu)
    [contentView addSubview:copyButton];
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(20);
        make.left.equalTo(self.qrCodeView);
        make.right.equalTo(self.addressTextField.mas_centerX).offset(-20);
        make.height.equalTo(@34);
    }];
    
    
    UIButton *saveButton = [UIButton NNHBtnTitle:@"下载图片" titileFont:[UIConfigManager fontThemeTextTip] backGround:[UIColor akext_colorWithHex:@"#d1d1da"] titleColor:[UIConfigManager colorThemeRed]];
    [saveButton addTarget:self action:@selector(saveQRCodeAction) forControlEvents:UIControlEventTouchUpInside];
    NNHViewRadius(saveButton, NNHOperationButtonRadiu)
    [contentView addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(copyButton);
        make.right.equalTo(self.qrCodeView);
        make.left.equalTo(self.addressTextField.mas_centerX).offset(20);
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
        
        weakself.promptLabel.text = responseDic[@"data"][@"content"];
        weakself.phoneLabel.text = responseDic[@"data"][@"myCode"];
        weakself.addressStr = responseDic[@"data"][@"address"];
        weakself.addressTextField.text = [NSString stringWithFormat:@"链接：%@",weakself.addressStr];
        [weakself.qrCodeView sd_setImageWithURL:[NSURL URLWithString:responseDic[@"data"][@"url"]]];
        
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (void)copyAddressAction
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.addressStr];
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
        _qrCodeView = [[UIImageView alloc] init];
        _qrCodeView.backgroundColor = NNHRGBColor(238, 238, 238);
    }
    return _qrCodeView;
}

- (UITextField *)addressTextField
{
    if (_addressTextField == nil) {
        _addressTextField = [[UITextField alloc] init];
        _addressTextField.enabled = NO;
        _addressTextField.backgroundColor = [UIColor akext_colorWithHex:@"#eeeeee"];
        _addressTextField.textColor = [UIConfigManager colorThemeDark];
        _addressTextField.font = [UIConfigManager fontThemeTextTip];
        _addressTextField.textAlignment = NSTextAlignmentCenter;
        NNHViewRadius(_addressTextField, 2);
    }
    return _addressTextField;
}

- (UILabel *)promptLabel
{
    if (_promptLabel == nil) {
        _promptLabel = [UILabel NNHWithTitle:@"扫描二维码注册" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeLargerBtnTitles]];
    }
    return _promptLabel;
}

- (UILabel *)phoneLabel
{
    if (_phoneLabel == nil) {
        _phoneLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextImportant]];
        _phoneLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _phoneLabel;
}

@end
