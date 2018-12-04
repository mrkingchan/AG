//
//  NNConsumerTradeDetailOrderPayMessageView.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/22.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNConsumerTradeDetailOrderPayMessageView.h"
#import "UIViewController+NNHExtension.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface NNConsumerTradeDetailOrderPayMessageView ()

/** 顶部 */
@property (nonatomic, weak) UILabel *titleLabel;
/** 选择支付方式view */
@property (nonatomic, strong) UIView *selectedView;
/** 选择支付方式标题 */
@property (nonatomic, weak) UILabel *selectedPayTitlelabel;
/** 显示支付方式 */
@property (nonatomic, strong) UILabel *payTypeLabel;
/** 支付方式选择箭头 */
@property (nonatomic, weak) UIImageView *arrowImage;

/** 支付信息内容 */
@property (nonatomic, strong) UIView *contentVeiw;
/** 账户姓名 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 所属银行 或账号 */
@property (nonatomic, strong) UILabel *accountNameLabel;
/** 银行卡号 */
@property (nonatomic, strong) UILabel *bankNumLabel;
/** 凭证 */
@property (nonatomic, strong) UILabel *voucherLabel;
/** 上传按钮 */
@property (nonatomic, strong) UILabel *uploadLabel;
/** 再次上传按钮 */
@property (nonatomic, strong) UILabel *uploadAgainLabel;
/** 支付照片 */
@property (nonatomic, strong) UIImageView *bankImageView;
/** 查看支付大图 */
@property (nonatomic, strong) UILabel *lookImageLabel;
/** 显示凭证图片 需要一个 imageView */
@property (nonatomic, weak) UIImageView *voucherImageView;

@end

@implementation NNConsumerTradeDetailOrderPayMessageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIConfigManager colorThemeWhite];
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    UILabel *titleLabel = [UILabel NNHWithTitle:@"支付信息" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(NNHMargin_15);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(NNHLineH));
        make.bottom.equalTo(titleLabel.mas_bottom);
    }];
    
    [self addSubview:self.selectedView];
    [self addSubview:self.contentVeiw];

}

- (void)selectedPayTypeAction
{
    UIViewController *controller = [UIViewController currentViewController];
    
    NNHWeakSelf(self)
    [[NNHAlertTool shareAlertTool] showActionSheet:controller title:nil message:nil acttionTitleArray:self.orderModel.payTypeTitleArray confirm:^(NSInteger index) {
        
        [weakself changePayTypeWithPayModel:weakself.orderModel.payTypeArray[index]];
    } cancle:^{
        
    }];
}

- (void)setOrderModel:(NNConsumerOrderDetailModel *)orderModel
{
    _orderModel = orderModel;

    if (self.orderModel.payimg.length) {
        self.voucherLabel.text = @"付款凭证：有";
        self.uploadLabel.text = @"查看凭证";
    }else {
        self.voucherLabel.text = @"付款凭证：无";
        self.uploadLabel.text = @"去上传凭证";
    }
    
    //判断是卖家 且没有支付方式为0时
    BOOL sellFlag = ![orderModel.orderstatus.type isEqualToString:@"1"] && orderModel.payTypeArray.count == 0;
    
    if (sellFlag) {
        //卖单
        self.selectedView.hidden = YES;
        
        [self.contentVeiw mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.width.equalTo(@(SCREEN_WIDTH));
            make.height.equalTo(@(40));
            make.bottom.equalTo(self);
        }];
        
        //卖单只显示 查看凭证 不显示 银行卡信息
        self.nameLabel.hidden = self.accountNameLabel.hidden = self.bankNumLabel.hidden = self.bankImageView.hidden = YES;
        self.voucherLabel.hidden = self.uploadLabel.hidden = NO;
        
        [self.voucherLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentVeiw).offset(NNHMargin_15);
            make.centerY.equalTo(self.contentVeiw);
        }];
        
        [self.uploadLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.voucherLabel);
            make.left.equalTo(self.voucherLabel.mas_right).offset(NNHMargin_20);
        }];
        
    }else {
        //买单
        self.selectedView.hidden = NO;

        [self.selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.width.equalTo(@(SCREEN_WIDTH));
            make.height.equalTo(@(NNHNormalViewH));
        }];

        [self.contentVeiw mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self.selectedView.mas_bottom);
            make.width.equalTo(@(SCREEN_WIDTH));
            make.height.equalTo(@(160));
            make.bottom.equalTo(self);
        }];

        //选择支付方式
        if (orderModel.payTypeArray.count) {
            if (self.orderModel.selectedPaytypeModel) {
                [self changePayTypeWithPayModel:self.orderModel.selectedPaytypeModel];
            }else {
                [self changePayTypeWithPayModel:orderModel.payTypeArray[0]];
            }
        }
    }
    
    self.uploadLabel.hidden = ![self.orderModel.orderstatus.acttype isEqualToString:@"1"];

    if (self.orderModel.payimg.length) {
        self.uploadLabel.hidden = NO;
    }
    
    self.voucherImageView.userInteractionEnabled = !self.uploadLabel.hidden;
    
    if (orderModel.payTypeArray.count == 1) {
        [self canSelectPaytype:YES];
    }else {
        [self canSelectPaytype:NO];
    }
    
    if (![orderModel.orderstatus.type isEqualToString:@"1"]) {
        self.uploadAgainLabel.hidden = YES;
    }else {
        self.uploadAgainLabel.hidden = self.orderModel.payimg.length == 0;
    }
    
    if ([orderModel.orderstatus.statusstr isEqualToString:@"已成交"]) {
        self.uploadAgainLabel.hidden = YES;
    }
}

- (void)changePayTypeWithPayModel:(NNConsumerOrderDetailPayTypeModel *)payTypeModel
{
    if (self.changedPaytypeBlock) {
        self.changedPaytypeBlock(payTypeModel);
    }
    self.orderModel.selectedPaytypeModel = payTypeModel;
    
    self.payTypeLabel.text = payTypeModel.bank;
    
    if ([payTypeModel.bank containsString:@"银行"] ) {
        self.bankNumLabel.hidden = NO;
        [self.voucherLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.bankNumLabel.mas_bottom).offset(NNHMargin_15);
        }];
    }else {
        self.bankNumLabel.hidden = YES;
        [self.voucherLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.accountNameLabel.mas_bottom).offset(NNHMargin_15);
        }];
    }
    
    [self.uploadLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.voucherLabel);
        make.left.equalTo(self.voucherLabel.mas_right).offset(NNHMargin_20);
    }];
    
    [self.voucherImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.uploadLabel);
    }];
    
    self.nameLabel.text = [NSString stringWithFormat:@"账号姓名：%@",payTypeModel.name];
    
    self.bankImageView.hidden = YES;
    if ([payTypeModel.bank containsString:@"银行"]) {
        self.accountNameLabel.text = [NSString stringWithFormat:@"所属银行：%@",payTypeModel.bank];
        self.bankNumLabel.text = [NSString stringWithFormat:@"银行卡号：%@",payTypeModel.bankcard];
    }else if ([payTypeModel.bank isEqualToString:@"支付宝"]) {
        self.accountNameLabel.text = [NSString stringWithFormat:@"账       号：%@",payTypeModel.bankcard];
        
        [self.bankImageView sd_setImageWithURL:[NSURL URLWithString:payTypeModel.zhifubao_img] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            self.bankImageView.hidden = NO;
        }];
    }else {
        self.accountNameLabel.text = [NSString stringWithFormat:@"账       号：%@",payTypeModel.bankcard];
        
        [self.bankImageView sd_setImageWithURL:[NSURL URLWithString:payTypeModel.weixin_img] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            self.bankImageView.hidden = NO;
        }];
    }
    
    [self.bankImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_contentVeiw).offset(-NNHMargin_15);
        make.top.equalTo(_contentVeiw).offset(NNHMargin_20);
        make.width.equalTo(self.bankImageView.mas_height);
        make.bottom.equalTo(_contentVeiw).offset(-NNHMargin_20);
    }];
    
    [self.uploadAgainLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.voucherLabel);
        make.left.equalTo(self.uploadLabel.mas_right).offset(NNHMargin_15);
    }];
    
    [self layoutIfNeeded];
}

/** 是否已选择 支付方式 修改UI */
- (void)canSelectPaytype:(BOOL)selected
{
    if (selected) {
        self.selectedPayTitlelabel.text = @"支付方式";
        [self.payTypeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.selectedView).offset(-NNHMargin_15);
            make.centerY.equalTo(_selectedView);
            make.height.equalTo(@(40));
        }];
    }else {
        self.selectedPayTitlelabel.text = @"选择支付方式：";
        [self.payTypeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrowImage.mas_left).offset(-NNHMargin_5);
            make.centerY.equalTo(_selectedView);
            make.height.equalTo(@(40));
        }];
    }
    
    self.selectedView.userInteractionEnabled = !selected;
}

- (void)voucherAction
{
    if (self.voucherActionBlock) {
        self.voucherActionBlock(self.voucherImageView);
    }
}

- (void)uploadAgainAction
{
    if (self.uploadAgainActionBlock) {
        self.uploadAgainActionBlock();
    }
}

- (void)scanBigImage
{
    // 1.创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 2.设置图片浏览器显示的所有图片
    NSMutableArray *photos = [NSMutableArray array];

    MJPhoto *photo = [[MJPhoto alloc] init];
    
    // 设置图片的路径
    photo.image = self.bankImageView.image;
    
    // 设置来源于哪一个UIImageView
    photo.srcImageView = self.bankImageView;
    [photos addObject:photo];
    
    browser.photos = photos;
    // 4.设置默认显示的图片索引
    browser.currentPhotoIndex = 0;
    // 5.显示浏览器
    [browser show];
}

#pragma mark - Lazy Loads

- (UIView *)selectedView
{
    if (_selectedView == nil) {
        _selectedView = [[UIView alloc] init];
        _selectedView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedPayTypeAction)];
        [_selectedView addGestureRecognizer:tap];
        
        UIView *lineView2 = [[UIView alloc] init];
        lineView2.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        [_selectedView addSubview:lineView2];
        [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_selectedView);
            make.width.equalTo(@(SCREEN_WIDTH));
            make.height.equalTo(@(NNHLineH));
            make.bottom.equalTo(_selectedView);
        }];
        
        UILabel *titleLabel = [UILabel NNHWithTitle:@"选择支付方式：" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
        [_selectedView addSubview:titleLabel];
        self.selectedPayTitlelabel = titleLabel;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_selectedView).offset(NNHMargin_15);
            make.centerY.equalTo(_selectedView);
        }];

        UIImageView *arrowImage = [[UIImageView alloc] init];
        [_selectedView addSubview:arrowImage];
        self.arrowImage = arrowImage;
        arrowImage.image = [UIImage imageNamed:@"mine_order_arrow"];
        [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_selectedView).offset(-NNHMargin_15);
            make.centerY.equalTo(_selectedView);
        }];

        [_selectedView addSubview:self.payTypeLabel];
        [self.payTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(arrowImage.mas_left).offset(-NNHMargin_5);
            make.centerY.equalTo(_selectedView);
            make.height.equalTo(@(40));
        }];
        
    }
    return _selectedView;
}

- (UILabel *)payTypeLabel
{
    if (_payTypeLabel == nil) {
        _payTypeLabel = [UILabel NNHWithTitle:@"银行卡" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
        _payTypeLabel.backgroundColor = [UIConfigManager colorThemeWhite];
    }
    return _payTypeLabel;
}

- (UIView *)contentVeiw
{
    if (_contentVeiw == nil) {
        _contentVeiw = [[UIView alloc] init];
        _contentVeiw.backgroundColor = [UIConfigManager colorThemeWhite];
        
        [_contentVeiw addSubview:self.nameLabel];
        [_contentVeiw addSubview:self.accountNameLabel];
        [_contentVeiw addSubview:self.bankNumLabel];
        [_contentVeiw addSubview:self.voucherLabel];
        [_contentVeiw addSubview:self.bankImageView];
        [_contentVeiw addSubview:self.uploadLabel];
        [_contentVeiw addSubview:self.uploadAgainLabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_contentVeiw).offset(NNHMargin_15);
            make.top.equalTo(_contentVeiw).offset(NNHMargin_15);
        }];

        [self.accountNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(NNHMargin_15);
        }];
        
        [self.bankNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.accountNameLabel.mas_bottom).offset(NNHMargin_15);
        }];

        [self.voucherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.bankNumLabel.mas_bottom).offset(NNHMargin_15);
        }];

        [self.uploadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.voucherLabel);
            make.left.equalTo(self.bankImageView.mas_left).offset(NNHMargin_15);
        }];
        
        [self.uploadAgainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.voucherLabel);
            make.left.equalTo(self.uploadLabel.mas_right).offset(NNHMargin_15);
        }];

        UIImageView *voucherImageView = [[UIImageView alloc] init];
        [_contentVeiw addSubview:voucherImageView];
        voucherImageView.userInteractionEnabled = YES;
        self.voucherImageView = voucherImageView;
        voucherImageView.backgroundColor = [UIColor clearColor];
        [voucherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.uploadLabel);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(voucherAction)];
        [voucherImageView addGestureRecognizer:tap];
    }
    
    return _contentVeiw;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel NNHWithTitle:@"账户姓名：" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
    }
    return _nameLabel;
}

- (UILabel *)accountNameLabel
{
    if (_accountNameLabel == nil) {
        _accountNameLabel = [UILabel NNHWithTitle:@"所属银行：" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
    }
    return _accountNameLabel;
}

- (UILabel *)bankNumLabel
{
    if (_bankNumLabel == nil) {
        _bankNumLabel = [UILabel NNHWithTitle:@"银行卡号：" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
    }
    return _bankNumLabel;
}

- (UILabel *)voucherLabel
{
    if (_voucherLabel == nil) {
        _voucherLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextTip]];
    }
    return _voucherLabel;
}

- (UIImageView *)bankImageView
{
    if (_bankImageView == nil) {
        _bankImageView = [[UIImageView alloc] init];
        _bankImageView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        [_bankImageView addSubview:self.lookImageLabel];
        _bankImageView.userInteractionEnabled = YES;
        [self.lookImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(_bankImageView);
            make.height.equalTo(@(30));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImage)];
        [_bankImageView addGestureRecognizer:tap];
    }
    return _bankImageView;
}

- (UILabel *)uploadLabel
{
    if (_uploadLabel == nil) {
        _uploadLabel = [UILabel NNHWithTitle:@"去上传" titleColor:[UIColor redColor] font:[UIConfigManager fontThemeTextTip]];
    }
    return _uploadLabel;
}

- (UILabel *)uploadAgainLabel
{
    if (_uploadAgainLabel == nil) {
        _uploadAgainLabel = [UILabel NNHWithTitle:@"重新上传" titleColor:[UIColor redColor] font:[UIConfigManager fontThemeTextTip]];
        _uploadAgainLabel.userInteractionEnabled = YES;
        _uploadAgainLabel.hidden = YES;
        UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadAgainAction)];
        [_uploadAgainLabel addGestureRecognizer:tapAction];
    }
    return _uploadAgainLabel;
}

- (UILabel *)lookImageLabel
{
    if (_lookImageLabel == nil) {
        _lookImageLabel = [UILabel NNHWithTitle:@"点击查看大图" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextTip]];
        _lookImageLabel.backgroundColor = [[UIConfigManager colorThemeBlack] colorWithAlphaComponent:0.2];
        _lookImageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _lookImageLabel;
}


@end
