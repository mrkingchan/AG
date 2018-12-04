//
//  NNMyOrderModel.m
//  WTA
//
//  Created by 牛牛 on 2018/9/10.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMyOrderModel.h"

@implementation NNMyOrderModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"orderID" : @"id"};
}

@end
