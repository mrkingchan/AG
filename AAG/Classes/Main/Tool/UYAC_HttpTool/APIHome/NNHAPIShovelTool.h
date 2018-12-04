//
//  NNHAPIShovelTool.h
//  YWL
//
//  Created by 来旭磊 on 2018/3/29.
//  Copyright © 2018年 NBT. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           首页挖宝模块 api接口
 
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import "NNHBaseRequest.h"

@interface NNHAPIShovelTool : NNHBaseRequest


/**
 首页挖宝接口

 @return api接口
 */
- (instancetype)initIndexShovelData;


/**
 已经挖了的Hcoin列表

 @param page 页码
 @return api接口
 */
- (instancetype)initShoveldCoinListDataWithPage:(NSInteger)page;


/**
 挖币

 @param coinID 币种id
 @return api接口
 */
- (instancetype)initGetCoinWithCoinID:(NSString *)coinID;


/**
 版本更新
 
 @return api接口
 */
- (instancetype)initVersionUpdate;

@end
