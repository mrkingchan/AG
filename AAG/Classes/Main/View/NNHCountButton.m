//
//  NNHCountButton.m
//  WBTMall
//
//  Created by 来旭磊 on 2017/6/30.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHCountButton.h"

@interface NNHCountButton ()<UITextFieldDelegate>

/** 加按钮*/
@property (nonatomic, strong) UIButton *increaseBtn;

/** 减按钮*/
@property (nonatomic, strong) UIButton *decreaseBtn;

/** 数量展示/输入框*/
@property (nonatomic, strong) UITextField *textField;

/** 快速加减定时器*/
@property (nonatomic, strong) NSTimer *timer;

/** 控件自身的宽*/
@property (nonatomic, assign) CGFloat width;

/** 控件自身的高*/
@property (nonatomic, assign) CGFloat height;

@end

@implementation NNHCountButton

- (void)dealloc
{
    
}

#pragma mark - #pragma mark - Life Cycle Methods
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupChildView];
        //整个控件的默认尺寸(和某宝上面的按钮同样大小)
        if(CGRectIsEmpty(frame)) {self.frame = CGRectMake(0, 0, 110, 30);};
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupChildView];
    }
    return self;
}

+ (instancetype)countButtonWithFrame:(CGRect)frame
{
    return [[NNHCountButton alloc] initWithFrame:frame];
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 3.f;
    self.layer.masksToBounds = YES;
    
    _maxValue = NSIntegerMax;
    _minValue = 1;
    _inputFieldFont = 14;
    _buttonTitleFont = 14;
    
    //加减按钮
    _increaseBtn = [self creatButton];
    _decreaseBtn = [self creatButton];
    [self addSubview:_increaseBtn];
    [self addSubview:_decreaseBtn];
    
    //数量展示、输入框
    [self addSubview:self.textField];
}

#pragma mark - layoutSubviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _width =  self.frame.size.width;
    _height = self.frame.size.height;
    _textField.frame = CGRectMake(_height, 0, _width - 2*_height, _height);
    _increaseBtn.frame = CGRectMake(_width - _height, 0, _height, _height);
    
    if (_decreaseHide && _textField.text.integerValue < _minValue) {
        _decreaseBtn.frame = CGRectMake(_width-_height, 0, _height, _height);
    } else {
        _decreaseBtn.frame = CGRectMake(0, 0, _height, _height);
    }
}

#pragma mark - Target Methods
/** 
 点击: 单击逐次加减,长按连续快速加减 
 */
- (void)touchDown:(UIButton *)sender
{
    [_textField resignFirstResponder];
    
    if (sender == self.increaseBtn) {
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(increase) userInfo:nil repeats:YES];
        [self increase];
    }else {
        [self decrease];
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(decrease) userInfo:nil repeats:YES];
    }
//    [self.timer fire];
    
}

/**
 手指松开
 */
- (void)touchUp:(UIButton *)sender
{
    [self cleanTimer];
}

/**
 加运算
 */
- (void)increase
{
    [self checkTextFieldNumberWithUpdate];
    
    NSInteger number = self.textField.text.integerValue + 1;
    
    if (number < self.maxValue) {
        // 当按钮为"减号按钮隐藏模式",且输入框值==设定最小值,减号按钮展开
        if (_decreaseHide && number==_minValue) {
            [self rotationAnimationMethod];
            [UIView animateWithDuration:0.3f animations:^{
                _decreaseBtn.alpha = 1;
                _decreaseBtn.frame = CGRectMake(0, 0, _height, _height);
            } completion:^(BOOL finished) {
                _textField.hidden = NO;
            }];
        }
        _textField.text = [NSString stringWithFormat:@"%ld", number];
        
        [self buttonClickCallBackWithIncreaseStatus:YES];
    }else {
        if (self.shakeAnimation) {
            [self shakeAnimationMethod];
        }
    }
}

/**
 减运算
 */
- (void)decrease
{
    [self checkTextFieldNumberWithUpdate];
    
    NSInteger number = [_textField.text integerValue] - 1;
    
    if (number >= _minValue) {
        _textField.text = [NSString stringWithFormat:@"%ld", number];
        [self buttonClickCallBackWithIncreaseStatus:NO];
    } else {
        // 当按钮为"减号按钮隐藏模式",且输入框值 < 设定最小值,减号按钮隐藏
        if (_decreaseHide && number<_minValue) {
            _textField.hidden = YES;
            _textField.text = [NSString stringWithFormat:@"%ld",_minValue-1];
            
            [self buttonClickCallBackWithIncreaseStatus:NO];
            [self rotationAnimationMethod];
            
            [UIView animateWithDuration:0.3f animations:^{
                _decreaseBtn.alpha = 0;
                _decreaseBtn.frame = CGRectMake(_width-_height, 0, _height, _height);
            }];
            
            return;
        }
        if (_shakeAnimation) {
            [self shakeAnimationMethod];
        }
    }
}

#pragma mark - Private Methods

/**
 点击响应
 */
- (void)buttonClickCallBackWithIncreaseStatus:(BOOL)increaseStatus
{
    _resultBlock ? _resultBlock(_textField.text.integerValue, increaseStatus) : nil;
    
    if ([self.delegate respondsToSelector:@selector(nnh_countButton:count:increaseStatus:)]) {
        [self.delegate nnh_countButton:self count:self.textField.text.integerValue increaseStatus:increaseStatus];
    }
}


/**
 检查TextField中数字的合法性,并修正
 */
- (void)checkTextFieldNumberWithUpdate
{
    NSString *minValueString = [NSString stringWithFormat:@"%ld",_minValue];
    NSString *maxValueString = [NSString stringWithFormat:@"%ld",_maxValue];
    
    if ([_textField.text nnh_isNotBlank] == NO || _textField.text.integerValue < _minValue) {
        _textField.text = _decreaseHide ? [NSString stringWithFormat:@"%ld",minValueString.integerValue-1]:minValueString;
    }
    _textField.text.integerValue > _maxValue ? _textField.text = maxValueString : nil;
}

/**
 清除定时器
 */
- (void)cleanTimer
{
    if (_timer.isValid) {
        [_timer invalidate];
        _timer = nil;
    }
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self checkTextFieldNumberWithUpdate];
    [self buttonClickCallBackWithIncreaseStatus:NO];
}

#pragma mark - NSObject  Methods

- (void)setDecreaseHide:(BOOL)decreaseHide
{
    // 当按钮为"减号按钮隐藏模式(饿了么/百度外卖/美团外卖按钮样式)"
    if (decreaseHide) {
        if (_textField.text.integerValue <= _minValue) {
            _textField.hidden = YES;
            _decreaseBtn.alpha = 0;
            _textField.text = [NSString stringWithFormat:@"%ld",_minValue-1];
            _decreaseBtn.frame = CGRectMake(_width-_height, 0, _height, _height);
        }
        self.backgroundColor = [UIColor clearColor];
    } else {
        _decreaseBtn.frame = CGRectMake(0, 0, _height, _height);
    }
    _decreaseHide = decreaseHide;
}

//- (void)setEditing:(BOOL)editing
//{
//    _editing = editing;
//    _textField.enabled = editing;
//}

- (void)setMinValue:(NSInteger)minValue
{
    _minValue = minValue;
    _textField.text = [NSString stringWithFormat:@"%ld",minValue];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [borderColor CGColor];
    
    _decreaseBtn.layer.borderWidth = 0.5;
    _decreaseBtn.layer.borderColor = [borderColor CGColor];
    
    _increaseBtn.layer.borderWidth = 0.5;
    _increaseBtn.layer.borderColor = [borderColor CGColor];
}

- (void)setButtonTitleFont:(CGFloat)buttonTitleFont
{
    _buttonTitleFont = buttonTitleFont;
    _increaseBtn.titleLabel.font = [UIFont boldSystemFontOfSize:buttonTitleFont];
    _decreaseBtn.titleLabel.font = [UIFont boldSystemFontOfSize:buttonTitleFont];
}

- (void)setIncreaseTitle:(NSString *)increaseTitle
{
    _increaseTitle = increaseTitle;
    [_increaseBtn setTitle:increaseTitle forState:UIControlStateNormal];
}

- (void)setDecreaseTitle:(NSString *)decreaseTitle
{
    _decreaseTitle = decreaseTitle;
    [_decreaseBtn setTitle:decreaseTitle forState:UIControlStateNormal];
}

- (void)setIncreaseImage:(UIImage *)increaseImage
{
    _increaseImage = increaseImage;
//    [_increaseBtn setBackgroundImage:increaseImage forState:UIControlStateNormal];
    [_increaseBtn setImage:increaseImage forState:UIControlStateNormal];

}

- (void)setDecreaseImage:(UIImage *)decreaseImage
{
    _decreaseImage = decreaseImage;
//    [_decreaseBtn setBackgroundImage:decreaseImage forState:UIControlStateNormal];
    [_decreaseBtn setImage:decreaseImage forState:UIControlStateNormal];
}

#pragma mark - 输入框中的内容设置
- (NSInteger)currentNumber
{
    return _textField.text.integerValue;
}

- (void)setCurrentNumber:(NSInteger)currentNumber
{
    if (_decreaseHide && currentNumber < _minValue) {
        _textField.hidden = YES;
        _decreaseBtn.alpha = 0;
        _decreaseBtn.frame = CGRectMake(_width-_height, 0, _height, _height);
    } else {
        _textField.hidden = NO;
        _decreaseBtn.alpha = 1;
        _decreaseBtn.frame = CGRectMake(0, 0, _height, _height);
    }
    _textField.text = [NSString stringWithFormat:@"%ld",currentNumber];
    [self checkTextFieldNumberWithUpdate];
}

- (void)setInputFieldFont:(CGFloat)inputFieldFont
{
    _inputFieldFont = inputFieldFont;
    _textField.font = [UIFont systemFontOfSize:inputFieldFont];
}

#pragma mark - Lazy Loads

- (UITextField *)textField
{
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.font = [UIFont systemFontOfSize:_inputFieldFont];
        _textField.text = [NSString stringWithFormat:@"%ld",_minValue];
        _textField.enabled = NO;
    }
    return _textField;
}

//设置加减按钮的公共方法
- (UIButton *)creatButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:_buttonTitleFont];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchUpInside|UIControlEventTouchCancel];
    button.contentMode = UIViewContentModeCenter;
//    button.backgroundColor = [UIColor yellowColor];
    return button;
}

#pragma mark - 核心动画
/**
 抖动动画
 */
- (void)shakeAnimationMethod
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    CGFloat positionX = self.layer.position.x;
    animation.values = @[@(positionX - 10), @(positionX), @(positionX + 10)];
    animation.repeatCount = 3;
    animation.duration = 0.7;
    animation.autoreverses = YES;
    [self.layer addAnimation:animation forKey:nil];
}

/**
 旋转动画
 */
- (void)rotationAnimationMethod
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.toValue = @(M_PI * 2);
    rotationAnimation.duration = 0.3f;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [_decreaseBtn.layer addAnimation:rotationAnimation forKey:nil];
}

@end


#pragma mark - NSString分类

@implementation NSString (NNHCountButton)
- (BOOL)nnh_isNotBlank
{
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

@end


