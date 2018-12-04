//
//  NNHAmountChangeButton.m
//  WTA
//
//  Created by 来旭磊 on 2018/9/10.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNHAmountChangeButton.h"

@interface NNHAmountChangeButton ()<UITextFieldDelegate>
/** 减少按钮 */
@property (nonatomic, strong) UIButton *reduceButton;
/** 增加按钮 */
@property (nonatomic, strong) UIButton *addButton;
/** 输入框 */
@property (nonatomic, strong) UITextField *countTextField;

@end

@implementation NNHAmountChangeButton


#pragma mark - Initial Methods

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIConfigManager colorThemeWhite];
        
        _minValue = 1;
        _maxValue = NSIntegerMax;
        
        [self setupChildView];
        
        [self changeButtonStatusWithNumber:_minValue];
    }
    return self;
}

- (void)setupChildView
{
    [self addSubview:self.addButton];
    [self addSubview:self.reduceButton];
    [self addSubview:self.countTextField];
    
    [self.reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.height.equalTo(self.addButton.mas_width);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.size.equalTo(self.reduceButton);
    }];
    
    [self.countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.reduceButton.mas_right).offset(2);
        make.right.equalTo(self.addButton.mas_left).offset(-2);
    }];

}

#pragma mark - Lazy Loads

- (void)changeButtonStatusWithNumber:(NSInteger)number
{
    self.countTextField.text = [NSString stringWithFormat:@"%ld", number];
    
    // 点击加号
    if (number >= self.maxValue) {
        self.addButton.enabled = NO;
    }else {
        self.addButton.enabled = YES;
    }
    
    if (number > self.minValue) {
        self.reduceButton.enabled = YES;
    }
    
    // 点击减号
    if (number <= self.minValue) {
        self.reduceButton.enabled = NO;
    }else {
        
        self.reduceButton.enabled = YES;
    }
    
    if (number < self.maxValue) {
        self.addButton.enabled = YES;
    }
}

- (void)addButtonAction:(UIButton *)button
{
    NSInteger number = self.countTextField.text.integerValue + 1;
    
    [self changeButtonStatusWithNumber:number];
    
    if (self.resultBlock) {
        self.resultBlock(self.countTextField.text.integerValue);
    }
}

- (void)reduceButtonAction:(UIButton *)button
{
    NSInteger number = self.countTextField.text.integerValue - 1;
    
    [self changeButtonStatusWithNumber:number];
    
    if (number < self.maxValue) {
        self.addButton.enabled = YES;
    }
    
    if (self.resultBlock) {
        self.resultBlock(self.countTextField.text.integerValue);
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidChange:(UITextField *)textField
{
    
    if (self.resultBlock) {
        self.resultBlock(textField.text.integerValue);
    }
}

#pragma mark - Target Methods

#pragma mark - Public Methods

#pragma mark - Private Methods

- (void)setCurrentNumber:(NSInteger)currentNumber
{
    _currentNumber = currentNumber;

    [self changeButtonStatusWithNumber:currentNumber];
}

#pragma mark - Lazy Loads

- (UIButton *)reduceButton
{
    if (_reduceButton == nil) {
        _reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reduceButton setBackgroundColor:[UIConfigManager colorThemeColorForVCBackground]];
        [_reduceButton setBackgroundImage:ImageName(@"ic_minus") forState:UIControlStateNormal];
        [_reduceButton setBackgroundImage:ImageName(@"ic_minus_dis") forState:UIControlStateDisabled];
        [_reduceButton addTarget:self action:@selector(reduceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _reduceButton.adjustsImageWhenHighlighted = NO;
        _reduceButton.layer.cornerRadius = 2;
        _reduceButton.layer.masksToBounds = YES;
    }
    return _reduceButton;
}

- (UIButton *)addButton
{
    if (_addButton == nil) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setBackgroundColor:[UIConfigManager colorThemeColorForVCBackground]];
        [_addButton setBackgroundImage:ImageName(@"ic_add") forState:UIControlStateNormal];
        [_addButton setBackgroundImage:ImageName(@"ic_add_dis") forState:UIControlStateDisabled];
        [_addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _addButton.adjustsImageWhenHighlighted = NO;
        _addButton.layer.cornerRadius = 2;
        _addButton.layer.masksToBounds = YES;
    }
    return _addButton;
}

- (UITextField *)countTextField
{
    if (_countTextField == nil) {
        _countTextField = [[UITextField alloc]init];
        _countTextField.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        _countTextField.font = [UIConfigManager fontThemeTextDefault];
        _countTextField.textColor = [UIConfigManager colorThemeBlack];
        _countTextField.delegate = self;
        _countTextField.textAlignment = NSTextAlignmentCenter;
        _countTextField.keyboardType = UIKeyboardTypeNumberPad;
        _countTextField.layer.cornerRadius = 2;
        _countTextField.layer.masksToBounds = YES;
        [_countTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _countTextField;
}

@end

