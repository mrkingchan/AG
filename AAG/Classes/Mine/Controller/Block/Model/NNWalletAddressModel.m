//
//  NNWalletAddressModel.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/12.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNWalletAddressModel.h"

@implementation NNWalletAddressModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"addressID"    : @"id",
             };
}

@end
