//
//  NNMineNoticeModel.m
//  YWL
//
//  Created by 牛牛 on 2018/4/27.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMineNoticeModel.h"

@implementation NNMineNoticeModel
{
    CGFloat _cellHeight;
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        
        // 基础高度
        CGFloat margin = 15;
        CGFloat topH = 44;
        CGFloat maxW = SCREEN_WIDTH - 40 - 30;
        
        // 计算内容的高度
        CGFloat titleH =  [self.title sizeWithFont:[UIConfigManager fontThemeTextImportant] maxW:maxW].height;
        CGFloat detailH =  [self.content sizeWithFont:[UIConfigManager fontThemeTextDefault] maxW:maxW].height;
        
        _cellHeight = topH + margin + titleH + margin + detailH + margin + 44;
    }
    
    return _cellHeight;
}

@end
