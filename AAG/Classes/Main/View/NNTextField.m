//
//  NNTextField.m
//  YWL
//
//  Created by 牛牛 on 2018/3/16.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNTextField.h"

@interface NNTextField ()

/** 眼睛按钮 */
@property (nonatomic, strong) UIButton *secureButton;
/** 左边图片 */
@property (nonatomic, strong) UIImageView *leftImageView;

@end

@implementation NNTextField

- (instancetype)init
{
    if (self = [super init]){
        self.backgroundColor = [UIColor whiteColor];
        self.textColor = [UIConfigManager colorThemeDark];
        self.font = [UIConfigManager fontThemeTextDefault];
        NNHViewRadius(self, 5.0)
    }
    return self;
}

- (instancetype)initWithPlaceholder:(NSString *)placeholder
                          leftImage:(NSString *)leftImage
{
    if (self = [super init]){
        
        self.backgroundColor = [UIColor whiteColor];
        self.textColor = [UIConfigManager colorThemeDark];
        self.font = [UIConfigManager fontThemeTextDefault];
        NNHViewBorderRadius(self, 2.0, 0.5, [UIConfigManager colorThemeSeperatorLightGray]);
        
        self.placeholder = placeholder;
        
        // 左边图标
        if (leftImage) {
            self.leftImageView.image = [UIImage imageNamed:leftImage];
            self.leftViewMode = UITextFieldViewModeAlways;
            self.leftView = self.leftImageView;
        }
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    [super setPlaceholder:placeholder];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:[UIConfigManager colorTextLightGray],}];
}

//控制文本所在的的位置，左右缩 10
- (CGRect)textRectForBounds:(CGRect)bounds
{
    if (self.leftViewMode == UITextFieldViewModeAlways) {
        return CGRectInset( bounds , 30 , 0 );
    }else{
        return CGRectInset( bounds , 15 , 0 );
    }
}

//控制编辑文本时所在的位置，左右缩 10
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    if (self.leftViewMode == UITextFieldViewModeAlways) {
        return CGRectInset( bounds , 30 , 0 );
    }else{
        return CGRectInset( bounds , 15 , 0 );
    }
}

/**
 禁止粘贴，选中，全选功能
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:)) {//禁止粘贴
        return NO;
    }
    if (action == @selector(select:)) {//禁止选中
        return NO;
    }
    if (action == @selector(selectAll:)) {//禁止全选
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}

- (void)setShowEyes:(BOOL)showEyes
{
    _showEyes = showEyes;
    self.secureTextEntry = YES;
    self.rightView = self.secureButton;
    self.rightViewMode = showEyes ?  UITextFieldViewModeAlways : UITextFieldViewModeNever;
}

- (void)secureButtonClick:(UIButton *)button
{    
    button.selected = !button.selected;
    self.secureTextEntry = button.selected;
    
    //避免出现明文密文转换时，光标偏移的bug
    NSString *text = self.text;
    self.text = @"";
    self.text = text;
}

/** 眼睛按钮 */
- (UIButton *)secureButton
{
    if (_secureButton == nil) {
        _secureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _secureButton.frame = CGRectMake(0, 0, NNHNormalViewH, NNHNormalViewH);
        [_secureButton setImage:[UIImage imageNamed:@"eyes01"] forState:UIControlStateNormal];
        [_secureButton setImage:[UIImage imageNamed:@"eyes02"] forState:UIControlStateSelected];
        [_secureButton addTarget:self action:@selector(secureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _secureButton.adjustsImageWhenHighlighted = NO;
        _secureButton.selected = YES;
    }
    return _secureButton;
}

- (UIImageView *)leftImageView
{
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _leftImageView.contentMode = UIViewContentModeCenter;
    }
    return _leftImageView;
}

@end
