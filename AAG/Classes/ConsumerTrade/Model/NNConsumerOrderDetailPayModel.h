//
//  NNConsumerOrderDetailPayModel.h
//  YWL
//
//  Created by 来旭磊 on 2018/5/22.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNConsumerOrderDetailPayTypeModel : NSObject

/**  */
@property (nonatomic, copy) NSString *name;
/**  */
@property (nonatomic, copy) NSString *bank;
/**  */
@property (nonatomic, copy) NSString *weixin_img;
/**  */
@property (nonatomic, copy) NSString *zhifubao_img;
/**  */
@property (nonatomic, copy) NSString *bank_liuyan;
/**  */
@property (nonatomic, copy) NSString *bankcard;
/**  */
@property (nonatomic, copy) NSString *bankprov;
/**  */
@property (nonatomic, copy) NSString *bankcity;
/**  */
@property (nonatomic, copy) NSString *bankaddr;

#pragma mark - 辅助属性

/** 交易支付方式 1支付宝 2微信 3银行卡 */
@property (nonatomic, copy) NSString *paytype;


@end

@interface NNConsumerOrderDetailPayModel : NSObject

/** 银行卡 */
@property (nonatomic, strong) NNConsumerOrderDetailPayTypeModel *bank;
/** 支付宝 */
@property (nonatomic, strong) NNConsumerOrderDetailPayTypeModel *alipay;
/** 微信 */
@property (nonatomic, strong) NNConsumerOrderDetailPayTypeModel *wechat;

@end
