//
//  NNHApiLoginTool.h
//  NNHPlatform
//
//  Created by leiliao lai on 17/3/4.
//  Copyright © 2017年 NBT. All rights reserved.
//

#import "NNHBaseRequest.h"

@interface NNHApiLoginTool : NNHBaseRequest

/**
 登陆
 
 @param username 用户名（必填）
 @param loginpwd 密码 （必填）
 @return 登录
 */

- (instancetype)initLoginWithUserName:(NSString *)username
                             loginpwd:(NSString *)loginpwd;


/**
 注册
 
 @param mobile 手机号 （必填）
 @param valicode 验证码 （必填）
 @param loginpwd 密码 （必填）
 @param paypwd 支付密码 （必填）
 @param parentname 推荐人用户名
 @param nodename 接点用户名
 @param position 接点位置(1为左 2为右)
 @param checkcode 推荐人校验码
 @return 注册
 */
- (instancetype)initRegisterWithMobile:(NSString *)mobile
                              valicode:(NSString *)valicode
                              username:(NSString *)username
                            parentname:(NSString *)parentname
                              nodename:(NSString *)nodename
                              position:(NSString *)position
                              loginpwd:(NSString *)loginpwd
                                paypwd:(NSString *)paypwd
                             checkcode:(NSString *)checkcode
                           countrycode:(NSString *)countrycode;

/**
 用户注册或修改登录密码
 
 @param mobile 手机号 （必填）
 @param valicode 验证码 （必填）
 @param loginpwd 登录密码
 @param confirmpwd nickname
 @param typeregister 登录类型 1 注册  2修改密码
 @return 注册
 */
- (instancetype)initWithMobile:(NSString *)mobile
                      valicode:(NSString *)valicode
                      loginpwd:(NSString *)loginpwd
                    confirmpwd:(NSString *)confirmpwd
                   typeregister:(NSString *)typeregister;


/**
 登录验证
 @param mobile 验证手机
 */
- (instancetype)initLoginValidationWithMobile:(NSString *)mobile;

/**
 注册请求郭嘉手机号编码
 
 @return api
 */
- (instancetype)initCountryCodeData;
@end
