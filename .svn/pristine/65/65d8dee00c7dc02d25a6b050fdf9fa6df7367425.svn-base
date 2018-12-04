//
//  NNHApiMarketHomeTool.h
//  YWL
//
//  Created by 来旭磊 on 2018/3/12.
//  Copyright © 2018年 NBT. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           区块账本 模块接口api
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import "NNHBaseRequest.h"

@interface NNHApiMarketHomeTool : NNHBaseRequest


/**
 矿机列表

 @return 返回数据源
 */
- (instancetype)initMineListData;


/**
 首页 - 算力详情 - 记录
 
 @return 返回数据源
 */
- (instancetype)initHomePowerFlowDetailWithID:(NSString *)powerID
                                         Page:(NSUInteger)page;


/**
 购买矿机显示页面

 @param mineID 矿机id
 @return api
 */
- (instancetype)initBuyMineDataWithMineID:(NSString *)mineID;


/**
 购买矿机

 @param mineID 矿机id
 @param balance 可用余额
 @param blockbalance 区块资产
 @param num 购买数量
 @param paypassword 密码
 @return api
 */
- (instancetype)initBuyMinePayOrderWithMineID:(NSString *)mineID
                                     minetype:(NSString *)minetype
                                     iscomput:(NSString *)iscomput
                                          num:(NSString *)num
                                  paypassword:(NSString *)paypassword;
/**
 购买矿机记录

 @param page 页码
 @return api
 */
- (instancetype)initBuyMineRecordWithPage:(NSInteger)page;


/**
 矿及运行信息

 @param operationType 运行状态
 @param page 页码
 @return api
 */
- (instancetype)initMineOperationListDataWithType:(NNHMineOperationType)operationType page:(NSInteger)page;


/**
 矿机单个详细信息

 @param mainID 矿机id
 @return api
 */
- (instancetype)initMineOperationDataWithMineID:(NSString *)mainID;

@end
