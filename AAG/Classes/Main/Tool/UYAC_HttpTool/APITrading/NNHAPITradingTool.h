//
//  NNHAPITradingTool.h
//  YWL
//
//  Created by 来旭磊 on 2018/3/27.
//  Copyright © 2018年 NBT. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           区块交易相关api接口
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import "NNHBaseRequest.h"

@interface NNHAPITradingTool : NNHBaseRequest

/** 转账操作 */
- (instancetype)initMineFundTransferWithNum:(NSString *)num
                                 tousername:(NSString *)tousername
                                     paypwd:(NSString *)paypwd;

/** 矿机资产收款二维码 */
- (instancetype)initCreatReciveMineFundCodeImage;

/** 转账操作 */
- (instancetype)initMineFundTransferRecorWithType:(NNMineFundOperationType)operationType
                                             page:(NSInteger)page;


#pragma mark
#pragma mark -- K线
/**
 k线接口
 @param period 分时类型 1min 1hour 1day 1week
 @return api接口
 */
- (instancetype)initCoinChartWithPeriod:(NSString *)period;

/**
 最新行情
 @return api接口
 */
- (instancetype)initNewCoinMarket;

@end
