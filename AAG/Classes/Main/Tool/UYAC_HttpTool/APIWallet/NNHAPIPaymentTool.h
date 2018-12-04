//
//  NNHAPIPaymentTool.h
//  YWL
//
//  Created by 来旭磊 on 2018/4/1.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNHBaseRequest.h"

@interface NNHAPIPaymentTool : NNHBaseRequest

/** 生成订单号 */
- (instancetype)initCreatOrderWithAmount:(NSString *)amount;

/** 第三方 生成订单号 */
- (instancetype)initPayOrderWithOrderno:(NSString *)orderno payType:(NNHOrderPayType)payType;

/** 余额支付 生成订单号 */
- (instancetype)initBalanceOrderWithOrderno:(NSString *)orderno
                                     payPwd:(NSString *)payPwd;

@end
