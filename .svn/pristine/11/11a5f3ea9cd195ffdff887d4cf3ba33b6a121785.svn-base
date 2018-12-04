//
//  NNAPIMineTool.h
//  YWL
//
//  Created by 牛牛 on 2018/3/27.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNHBaseRequest.h"

@interface NNAPIMineTool : NNHBaseRequest

/** 获取个人中心数据 */
- (instancetype)initMemberDataSource;
/** 我的二维码 */
- (instancetype)initMyQrCode;
/** 公告中心 */
- (instancetype)initMyNoticeWithPage:(NSUInteger)page;
/** 我的社群 */
- (instancetype)initMyCommunityWithPage:(NSUInteger)page;


#pragma mark --
#pragma mark -- 银行卡
/** 获取用户绑定银行卡列表 */
- (instancetype)initBankCardList;

/** 根据银行卡号码识别对应银行 */
- (instancetype)initGetBankNameWithPreBankCardNum:(NSString *)bankNum;

/**
 (添加银行卡
 
 @param account_type 账户类型(1为个人 2为公司)
 @param account_name 银行开户名
 @param account_number [银行帐号
 @param bank_type_name 开户银行名称
 @param branch 开户行支行
 @param mobile 手机号码
 @return 请求操作类
 */
- (instancetype)initAddNewBankCardWithAccountType:(NSString *)account_type
                                     account_name:(NSString *)account_name
                                   account_number:(NSString *)account_number bank_type_name:(NSString *)bank_type_name
                                           branch:(NSString *)branch
                                           mobile:(NSString *)mobile;

/**
 添加微信/支付宝收款码
 @param name 真实姓名
 @param codeType 微信1，支付宝2
 @param payNumber 微信/支付宝帐号
 @param img 收款码图片地址
 */
- (instancetype)initAddPaymentCodeWithName:(NSString *)name
                                  codeType:(NSString *)codeType
                                 payNumber:(NSString *)payNumber
                                       img:(NSString *)img;

/** 解绑银行卡操作 */
- (instancetype)initUnBankWithCardID:(NSString *)cardID;


#pragma mark --
#pragma mark -- 实名
/** 上传图片 */
- (instancetype)initUploadImage;

/**
 身份认证
 @param name 真实姓名
 @param idnumber 身份证号
 @param idcardimg 身份证照片拼接url
 @return api
 */
- (instancetype)initWithRealName:(NSString *)name
                        idnumber:(NSString *)idnumber
                       idcardimg:(NSString *)idcardimg;


/**
 请求实名认证信息

 @return api
 */
- (instancetype)initAuthInfo;


#pragma mark --
#pragma mark -- 订单
- (instancetype)initMyOrderListWithPage:(NSUInteger)page;

// 取消订单
- (instancetype)initCancleMyOrderWitID:(NSString *)orderID payPwd:(NSString *)pwd;

@end
