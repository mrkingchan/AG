//
//  NNConsumerMatchOrderModel.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/21.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNConsumerMatchOrderModel.h"

@implementation NNConsumerMatchOrderModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"orderID"    :   @"id",
             };
}

- (NSMutableArray *)iconNameArray
{
    if (_iconNameArray == nil) {
        _iconNameArray = [NSMutableArray array];
        
        if ([self.isalipay isEqualToString:@"1"]) {
            [_iconNameArray addObject:@"ic_trade_alipay"];
        }
        
        if ([self.iswechat isEqualToString:@"1"]) {
            [_iconNameArray addObject:@"ic_trade_wechat"];
        }
        
        if ([self.isbank isEqualToString:@"1"]) {
            [_iconNameArray addObject:@"ic_trade_unionpay"];
        }
        
    }
    return _iconNameArray;
}

- (NSString *)buttonTitle
{
    if ([self.type isEqualToString:@"1"]) {
        return @"我要卖出";
    }else {
        return @"我要买入";
    }
}

- (UIColor *)buttonColor
{
    if ([self.type isEqualToString:@"2"]) {
        return [UIColor akext_colorWithHex:@"#009759"];
    }else {
        return [UIColor akext_colorWithHex:@"#ff1844"];
    }
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
