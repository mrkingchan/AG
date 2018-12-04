//
//  NSString+NNHExtension.h
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/19.
//  Copyright © 2016年 NBT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NNHExtension)

// 谁调用就计算谁的size
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

- (CGSize)sizeWithFont:(UIFont *)font;

/**
 *  是否为纯数字
 */
- (BOOL)nn_isValidNumber;

/**
 *  是否为电话号码
 */
- (BOOL)checkIsPhoneNumber;

/**
 *  检测是否为邮箱
 */
- (BOOL)checkIsEmail;

/**
 *  验证身份证号（15位或18位数字）
 */
- (BOOL)checkIsCardNumber;

/** 检测是否是昵称 只包含数字 字母 下划线 中文 且8-16位 */
- (BOOL)checkIsValidateNickname;

/** 正则匹配用户密码 6 - 20 位数字和字母组合 */
- (BOOL)checkPassWord;

/** 校验银行卡格式 */
+ (BOOL)checkCardNum:(NSString*)cardNum;

/*!
 @method
 @brief     检测字符串是否为空
 */
+ (BOOL)isEmptyString:(NSString *)string;

// 判断字符串内容是否合法：2-12位汉字、字母、数字
- (BOOL)validateFormatByRegexForString:(NSString *)string;

/** 安全处理 */
- (NSString *)replaceStringWithAsterisk:(NSInteger)startLocation length:(NSInteger)length;

+ (NSString *)JsonModel:(NSDictionary *)dictModel;

+ (NSString *)arrayToJSONString:(NSArray *)array;

/** 拼接牛豆 元 */
+ (NSString *)goodsPriceWithAmount:(NSString *)amount bull:(NSString *)bull;

/** 拼接牛豆 元 运费*/
+ (NSString *)goodsPriceWithAmount:(NSString *)amount bull:(NSString *)bull franking:(NSString *)franking;


/** 获取时间格式 年月日 */
+ (NSString *)nnh_hourStringWithTimeStamp:(NSString *)stamp;


/**
 获取格式时间

 @param stamp 时间戳
 @return 获取格式时间
 */
+ (NSString *)dateStringWithTimeStamp:(NSString *)stamp;


/**
 *
 *  @brief  毫秒时间戳 例如 1443066826371
 *
 *  @return 毫秒时间戳
 */
+ (NSString *)nn_Timestamp;


/**
 *
 *  @brief  获取url所有参数
 *
 *  @return 所有参数
 */
- (NSDictionary *)getUrlParameters;



@end
