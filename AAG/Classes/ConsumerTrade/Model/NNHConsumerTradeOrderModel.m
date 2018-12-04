//
//  NNHConsumerTradeOrderModel.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/15.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNHConsumerTradeOrderModel.h"

@implementation NNHConsumerTradeOrderModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"orderID" : @"id",
             };
}

- (NSString *)rankImageName
{
    if ([self.credit isEqualToString:@"3"]) {
        return @"ic_credit_high";
    }else if ([self.credit isEqualToString:@"2"]) {
        return @"ic_credit_medium";
    }else {
        return @"ic_credit_low";
    }
}


@end
