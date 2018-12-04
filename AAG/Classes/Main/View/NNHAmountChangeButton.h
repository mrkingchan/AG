//
//  NNHAmountChangeButton.h
//  WTA
//
//  Created by 来旭磊 on 2018/9/10.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNHAmountChangeButton : UIView

/** 最小值 */
@property (nonatomic, assign) NSInteger minValue;

/** 最大值 */
@property (nonatomic, assign) NSInteger maxValue;

/** 修改数字回调 */
@property (nonatomic, copy) void(^resultBlock)(NSInteger number);

/** 当前数值 */
@property (nonatomic, assign) NSInteger currentNumber;

@end
