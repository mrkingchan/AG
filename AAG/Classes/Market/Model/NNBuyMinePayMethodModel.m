//
//  NNBuyMinePayMethodModel.m
//  WTA
//
//  Created by 来旭磊 on 2018/9/10.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNBuyMinePayMethodModel.h"

@implementation NNBuyMinePayMethodModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"paytype" : @"typename",
             };
}

@end
