//
//  NNHConsumerTradeEntrustModel.h
//  NBTMill
//
//  Created by 来旭磊 on 2018/5/15.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           C2C交易 用户当前委托列表 数据模型
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <Foundation/Foundation.h>

@interface NNHConsumerTradeEntrustModel : NSObject

/** 订单id */
@property (nonatomic, copy) NSString *orderID;

/** 用户id */
@property (nonatomic, copy) NSString *userid;

/** 单价 */
@property (nonatomic, copy) NSString *price;

/** 数量 */
@property (nonatomic, copy) NSString *num;

/** 交易类型 */
@property (nonatomic, copy) NSString *type;

/** 时间 */
@property (nonatomic, copy) NSString *addtime;

/** 电话 */
@property (nonatomic, copy) NSString *mobile;

/** 总金额 */
@property (nonatomic, copy) NSString *amount;
@end
