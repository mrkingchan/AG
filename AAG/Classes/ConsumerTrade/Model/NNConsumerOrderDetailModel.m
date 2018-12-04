//
//  NNConsumerOrderDetailModel.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/21.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNConsumerOrderDetailModel.h"

@implementation NNConsumerOrderDetailModel

- (NSMutableArray<NNConsumerOrderDetailPayTypeModel *> *)payTypeArray
{
    if (_payTypeArray == nil) {
        _payTypeArray = [NSMutableArray array];
        
        if (self.payway.bank.name.length) {
            [_payTypeArray addObject:self.payway.bank];
            [self.payTypeTitleArray addObject:@"银行卡"];
            self.payway.bank.paytype = @"3";
        }
        
        if (self.payway.alipay.name.length) {
            [_payTypeArray addObject:self.payway.alipay];
            [self.payTypeTitleArray addObject:@"支付宝"];
            self.payway.alipay.paytype = @"1";
        }
        if (self.payway.wechat.name.length) {
            [_payTypeArray addObject:self.payway.wechat];
            [self.payTypeTitleArray addObject:@"微信"];
            self.payway.wechat.paytype = @"2";
        }
    }
    return _payTypeArray;
}

- (NSMutableArray *)payTypeTitleArray
{
    if (_payTypeTitleArray == nil) {
        _payTypeTitleArray = [NSMutableArray array];
    }
    return _payTypeTitleArray;
}

@end
