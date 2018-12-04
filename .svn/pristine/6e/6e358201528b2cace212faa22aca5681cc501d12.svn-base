//
//  NNMineOperationDeatilTableHeaderView.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/14.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMineOperationDeatilTableHeaderView.h"

@interface NNMineOperationDeatilTableHeaderView ()

/** 头部 */
@property (nonatomic, strong) UIView *topView;
/** 机型 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 启动时间 */
@property (nonatomic, strong) UILabel *timeLabel;
/** 底部 */
@property (nonatomic, strong) UIView *bottomView;
/** 已挖到个数 */
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, weak) UILabel *messageLabel;

@end

@implementation NNMineOperationDeatilTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@(70));
    }];
    
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.bottom.right.equalTo(self);
    }];
}

- (UIView *)topView
{
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [[UIColor akext_colorWithHex:@"#392a1c"] colorWithAlphaComponent:0.8f];

        CGFloat width = SCREEN_WIDTH / 2;
        [_topView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topView);
            make.width.equalTo(@(width));
            make.bottom.equalTo(_topView.mas_centerY).offset(-5);
        }];
        
        UILabel *nameLabel = [UILabel NNHWithTitle:@"当前算力（算力*天）" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextTip]];
        [_topView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.nameLabel);
            make.top.equalTo(_topView.mas_centerY).offset(7);
        }];
        
        [_topView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right);
            make.width.equalTo(@(width));
            make.top.equalTo(self.nameLabel);
        }];

        UILabel *timeLabel = [UILabel NNHWithTitle:@"运行总收益（AAG／天）" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextTip]];
        [_topView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.timeLabel);
            make.top.equalTo(nameLabel);
        }];
    }
    return _topView;
}

- (void)setOperationModel:(NNMineOperationModel *)operationModel
{
    _operationModel = operationModel;
    
    self.nameLabel.text = operationModel.power;
    self.timeLabel.text = operationModel.day_out;
    
    if ([operationModel.status isEqualToString:@"0"]) { // 添加圆环
        [self creatTorus];
        self.countLabel.text = operationModel.on_coin;
    }else {
        self.messageLabel.hidden = YES;
        [self.countLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.bottomView);
        }];
        self.countLabel.text = @"该账本当前\n已停止记账";
        self.countLabel.font = [UIFont systemFontOfSize:16];
    }
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextMain]];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextMain]];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

- (UIView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [[UIColor akext_colorWithHex:@"#f2bc7d"] colorWithAlphaComponent:0.2f];
        
        CGFloat widthFloat = SCREEN_WIDTH * 340 / 750;
        UIView *centerView = [[UIView alloc] init];
        centerView.layer.cornerRadius = widthFloat * 0.5;
        centerView.layer.masksToBounds = YES;
        [_bottomView addSubview:centerView];
        centerView.backgroundColor = [[UIColor akext_colorWithHex:@"#392a1c"] colorWithAlphaComponent:0.8f];
        [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_bottomView);
            make.size.mas_equalTo(CGSizeMake(widthFloat, widthFloat));
        }];
        
        UILabel *messageLabel = [UILabel NNHWithTitle:@"当前已挖到（AAG）" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextTip]];
        _messageLabel = messageLabel;
        [_bottomView addSubview:messageLabel];
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_bottomView);
            make.bottom.equalTo(_bottomView.mas_centerY).offset(-10);
        }];
        
        [centerView addSubview:self.countLabel];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_bottomView);
            make.left.right.equalTo(centerView);
            make.top.equalTo(_bottomView.mas_centerY);
        }];
    }
    return _bottomView;
}

- (UILabel *)countLabel
{
    if (_countLabel == nil) {
        _countLabel = [UILabel NNHWithTitle:@"" titleColor:[UIColor akext_colorWithHex:@"#fec469"] font:[UIFont systemFontOfSize:18]];
        _countLabel.numberOfLines = 2;
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

/** 创建圆环 */
- (void)creatTorus
{
    CGFloat widthFloat = SCREEN_WIDTH * 340 / 750 + 30;
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor clearColor].CGColor;
    [self.bottomView.layer addSublayer:layer];
    CGFloat startX = (SCREEN_WIDTH - widthFloat) * 0.5;
    CGFloat startY = (SCREEN_WIDTH * 0.85 - widthFloat) * 0.5;
    layer.frame = CGRectMake(startX, startY, widthFloat, widthFloat);
    
    // 创建圆环
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(widthFloat * 0.5, widthFloat * 0.5) radius:widthFloat * 0.5 - 5 startAngle:M_PI * 0.1 endAngle:M_PI * 1.95 clockwise:YES];
    
    // 圆环遮罩
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = bezierPath.CGPath;
    [layer setMask:shapeLayer];

    //颜色渐变
    UIColor *startColor = [UIColor akext_colorWithHex:@"#f2bc7d"];
    UIColor *middleColor = [[UIColor akext_colorWithHex:@"#fff3d9"] colorWithAlphaComponent:0.5];
    UIColor *endColor = [UIColor clearColor];
    
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)startColor.CGColor,(id)middleColor.CGColor, nil];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.shadowPath = bezierPath.CGPath;
    gradientLayer.frame = CGRectMake(0, 0, widthFloat, widthFloat * 0.5);
    gradientLayer.startPoint = CGPointMake(1, 0);
    gradientLayer.endPoint = CGPointMake(0, 0);
    [gradientLayer setColors:[NSArray arrayWithArray:colors]];

    NSMutableArray *colors1 = [NSMutableArray arrayWithObjects:(id)middleColor.CGColor,(id)endColor.CGColor, nil];
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.shadowPath = bezierPath.CGPath;
    gradientLayer1.frame = CGRectMake(0, widthFloat * 0.5, widthFloat, widthFloat * 0.5);
    gradientLayer1.startPoint = CGPointMake(0, 1);
    gradientLayer1.endPoint = CGPointMake(1, 1);
    [gradientLayer1 setColors:[NSArray arrayWithArray:colors1]];
    [layer addSublayer:gradientLayer]; //设置颜色渐变
    [layer addSublayer:gradientLayer1];
    
    //转动动画
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2.0*M_PI];
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.duration = 1;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [layer addAnimation:rotationAnimation forKey:@"rotationAnnimation"];
    
}

@end
