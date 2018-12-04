//
//  NNMineModel.m
//  YWL
//
//  Created by 牛牛 on 2018/3/27.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNMineModel.h"

@implementation NNMineAmountInfoModel


@end


@implementation NNMineModel
{
    CGFloat _topViewH;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             
               @"userModel" : @"userinfo",
               @"amountInfoModel" : @"amountInfo"
             
             };
}

- (CGFloat)topViewH
{
    if (!_topViewH) {
        
        // 顶部背景高度
        CGFloat iconViewH = 180 + (NNHSTATUSBARDifference);
        
        // 九宫格
        NSInteger col = 3;
        NSInteger total = 6;
        CGFloat margin = 0.5;
        NSInteger maxRow = (total + col - 1) / col;
        CGFloat middleViewH = ((SCREEN_WIDTH - (col - 1) *margin) / col *0.6) *maxRow;

        _topViewH = iconViewH + middleViewH + 2;
    }
    return _topViewH;
}

@end
