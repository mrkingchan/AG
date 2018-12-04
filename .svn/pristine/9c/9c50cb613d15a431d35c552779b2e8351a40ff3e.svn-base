//
//  NNHAPIConsumerTradeTool.h
//  YWL
//
//  Created by 来旭磊 on 2018/5/15.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           C2C交易 用户下单模块 api接口
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import "NNHBaseRequest.h"

@interface NNHAPIConsumerTradeTool : NNHBaseRequest


/**
 用户当前委托 列表数据

 @param page 页码
 @return api
 */
- (instancetype)initTradeCurrentEntrusetListDataWithPage:(NSInteger)page;


/**
 用户历史委托
 
 @param page 页码
 @return api
 */
- (instancetype)initTradeHistoryEntrusetListDataWithPage:(NSInteger)page;


/**
 发布交易单之前 价格信息

 @return api
 */
- (instancetype)initOrderCoinData;


/**
 发布订单

 @param tradeType 交易类型
 @param paypassword 支付密码
 @param price 价格
 @param num 数量
 @return api
 */
- (instancetype)initReleaseOrderWithTradeType:(NNConsumerTradeType)tradeType
                                  paypassword:(NSString *)paypassword
                                        price:(NSString *)price
                                          num:(NSString *)num;


/**
 C2C订单页面

 @param tradeType 交易类型
 @return api
 */
- (instancetype)initMatchOrderListDataWithTradeType:(NNConsumerTradeType)tradeType
                                               page:(NSInteger)page;


/**
 交易详情

 @param tradeID 交易id
 @return api
 */
- (instancetype)initWithTradeInfoDatailDataWithTradeID:(NSString *)tradeID;

/**
 C2C买入卖出
 
 @param tradeID 交易id
 @return api
 */
- (instancetype)initDoDealTradeID:(NSString *)tradeID;


/**
 C2C 确认付款

 @param traderID 订单id
 @param password 支付密码
 @param payType 支付方式
 @return api
 */
- (instancetype)initWithConfirmPayOrderWithTradeID:(NSString *)traderID
                                          password:(NSString *)password
                                           payType:(NSString *)payType;

/**
 C2C 买家确认付款确认付款、确卖家确认收款

 @param traderID 交易id
 @param password 确认付款需要输入支付密码
 @return api
 */
- (instancetype)initConfirmCollectionWithTradeID:(NSString *)traderID
                                   password:(NSString *)password;


/**
 取消交易

 @param tradeID 交易id
 @return api
 */
- (instancetype)initCancleTradeWithTradeID:(NSString *)tradeID;


/**
 上传交易凭证

 @param imageUrl 图片地址
 @param tradeID 订单号
 @return api
 */
- (instancetype)initUploadTradeVoucherWithImageUrl:(NSString *)imageUrl
                                           tradeID:(NSString *)tradeID;


/**
 交易申诉

 @param tradeID 订单号
 @param content 申诉文字内容
 @param imgs 图片
 @return api
 */
- (instancetype)initSubmitAppealDataWithTradeID:(NSString *)tradeID
                                        content:(NSString *)content
                                           imgs:(NSString *)imgs;


@end
