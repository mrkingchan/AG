//
//  NNHApiSecurityTool.h
//  NNHBitooex
//
//  Created by 来旭磊 on 2018/3/19.
//  Copyright © 2018年 深圳市云牛惠科技有限公司. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           安全中心相关api接口
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import "NNHBaseRequest.h"

@interface NNHApiSecurityTool : NNHBaseRequest


/**
 发送验证码

 @param mobile 手机号码
 @param type 验证码类型
 @return 实例对象
 */
- (instancetype)initWithMobile:(NSString *)mobile
                verifyCodeType:(NNHSendVerificationCodeType)type
                   countryCode:(NSString *)countryCode;

/**
 发送验证码 （适用于忘记密码）
 
 @param mobile 手机号码
 @param username 用户名
 @return 实例对象
 */
- (instancetype)initWithMobile:(NSString *)mobile
                      username:(NSString *)username;



/**
 重置密码短信验证
 
 @param mobile 手机号码
 @param code 验证码
 @return 实例对象
 */
- (instancetype)initResetPasswordValidationWithMobile:(NSString *)mobile
                                                 code:(NSString *)code
                                             username:(NSString *)username
                                             codeType:(NNHSendVerificationCodeType)codeType;

/**
 设置资金密码

 @param code 资金密码
 @param isFirst 是不是第一次设置
 @return 实例对象
 */
- (instancetype)initWithSetupPaycode:(NSString *)code
                             isFirst:(BOOL)isFirst;



/**
 设置登录密码
 
 @return 实例对象
 */
- (instancetype)initSetUpPasswordWithPassword:(NSString *)password
                                   confirmpwd:(NSString *)confirmpwd;


/**
 修改登录密码

 @return 实例对象
 */
- (instancetype)initUpdatePwdWithMobile:(NSString *)mobile
                               username:(NSString *)username
                                encrypt:(NSString *)encrypt
                                    pwd:(NSString *)pwd
                             confirmpwd:(NSString *)confirmpwd;

/**
 修改手机号码
 
 @return 实例对象
 */
- (instancetype)initUpdatePhoneWithMobile:(NSString *)mobile
                                 valicode:(NSString *)valicode;


@end
