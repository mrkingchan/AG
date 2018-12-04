//
//  NNAPIBlockFundTransferTool.h
//  YWL
//
//  Created by 来旭磊 on 2018/5/14.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           区块资产转账api
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import "NNHBaseRequest.h"

@interface NNAPIBlockFundTransferTool : NNHBaseRequest

/**
 区块资产平台内部互转
 @param transferNum 数量
 @param account 账户
 @param paypwd 支付密码
 @param verificationCode 验证码
 @return api
 */
- (instancetype)initWalletTransferWithTransferType:(NNHWalletTransferType)transferType
                                       transferNum:(NSString *)transferNum
                                           account:(NSString *)account
                                  verificationCode:(NSString *)verificationCode
                                            paypwd:(NSString *)paypwd;

/**
 区块资产平台转账明细
 @param transferType 钱包类型
 @param page 页数
 @return api
 */
- (instancetype)initWalletTransferRecordWithTransferType:(NNHWalletTransferType)transferType
                                                    page:(NSInteger)page;


/**
 区块资产转账记录

 @param page 页码
 @return api
 */
- (instancetype)initBlockFundTransferRecorWithPage:(NSInteger)page;



/**
 余额转消费资产

 @param num 数量
 @param type 类型
 @param paypwd 支付密码
 @return api
 */
- (instancetype)initBalanceFundTransferToConsumeFundWithNum:(NSString *)num
                                                       type:(NSString *)type
                                                     paypwd:(NSString *)paypwd;


/**
 消费资产转账记录

 @param page 页码
 @return api
 */
- (instancetype)initConsumeFundTransferRecordWithPage:(NSInteger)page;

@end
