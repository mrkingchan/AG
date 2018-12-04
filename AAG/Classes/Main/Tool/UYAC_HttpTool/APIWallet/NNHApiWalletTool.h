//
//  NNHApiWalletTool.h
//  YWL
//
//  Created by 来旭磊 on 2018/3/27.
//  Copyright © 2018年 NBT. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           用户钱包模块 接口
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import "NNHBaseRequest.h"


@interface NNHApiWalletTool : NNHBaseRequest


/**
 用户钱包余额

 @return 请求类
 */
- (instancetype)initWithUserWalletBalance;

/**
 获取用户转入地址

 @param coinID 交易币种
 @return api
 */
- (instancetype)initUserRechageAddressWithCoinID:(NSString *)coinID;


/**
 用户转出接口

 @param coinID 交易币种 hcoin =1
 @param address 转出地址
 @param amount 数量
 @param paypwd 资金密码
 @return api
 */
- (instancetype)initUserWithdrawWithCoinID:(NSString *)coinID
                                   address:(NSString *)address
                                    amount:(NSString *)amount
                                    paypwd:(NSString *)paypwd;

/**
 资金记录
 
 @param coinID 币种名称
 @param OperationType 记录类型1转出2转入
 @return 实例对象
 */
- (instancetype)initUserFundRecordWithCoinID:(NSString *)coinID
                                             type:(NNHUserFundOperationType)OperationType
                                             page:(NSInteger)page;


/**
 用户我的模块 奖励明细列表

 @param rewardType 奖励类型
 @param page 页码
 @return 实例对象
 */
- (instancetype)initUserCoinEncourageWithRewardType:(NNHUserCoinRewardType)rewardType
                                               page:(NSInteger)page;


/**
 用户资产模块奖励明细

 @param rewardType 类型
 @param page 页码
 @return api
 */
- (instancetype)initUserAllRewardWithType:(NNHUserCoinRewardType)rewardType
                                     page:(NSInteger)page;

/**
 转账地址列表

 @return api
 */
- (instancetype)initCoinAddressListData;
@end
