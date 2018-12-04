//
//  Y_KLineView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineView.h"
#import "Y_KLineMainView.h"
#import "Y_KLineMAView.h"
#import "Y_VolumeMAView.h"
#import "Y_AccessoryMAView.h"
#import "Masonry.h"
#import "UIColor+Y_StockChart.h"

#import "Y_StockChartGlobalVariable.h"
#import "Y_KLineVolumeView.h"
#import "Y_StockChartRightYView.h"
#import "Y_KLineAccessoryView.h"
@interface Y_KLineView() <UIScrollViewDelegate, Y_KLineMainViewDelegate, Y_KLineVolumeViewDelegate, Y_KLineAccessoryViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

/**
 *  主K线图
 */
@property (nonatomic, strong) Y_KLineMainView *kLineMainView;

/**
 *  成交量图
 */
@property (nonatomic, strong) Y_KLineVolumeView *kLineVolumeView;

/**
 *  副图
 */
@property (nonatomic, strong) Y_KLineAccessoryView *kLineAccessoryView;

/**
 *  旧的scrollview准确位移
 */
@property (nonatomic, assign) CGFloat oldExactOffset;

/**
 *  kLine-MAView - (顶部高开收低)
 */
@property (nonatomic, strong) Y_KLineMAView *kLineMAView;

/**
 *  长按后显示的View
 */
@property (nonatomic, strong) UIView *verticalView;


@property (nonatomic, strong) MASConstraint *kLineMainViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *kLineVolumeViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *priceViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *volumeViewHeightConstraint;

@end

@implementation Y_KLineView

// initWithFrame设置视图比例
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.mainViewRatio = [Y_StockChartGlobalVariable kLineMainViewRadio];
        self.volumeViewRatio = [Y_StockChartGlobalVariable kLineVolumeViewRadio];
    }
    return self;
}

- (UIScrollView *)scrollView
{
    if(!_scrollView)
    {
        _scrollView = [UIScrollView new];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.minimumZoomScale = 1.0f;
        _scrollView.maximumZoomScale = 1.0f;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        
        //缩放手势
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(event_pichMethod:)];
        [_scrollView addGestureRecognizer:pinchGesture];
        
        //长按手势
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressMethod:)];
        [_scrollView addGestureRecognizer:longPressGesture];
        
        [self addSubview:_scrollView];
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.right.equalTo(self).offset(-5);
        }];
        
        [self layoutIfNeeded];
    }
    return _scrollView;
}

- (Y_KLineMAView *)kLineMAView
{
    if (!_kLineMAView) {
        _kLineMAView = [Y_KLineMAView view];
//        _kLineMAView.hidden = YES;
        [self addSubview:_kLineMAView];
        [_kLineMAView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(self).offset(5);
            make.height.equalTo(@10);
        }];
    }
    return _kLineMAView;
}

- (Y_KLineMainView *)kLineMainView
{
    if (!_kLineMainView && self) {
        _kLineMainView = [Y_KLineMainView new];
        _kLineMainView.delegate = self;
        [self.scrollView addSubview:_kLineMainView];
        [_kLineMainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView).offset(10);
            make.left.equalTo(self.scrollView);
            self.kLineMainViewHeightConstraint = make.height.equalTo(self.scrollView).multipliedBy(self.mainViewRatio);
            make.width.equalTo(@0);
        }];
        
    }
    return _kLineMainView;
}

//- (Y_KLineVolumeView *)kLineVolumeView
//{
//    if(!_kLineVolumeView && self)
//    {
//        _kLineVolumeView = [Y_KLineVolumeView new];
//        _kLineVolumeView.delegate = self;
//        [self.scrollView addSubview:_kLineVolumeView];
//        [_kLineVolumeView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.kLineMainView);
//            make.top.equalTo(self.kLineMainView.mas_bottom).offset(10);
//            make.width.equalTo(self.kLineMainView.mas_width);
//            self.kLineVolumeViewHeightConstraint = make.height.equalTo(self.scrollView.mas_height).multipliedBy(self.volumeViewRatio);
//        }];
//        [self layoutIfNeeded];
//    }
//    return _kLineVolumeView;
//}

- (Y_KLineAccessoryView *)kLineAccessoryView
{
    if(!_kLineAccessoryView && self)
    {
        _kLineAccessoryView = [Y_KLineAccessoryView new];
        _kLineAccessoryView.delegate = self;
        [self.scrollView addSubview:_kLineAccessoryView];
        [_kLineAccessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.kLineMainView);
            make.top.equalTo(self.kLineMainView.mas_bottom).offset(30);
            make.width.equalTo(self.kLineMainView.mas_width);
            make.height.equalTo(self.scrollView.mas_height).multipliedBy(0.3);
        }];
        [self layoutIfNeeded];
    }
    _kLineAccessoryView.targetLineStatus = Y_StockChartTargetLineStatusKDJ;
    return _kLineAccessoryView;
}

#pragma mark - set方法

#pragma mark kLineModels设置方法
- (void)setKLineModels:(NSArray *)kLineModels
{
    if(!kLineModels) {
        return;
    }
    _kLineModels = kLineModels;
    [self private_drawKLineMainView];
    
    //设置contentOffset
    CGFloat kLineViewWidth = self.kLineModels.count * [Y_StockChartGlobalVariable kLineWidth] + (self.kLineModels.count + 1) * [Y_StockChartGlobalVariable kLineGap] + 10;
    CGFloat offset = kLineViewWidth - self.scrollView.frame.size.width;
    
    if (offset > 0){
        self.scrollView.contentOffset = CGPointMake(offset, 0);
    } else {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    
    Y_KLineModel *model = [kLineModels lastObject];
    [self.kLineMAView maProfileWithModel:model];
}

- (void)setTargetLineStatus:(Y_StockChartTargetLineStatus)targetLineStatus
{
    _targetLineStatus = targetLineStatus;
    
    if(targetLineStatus < 103){
        if(targetLineStatus == Y_StockChartTargetLineStatusAccessoryClose){
            
            [Y_StockChartGlobalVariable setkLineMainViewRadio:0.65];
//            [Y_StockChartGlobalVariable setkLineVolumeViewRadio:0.28];

        } else {
            [Y_StockChartGlobalVariable setkLineMainViewRadio:0.5];
//            [Y_StockChartGlobalVariable setkLineVolumeViewRadio:0.2];

        }
        
        [self.kLineMainViewHeightConstraint uninstall];
        [_kLineMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            self.kLineMainViewHeightConstraint = make.height.equalTo(self.scrollView).multipliedBy([Y_StockChartGlobalVariable kLineMainViewRadio]);
        }];
//        [self.kLineVolumeViewHeightConstraint uninstall];
//        [self.kLineVolumeView mas_updateConstraints:^(MASConstraintMaker *make) {
//            self.kLineVolumeViewHeightConstraint = make.height.equalTo(self.scrollView.mas_height).multipliedBy([Y_StockChartGlobalVariable kLineVolumeViewRadio]);
//        }];
        [self reDraw];
    }

}
#pragma mark - event事件处理方法
#pragma mark 缩放执行方法
- (void)event_pichMethod:(UIPinchGestureRecognizer *)pinch
{
    static CGFloat oldScale = 1.0f;
    CGFloat difValue = pinch.scale - oldScale;
    if(ABS(difValue) > Y_StockChartScaleBound) {
        CGFloat oldKLineWidth = [Y_StockChartGlobalVariable kLineWidth];

        NSInteger oldNeedDrawStartIndex = self.kLineMainView.needDrawStartIndex;
        [Y_StockChartGlobalVariable setkLineWith:oldKLineWidth * (difValue > 0 ? (1 + Y_StockChartScaleFactor) : (1 - Y_StockChartScaleFactor))];
        oldScale = pinch.scale;
        //更新MainView的宽度
        [self.kLineMainView updateMainViewWidth];
        
        if( pinch.numberOfTouches == 2 ) {
            CGPoint p1 = [pinch locationOfTouch:0 inView:self.scrollView];
            CGPoint p2 = [pinch locationOfTouch:1 inView:self.scrollView];
            CGPoint centerPoint = CGPointMake((p1.x+p2.x)/2, (p1.y+p2.y)/2);
            NSUInteger oldLeftArrCount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + oldKLineWidth);
            NSUInteger newLeftArrCount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]);
            
            self.kLineMainView.pinchStartIndex = oldNeedDrawStartIndex + oldLeftArrCount - newLeftArrCount;
        }
        [self.kLineMainView drawMainView];
    }
}
#pragma mark 长按手势执行方法
- (void)event_longPressMethod:(UILongPressGestureRecognizer *)longPress
{
    static CGFloat oldPositionX = 0;
    if(UIGestureRecognizerStateChanged == longPress.state || UIGestureRecognizerStateBegan == longPress.state)
    {
        CGPoint location = [longPress locationInView:self.scrollView];
        if(ABS(oldPositionX - location.x) < ([Y_StockChartGlobalVariable kLineWidth] + [Y_StockChartGlobalVariable kLineGap])/2)
        {
            return;
        }
        
        //暂停滑动
        self.scrollView.scrollEnabled = NO;
        oldPositionX = location.x;
        
        //初始化竖线
        if(!self.verticalView){
            self.verticalView = [UIView new];
            self.verticalView.clipsToBounds = YES;
            [self.scrollView addSubview:self.verticalView];
            self.verticalView.backgroundColor = [UIColor longPressLineColor];
            [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(15);
                make.width.equalTo(@(Y_StockChartLongPressVerticalViewWidth));
                make.height.equalTo(self.scrollView.mas_height);
                make.left.equalTo(@(-10));
            }];
        }
        
        //更新竖线位置
        CGFloat rightXPosition = [self.kLineMainView getExactXPositionWithOriginXPosition:location.x];
        [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(rightXPosition));
        }];
        [self.verticalView layoutIfNeeded];
        self.verticalView.hidden = NO;
//        self.kLineMAView.hidden = NO;
    }
    
    if(longPress.state == UIGestureRecognizerStateEnded){
        // 取消竖线
        if(self.verticalView){
            self.verticalView.hidden = YES;
        }
        
//        self.kLineMAView.hidden = YES;
        
        oldPositionX = 0;
        
        // 恢复scrollView的滑动
        self.scrollView.scrollEnabled = YES;
        
        Y_KLineModel *lastModel = self.kLineModels.lastObject;
        [self.kLineMAView maProfileWithModel:lastModel];
    }
}

#pragma mark 重绘
- (void)reDraw
{
    self.kLineMainView.MainViewType = self.MainViewType;
    self.kLineMainView.kLineType = self.kLineType;
    if(self.targetLineStatus >= 103){
        self.kLineMainView.targetLineStatus = self.targetLineStatus;
    }
    [self.kLineMainView drawMainView];
}

#pragma mark - 私有方法
#pragma mark 画KLineMainView
- (void)private_drawKLineMainView
{
    self.kLineMainView.kLineModels = self.kLineModels;
    [self.kLineMainView drawMainView];
}

- (void)private_drawKLineVolumeView
{
    NSAssert(self.kLineVolumeView, @"kLineVolume不存在");
    //更新约束
    [self.kLineVolumeView layoutIfNeeded];
    [self.kLineVolumeView draw];
}

- (void)private_drawKLineAccessoryView
{
    //更新约束
    [self.kLineAccessoryView layoutIfNeeded];
    [self.kLineAccessoryView draw];
}

#pragma mark VolumeView代理
//- (void)kLineVolumeViewCurrentMaxVolume:(CGFloat)maxVolume minVolume:(CGFloat)minVolume
//{
//    self.volumeView.maxValue = maxVolume;
//    self.volumeView.minValue = minVolume;
//    self.volumeView.middleValue = (maxVolume - minVolume)/2 + minVolume;
//}
//- (void)kLineMainViewCurrentMaxPrice:(CGFloat)maxPrice minPrice:(CGFloat)minPrice
//{
//    self.priceView.maxValue = maxPrice;
//    self.priceView.minValue = minPrice;
//    self.priceView.middleValue = (maxPrice - minPrice)/2 + minPrice;
//}
//- (void)kLineAccessoryViewCurrentMaxValue:(CGFloat)maxValue minValue:(CGFloat)minValue
//{
//    self.accessoryView.maxValue = maxValue;
//    self.accessoryView.minValue = minValue;
//    self.accessoryView.middleValue = (maxValue - minValue)/2 + minValue;
//}

#pragma mark MainView更新时通知下方的view进行相应内容更新
- (void)kLineMainViewCurrentNeedDrawKLineModels:(NSArray *)needDrawKLineModels
{
//    self.kLineVolumeView.needDrawKLineModels = needDrawKLineModels;
    self.kLineAccessoryView.needDrawKLineModels = needDrawKLineModels;
}

- (void)kLineMainViewCurrentNeedDrawKLinePositionModels:(NSArray *)needDrawKLinePositionModels
{
//    self.kLineVolumeView.needDrawKLinePositionModels = needDrawKLinePositionModels;
    self.kLineAccessoryView.needDrawKLinePositionModels = needDrawKLinePositionModels;
}

- (void)kLineMainViewCurrentNeedDrawKLineColors:(NSArray *)kLineColors
{
//    self.kLineVolumeView.kLineColors = kLineColors;
//    if(self.targetLineStatus >= 103){
//           self.kLineVolumeView.targetLineStatus = self.targetLineStatus;
//    }
//
//    [self private_drawKLineVolumeView];
    
    self.kLineAccessoryView.kLineColors = kLineColors;
    if(self.targetLineStatus < 103){
        self.kLineAccessoryView.targetLineStatus = self.targetLineStatus;
    }
    [self private_drawKLineAccessoryView];
}

- (void)kLineMainViewLongPressKLinePositionModel:(Y_KLinePositionModel *)kLinePositionModel kLineModel:(Y_KLineModel *)kLineModel
{
    //更新ma信息
    [self.kLineMAView maProfileWithModel:kLineModel];
}

#pragma mark - UIScrollView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

}

- (void)dealloc
{
    [_kLineMainView removeAllObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
