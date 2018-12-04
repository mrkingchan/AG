//
//  NNHAPIPaymentTool.m
//  YWL
//
//  Created by 来旭磊 on 2018/4/1.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNHAPIPaymentTool.h"
#import "NSString+Hash.h"

@implementation NNHAPIPaymentTool

/** 生成订单号 */
- (instancetype)initCreatOrderWithAmount:(NSString *)amount
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"pay.pay.addorder";
        self.reAPIName = @"支付订单-刷卡 生成订单号";
        self.reParams = @{
                          @"amount" : amount,
                          };
    }
    return self;
}

/** 生成订单号 */
- (instancetype)initPayOrderWithOrderno:(NSString *)orderno payType:(NNHOrderPayType)payType
{
    self = [super init];
    if (self) {
        
        self.requestReServiceType = @"pay.pay.request";
        self.reAPIName = @"第三方支付请求";
        NSString *pay_type = @"weixin";
        if (payType == NNHOrderPayTypeAliPay) {
            pay_type = @"ali";
        }
        self.reParams = @{
                          @"orderno" : orderno,
                          @"pay_type" : pay_type,
                          };
        
    }
    return self;
}

- (instancetype)initBalanceOrderWithOrderno:(NSString *)orderno
                                     payPwd:(NSString *)payPwd
{
    self = [super init];
    if (self) {
        
        self.requestReServiceType = @"pay.pay.balancenbtcpay";
        self.reAPIName = @"余额支付请求";
        self.reParams = @{
                          @"orderno" : orderno,
                          @"paypwd" : [payPwd md5String]
                          };
        
    }
    return self;
}

@end
