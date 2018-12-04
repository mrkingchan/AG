//
//  NNConsumerMatchOrderModel.h
//  YWL
//
//  Created by 来旭磊 on 2018/5/21.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNConsumerMatchOrderModel : NSObject

/** 订单id */
@property (nonatomic, copy) NSString *orderID;
/** 用户id */
@property (nonatomic, copy) NSString *userid;
/** 单价 */
@property (nonatomic, copy) NSString *price;
/** 数量 */
@property (nonatomic, copy) NSString *num;
/** 订单类型 */
@property (nonatomic, copy) NSString *type;
/** 添加时间 */
@property (nonatomic, copy) NSString *addtime;
/** 是否支持支付宝 */
@property (nonatomic, copy) NSString *isalipay;
/** 是否支持微信 */
@property (nonatomic, copy) NSString *iswechat;
/** 是否支持银行卡 */
@property (nonatomic, copy) NSString *isbank;
/** 手机号 */
@property (nonatomic, copy) NSString *mobile;
/** 总额 */
@property (nonatomic, copy) NSString *amount;
/** 信用等级 */
@property (nonatomic, copy) NSString *credit;

#pragma mark - 辅助属性

/** 支付方式数组 */
@property (nonatomic, strong) NSMutableArray *iconNameArray;
/** 按钮文字 */
@property (nonatomic, copy) NSString *buttonTitle;
/** 按钮颜色 */
@property (nonatomic, strong) UIColor *buttonColor;
/** 信用等级排名 */
@property (nonatomic, copy) NSString *rankImageName;

@end
