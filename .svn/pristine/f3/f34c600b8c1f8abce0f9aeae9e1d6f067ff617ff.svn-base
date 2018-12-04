//
//  NNHConst.h
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/19.
//  Copyright © 2016年 NBT. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 提取/转账资产详情页 余额显示类型 */
typedef NS_ENUM(NSInteger , NNFundBanlanceType){
    NNFundBanlanceType_jizhangFund     = 0,     //记账资产转账(个人中心)
    NNFundBanlanceType_huzhuanFund     = 1,     //tabbar资产互转页
    NNFundBanlanceType_withdrawFund    = 2,     //提取资产NBT(个人中心)
};

/** 用户C2C交易 类型 */
typedef NS_ENUM(NSInteger , NNConsumerTradeType){
    NNConsumerTradeType_buy     = 0,     /*买入*/
    NNConsumerTradeType_sell = 1,        /*卖出*/
};

/** 矿机资产操作类型 */
typedef NS_ENUM(NSInteger , NNMineFundOperationType){
    NNMineFundOperationType_none     = 0,        /*全部*/
    NNMineFundOperationType_recharge = 1,        /*转入*/
    NNMineFundOperationType_withdraw = 2,        /*转出*/
};


/** 登录类型 */
typedef NS_ENUM(NSInteger , NNLoginType){
    NNLoginType_verificationCode = 0,        /*验证码登录*/
    NNLoginType_password = 1,                /*密码登录*/
};


/** 矿机运行状态 */
typedef NS_ENUM(NSInteger, NNHMineOperationType) {
    NNHMineOperationType_progress   = 0,  //进行中
    NNHMineOperationType_end    = 1,      //停止
};

typedef NS_ENUM(NSInteger, NNHBlockType) {
    NNHBlockType_mainType   = 0,      //一级记账
    NNHBlockType_subType    = 1,      //二级记账
    NNHBlockType_centerType = 2,      //区块中心
};


typedef NS_ENUM(NSInteger, NNHOrderPayType) {
    NNHOrderPayTypeAliPay     = 0,      //支付宝
    NNHOrderPayTypeWeChatPay  = 1,      //微信支付
};

/** 用户奖励明细类型  */
typedef NS_ENUM(NSInteger, NNHUserCoinRewardType){
    NNHUserCoinRewardType_exchange = 1,        // 交易佣金奖励  HCoin奖励
    NNHUserCoinRewardType_hold = 2,            // 持仓奖励  CNY奖励
};

/** 发送验证码type  */
typedef NS_ENUM(NSInteger, NNHSendVerificationCodeType){
    NNHSendVerificationCodeType_userRegister = 0,               // 注册发送验证码
    NNHSendVerificationCodeType_userForgetpwd = 1,              // 忘记密码
    NNHSendVerificationCodeType_changeLoginPassword = 2,        // 修改登录密码，发送验证码
    NNHSendVerificationCodeType_changePayPassword = 3,          // 修改资金密码，发送验证码
    NNHSendVerificationCodeType_updatePhone = 4,                // 更新手机号码
    NNHSendVerificationCodeType_LTTrading = 5,                  // 流通 - 交易
    NNHSendVerificationCodeType_ZZTrading = 6,                  // 增值 - 交易
    NNHSendVerificationCodeType_LTWFCC = 7,                     // 流通 - 易物通
    NNHSendVerificationCodeType_ZZWFCC = 8,                     // 增值 - 易物通
    NNHSendVerificationCodeType_TradingLT = 9,                  // 交易 - 流通
    NNHSendVerificationCodeType_LTTransfer = 10,                // 流通 - 转账
    NNHSendVerificationCodeType_TradingWFCC = 11,               // 交易 - WFCC
    NNHSendVerificationCodeType_XFMall = 12,                    // 消费 - 商城
    NNHSendVerificationCodeType_XFWFCC = 13,                    // 消费 - WFCC
    NNHSendVerificationCodeType_WFCCTransfer = 14,              // WFCC - 转账
    NNHSendVerificationCodeType_ZZTransfer = 15                 // 增值 - 转账
};

/** 用户资金操作type */
typedef NS_ENUM(NSInteger, NNHUserFundOperationType){
    NNHUserFundOperationType_default,                    // 不区分充提
    NNHUserFundOperationType_rechargeCoin,               // 充币
    NNHUserFundOperationType_withdrawCoin,               // 提币
    NNHUserFundOperationType_withdrawCNY                 // 提现人民币
};

/** C2C  */
typedef NS_ENUM(NSInteger, NNHCoinTradingOrderType){
    NNHCoinTradingOrderType_buyIn = 0,      // 买进
    NNHCoinTradingOrderType_soldOut = 1,    // 卖出
};

/** 会员中心 资产类型 */
typedef NS_ENUM(NSInteger, NNHMineAssetsType) {
    NNHMineAssetsType_wfcc = 1,  // 报单
    NNHMineAssetsType_lt = 2,  // 流通
    NNHMineAssetsType_zz = 3,  // 增值
    NNHMineAssetsType_xf = 4,  // 消费
    NNHMineAssetsType_sd = 5,  // 锁定
    NNHMineAssetsType_zs = 6,  // 赠送
    NNHMineAssetsType_sc = 7,  // 锁仓
};

/** 转账类型 */
typedef NS_ENUM(NSInteger, NNHWalletTransferType) {
    NNHWalletTransferTypeLTTrading = 1,  // 流通 - 交易
    NNHWalletTransferTypeZZTrading = 2,  // 增值 - 交易
    NNHWalletTransferTypeLTWFCC = 3,  // 流通 - 易物通
    NNHWalletTransferTypeZZWFCC = 4,  // 增值 - 易物通
    NNHWalletTransferTypeTradingLT = 5,  // 交易 - 流通
    NNHWalletTransferTypeLTTransfer = 10,  // 流通 - 转账
    NNHWalletTransferTypeXFMall = 7,  //  消费 - 商城
    NNHWalletTransferTypeTradingWFCC = 8,  // 交易 - 易物通
    NNHWalletTransferTypeXFWFCC = 9,  //  消费 - 易物通
    NNHWalletTransferTypeWFCCTransfer = 11,  //  WFCC - 转账
    NNHWalletTransferTypeZZTransfer = 12,  //  增值 - 转账
    NNHWalletTransferTypeZZAAG = 13,  //  增值 - AAG
    NNHWalletTransferTypeC2C = 20,     //  c2c
};

@interface NNConst : NSObject

#pragma mark -----
#pragma mark ----- 公用
/** 公用-间距-5 操作按钮左右间距 */
UIKIT_EXTERN CGFloat const NNHMargin_5;
/** 公用-间距-10 */
UIKIT_EXTERN CGFloat const NNHMargin_10;
/** 公用-间距-15 */
UIKIT_EXTERN CGFloat const NNHMargin_15;
/** 公用-间距-20 */
UIKIT_EXTERN CGFloat const NNHMargin_20;
/** 公用-间距-25 */
UIKIT_EXTERN CGFloat const NNHMargin_25;
/** 公用-操作按钮高度（登录、确认等）- 40 */
UIKIT_EXTERN CGFloat const NNHOperationButtonH;
/** 公用-操作按钮圆角半径 */
UIKIT_EXTERN CGFloat const NNHOperationButtonRadiu;
/** 公用-所有头部、尾部View、单个Cell（详情等）- 44 */
UIKIT_EXTERN CGFloat const NNHNormalViewH;
/** 公用-所有分割线高度 - 0.5 */
UIKIT_EXTERN CGFloat const NNHLineH;
/** 公用-操作按钮圆角半径 */
UIKIT_EXTERN CGFloat const NNHOperationButtonRadiu;
/** 公用-顶部toolbar的高度 */
UIKIT_EXTERN CGFloat const NNHTopToolbarH;
/** 公用-顶部toolbar的Y */
UIKIT_EXTERN CGFloat const NNHTopToolbarY;
/** 公用-键盘／选择器高度 */
UIKIT_EXTERN CGFloat const NNHKeyboardHeight;
/** 公用-按钮重复点击间隔 */
UIKIT_EXTERN CGFloat const NNHAcceptEventInterval;
/** NBT版本接口 */
UIKIT_EXTERN NSString *const NNHPort;


#pragma mark -----
#pragma mark ----- 所用图比例
/** 广告（除商品详情） 16:9*/
UIKIT_EXTERN CGFloat const NNHRechagreBanner;
/** 广告（除商品详情） 16:9*/
UIKIT_EXTERN CGFloat const NNHIMAGEWHSCALE_169;
/** 首页 banner图宽高比例）0.73 */
UIKIT_EXTERN CGFloat const NNHImageScale_Banner;
/** 激励收益 12：5 */
UIKIT_EXTERN CGFloat const NNHIMAGEWHSCALE_125;
/** 商品管理图片比例 2:3 */
UIKIT_EXTERN CGFloat const NNH_StoreRecommendGoodsImage;
/** 首页 banner图片比例）5:2 */
UIKIT_EXTERN CGFloat const NNHImageScale_Banner_05;


#pragma mark -----
#pragma mark ----- 会员中心
/** 身份证宽高比 */
UIKIT_EXTERN CGFloat const NNHCardScale;
/** 客服电话 */
UIKIT_EXTERN NSString *const NNHServicePhone;
/** 客服微信 */
UIKIT_EXTERN NSString *const NNHServiceWeChat;
/** 我的分享/我的余额／单个角色topview高度 */
UIKIT_EXTERN CGFloat const NNHMyRoleFenRunTopViewHeight;
/** 我的余额特殊角色高度比例 */
UIKIT_EXTERN CGFloat const NNHMyRoleFenRunTopViewLongerHeight;

// 会员中心首页文字
/** 我的余额 */
UIKIT_EXTERN NSString *const NNHMineBalanceText;
/** 抵扣金总额 */
UIKIT_EXTERN NSString *const NNHMineBonusText;
/** 待增奖励 */
UIKIT_EXTERN NSString *const NNHMineNFRewardText;
/** 我的角色 */
UIKIT_EXTERN NSString *const NNHMineRoleText;
/** 实体店管理 */
UIKIT_EXTERN NSString *const NNHMineStoreManageText;
/** 角色介绍 */
UIKIT_EXTERN NSString *const NNHMineNZGRoleIntroduceText;
/** 角色介绍 */
UIKIT_EXTERN NSString *const NNHMineNSRoleIntroduceText;


#pragma mark -----
#pragma mark ----- 全部评论
/** 评论 - 头像的最大Y值 */
UIKIT_EXTERN CGFloat const NNHCommentsIconMaxY;
/** 评论 - 图片间距 */
UIKIT_EXTERN CGFloat const NNHCommentsimageMargin;
/** 评论 - 最大图片数 */
UIKIT_EXTERN CGFloat const NNHCommentsimagesCount;


#pragma mark -----
#pragma mark ----- 订单详情
/** 订单详情状态提示viewH */
UIKIT_EXTERN CGFloat const NNHOrderDetailPromptViewH;
/** 订单详情操作viewH */
UIKIT_EXTERN CGFloat const NNHOrderDetailOperationViewH;
/** 订单详情信息viewH */
UIKIT_EXTERN CGFloat const NNHOrderDetailInformationViewH;


#pragma mark -----
#pragma mark ----- ShareSDK其他接口的appkey
/** ShareSDK-Appkey */
UIKIT_EXTERN NSString *const NNH_ShareSDK_Appkey;
/** ShareSDK-AppSecret */
UIKIT_EXTERN NSString *const NNH_ShareSDK_AppSecret;
/** 微信、朋友圈AppID */
UIKIT_EXTERN NSString *const NNH_ShareSDK_WEIXIN_APPID_INDEX;
/** 微信、朋友圈SECRET */
UIKIT_EXTERN NSString *const NNH_ShareSDK_WEIXIN_SECRET_INDEX;
/** 新浪微博-Appkey */
UIKIT_EXTERN NSString *const NNH_ShareSDK_SinaWeiBo_AppKey;
/** 新浪微博-AppSecret */
UIKIT_EXTERN NSString *const NNH_ShareSDK_SinaWeiBo_AppSecret;
/** QQ-AppID */
UIKIT_EXTERN NSString *const NNH_ShareSDK_QQ_AppID;
/** QQ-AppKey */
UIKIT_EXTERN NSString *const NNH_ShareSDK_QQ_AppKey;

/** 融云-AppKey开发环境 */
UIKIT_EXTERN NSString *const NNH_RongCloud_Appkey_Develop;
/** 融云-AppKey */
UIKIT_EXTERN NSString *const NNH_RongCloud_Appkey;
/** 融云-单聊消息 订单处理消息 */
UIKIT_EXTERN NSString *const NNH_RongCloud_Message_OrderHandle;
/** 融云-单聊消息 分润收益消息 */
 UIKIT_EXTERN NSString *const NNH_RongCloud_Message_Income;
/** 融云-单聊消息 加油提现消息 */
UIKIT_EXTERN NSString *const NNH_RongCloud_Message_RechargeOrWidth;
/** 融云-单聊消息 系统消息 */
UIKIT_EXTERN NSString *const NNH_RongCloud_Message_System;
#pragma mark -----
#pragma mark ----- 货币
/** NBT货币 */
UIKIT_EXTERN NSString *const NNHCurrency;

#pragma mark -----
#pragma mark ----- 高德地图
/** NBT货币 */
UIKIT_EXTERN NSString *const NNH_MAMapSDKAppKey;
UIKIT_EXTERN NSString *const NNH_UMengAppKey;

#pragma mark -----
#pragma mark ----- 项目安全相关
/** 私钥 */
UIKIT_EXTERN NSString *const NNHAPI_PRIVATEKEY_IOS;

#pragma mark -----
#pragma mark ----- 其他
/** 用户位置 属性列表保存字段  上次保存的城市名 */
UIKIT_EXTERN NSString *const NNH_User_Location_lastSaveCityName;
/** 用户位置 属性列表保存字段  当前城市 */
UIKIT_EXTERN NSString *const NNH_User_CurrentLocation_cityName;
/** 用户位置 属性列表保存字段  经度 */
UIKIT_EXTERN NSString *const NNH_User_CurrentLocation_longitude;
/** 用户位置 属性列表保存字段  纬度 */
UIKIT_EXTERN NSString *const NNH_User_CurrentLocation_latitude;
/** 保存用户当前城市id */
UIKIT_EXTERN NSString *const NNH_User_CurrentLocation_cityID;
/** 保存推送的token */
UIKIT_EXTERN NSString *const NNH_User_Device_push_token;

#pragma mark -----
#pragma mark ----- 实体店
/** 实体店我要收款页面 属性列表保存实体店平台号 */
UIKIT_EXTERN NSString *const NNH_Store_storePayCollection_businessCode;


/** 实体店外卖保存 当前下单商品的数据库名称 */
UIKIT_EXTERN NSString *const NNH_Store_storeTakeoutSave_sqliteName;


@end
