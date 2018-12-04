//
//  NNConsumerOrderDetailModel.h
//  YWL
//
//  Created by 来旭磊 on 2018/5/21.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           C2C 订单详情model
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <Foundation/Foundation.h>
#import "NNConsumerOrderDetailPayModel.h"
#import "NNConsumerTradeActionModel.h"

@interface NNConsumerOrderDetailModel : NSObject


/** <#注释#> */
@property (nonatomic, copy) NSString *tradeid;
/** 交易对方 联系方式 */
@property (nonatomic, copy) NSString *trademobile;
/** 头部提示文字 */
@property (nonatomic, copy) NSString *warning;
/** 订单编号 */
@property (nonatomic, copy) NSString *orderno;
/** 单价 */
@property (nonatomic, copy) NSString *price;
/** 数量 */
@property (nonatomic, copy) NSString *num;
/** 订单状态 */
@property (nonatomic, copy) NSString *statusstr;
/** 手续费 */
@property (nonatomic, copy) NSString *fee;
/** 总额 */
@property (nonatomic, copy) NSString *amount;
/** 页面标题 */
@property (nonatomic, copy) NSString *title;
/** 支付备注 */
@property (nonatomic, strong) NSString *remark;
/** 支付model */
@property (nonatomic, strong) NNConsumerOrderDetailPayModel *payway;
/** 订单操作 */
@property (nonatomic, strong) NNConsumerTradeActionModel *orderstatus;
/** 支付凭证 */
@property (nonatomic, copy) NSString *payimg;
/** 是否显示我要申诉 */
@property (nonatomic, copy) NSString *isexplain;

/** 判断剩余时间及违规 */
@property (nonatomic, copy) NSString *statusintro;
/** 违规原因 */
@property (nonatomic, copy) NSString *reason;


#pragma mark - 辅助属性

/** 支付方式数组 */
@property (nonatomic, strong) NSMutableArray <NNConsumerOrderDetailPayTypeModel *>*payTypeArray;

/** 选中的支付方式模型 */
@property (nonatomic, strong) NNConsumerOrderDetailPayTypeModel *selectedPaytypeModel;

/** 支付方式标题 */
@property (nonatomic, strong) NSMutableArray *payTypeTitleArray;



@end
