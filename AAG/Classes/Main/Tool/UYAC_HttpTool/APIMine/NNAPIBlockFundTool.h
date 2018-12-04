//
//  NNAPIBlockFundTool.h
//  YWL
//
//  Created by 来旭磊 on 2018/5/12.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           个人中心区块资产相关 api
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import "NNHBaseRequest.h"

@interface NNAPIBlockFundTool : NNHBaseRequest

/**
 资产明细
 @param type 资产类型
 @param flowType 流动钱包
 @param page 页码
 @return api
 */
- (instancetype)initCoinAssetsDetailWithType:(NNHMineAssetsType)type
                                    flowType:(NSString *)flowType
                                        page:(NSUInteger)page;

/**
 资产奖励明细
 @param type 资产类型
 @param page 页码
 @return api
 */
- (instancetype)initCoinAssetsRewardDetailWithType:(NNHMineAssetsType)type
                                              page:(NSUInteger)page;


/**
 添加钱包地址

 @param remark 备注
 @param address 钱包地址
 @return api
 */
- (instancetype)initAddWalletAddrrssWithRemark:(NSString *)remark
                                       address:(NSString *)address;


/**
 获取用户钱包地址列表

 @return api
 */
- (instancetype)initUserWalletAddressListData;


/**
 删除钱包地址

 @param addressID 钱包id
 @return api
 */
- (instancetype)initDeleteWalletAddressWithAddressID:(NSString *)addressID;


/**
 区块资产可提现余额，

 @return api
 */
- (instancetype)initBlockFundBalance;


/**
 提现、转账 资产详情页

 @param fundType 类型
 @return api
 */
- (instancetype)initFundDetailInfoWithFundType:(NNFundBanlanceType)fundType;

/**
 获取币种充值地址

 @return api
 */
- (instancetype)initBlockFundCoinRechageAddressData;


/**
 币种提现

 @param address 提现地址
 @param coinamount 提现金额
 @param paypwd 支付密码
 @return api
 */
- (instancetype)initBlockFundCoinWithdrawWithAddress:(NSString *)address
                                          coinamount:(NSString *)coinamount
                                              paypwd:(NSString *)paypwd;


/**
 币种充提交易记录

 @param operationType 操作类型
 @param page 页码
 @return api
 */
- (instancetype)initBlockFundCoinTransferRecordWithType:(NNMineFundOperationType)operationType
                                                   page:(NSInteger)page;


/**
 获取钱包转账额度
 @param type 转账类型
 @return api
 */
- (instancetype)initWalletTransferWithType:(NNHWalletTransferType)type;

@end
