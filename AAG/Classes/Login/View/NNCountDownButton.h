//
//  NNCountDownButton.h
//  YWL
//
//  Created by 牛牛 on 2018/3/16.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNCountDownButton : UIButton

@property (nonatomic, strong) UIColor *bgNormalColor;
@property (nonatomic, strong) UIColor *bgCountingColor;


@property (nonatomic, strong) UIColor *lbNormalColor;
@property (nonatomic, strong) UIColor *lbCountingColor;

/** 当前数值 **/
@property (nonatomic, assign) NSUInteger curSec;

/** 计时长度**/
@property (nonatomic, assign) NSUInteger totalSec;

- (instancetype)initWithTotalTime:(NSUInteger)totalTime titleBefre:(NSString *)titleBefore titleConting:(NSString *)titleCounting titleAfterCounting:(NSString *)titleAfter clickAction:(void(^)(NNCountDownButton *countBtn))clickAction;

- (void)startCounting;
- (void)resetButton;

@end
