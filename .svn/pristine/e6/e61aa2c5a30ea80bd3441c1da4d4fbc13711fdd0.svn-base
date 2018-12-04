//
//  NNHUploadImageView.m
//  YWL
//
//  Created by 来旭磊 on 2018/3/29.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNHUploadImageView.h"

@interface NNHUploadImageView ()

/** <#注释#> */
@property (nonatomic, copy) UIImageView *mainImageView;

/** <#注释#> */
@property (nonatomic, strong) UIImageView *cameraImageView;

/** <#注释#> */
@property (nonatomic, strong) UILabel *messageLabel;

/** 删除按钮 */
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation NNHUploadImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIConfigManager colorThemeWhite];
        [self setChildView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBlock:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self addLayer];
}

- (void)addLayer
{
    CAShapeLayer *border = [CAShapeLayer layer];
    
    //虚线的颜色
    border.strokeColor = [UIConfigManager colorThemeColorForVCBackground].CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    //设置路径
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    border.frame = self.bounds;
    //虚线的宽度
    border.lineWidth = 1.f;
    
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@4, @2];
    
    [self.layer addSublayer:border];
}

- (void)setChildView
{
    [self addSubview:self.mainImageView];
    [self addSubview:self.cameraImageView];
    [self addSubview:self.messageLabel];
    [self addSubview:self.deleteButton];
    
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.cameraImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-NNHMargin_10);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.cameraImageView.mas_bottom).offset(NNHMargin_15);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(NNHMargin_5);
        make.top.equalTo(self).offset(-NNHMargin_5);
        //        make.size.mas_equalTo(CGSizeMake(NNHMargin_20, NNHMargin_20));
        
        
    }];
}

- (void)actionBlock:(UITapGestureRecognizer *)tap
{
    
    //    if (self.displayImage) {
    //        // 1.创建图片浏览器
    //        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    //        // 2.设置图片浏览器显示的所有图片
    //        NSMutableArray *photos = [NSMutableArray array];
    //
    //        MJPhoto *photo = [[MJPhoto alloc] init];
    //        // 设置图片的路径
    //        photo.url = [NSURL URLWithString:self.uploadUrl];
    //        // 设置来源于哪一个UIImageView
    //        photo.srcImageView = self.mainImageView;
    //        [photos addObject:photo];
    //        browser.photos = photos;
    //        // 4.设置默认显示的图片索引
    //        browser.currentPhotoIndex = 0;
    //        // 5.显示浏览器
    //        [browser show];
    //
    //        return;
    //    }
    
    NNHUploadImageView *uploadView = (NNHUploadImageView *)tap.view;
    
    if (self.actionBlcok) {
        self.actionBlcok(uploadView);
    }
}

- (void)deleteButtonAction
{
    self.mainImageView.image = nil;
    self.displayImage = nil;
    self.cameraImageView.hidden = self.messageLabel.hidden = NO;
    self.deleteButton.hidden = YES;
    self.uploadUrl = nil;
}

- (void)setDisplayImage:(UIImage *)displayImage
{
    _displayImage = displayImage;
    self.mainImageView.image = displayImage;
    self.cameraImageView.hidden = self.messageLabel.hidden = YES;
    self.deleteButton.hidden = NO;
}

- (void)setMessage:(NSString *)message
{
    _message = message;
    self.messageLabel.text = message;
}

- (UIImageView *)mainImageView
{
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] init];
    }
    return _mainImageView;
}

- (UIImageView *)cameraImageView
{
    if (_cameraImageView == nil) {
        _cameraImageView = [[UIImageView alloc] init];
        _cameraImageView.image = [UIImage imageNamed:@"Idcardaddition"];
    }
    return _cameraImageView;
}

- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        _messageLabel = [UILabel NNHWithTitle:@"" titleColor:[UIColor akext_colorWithHex:@"#a6a6a6"] font:[UIConfigManager fontThemeTextImportant]];
    }
    return _messageLabel;
}

- (UIButton *)deleteButton
{
    if (_deleteButton == nil) {
        _deleteButton = [UIButton NNHBtnImage:@"" target:self action:@selector(deleteButtonAction)];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"wrong"] forState:UIControlStateNormal];
        _deleteButton.hidden = YES;
    }
    return _deleteButton;
}

@end
