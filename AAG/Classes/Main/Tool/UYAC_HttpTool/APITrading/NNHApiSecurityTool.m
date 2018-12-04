//
//  NNHApiSecurityTool.m
//  NNHBitooex
//
//  Created by 来旭磊 on 2018/3/19.
//  Copyright © 2018年 深圳市云牛惠科技有限公司. All rights reserved.
//

#import "NNHApiSecurityTool.h"
#import "NSString+Hash.h"

@implementation NNHApiSecurityTool

- (instancetype)initWithMobile:(NSString *)mobile
                verifyCodeType:(NNHSendVerificationCodeType)type
                   countryCode:(NSString *)countryCode
{
    self = [super init];
    if (self) {
        
        NSString *sendType = @"";
        if (type == NNHSendVerificationCodeType_userRegister) {
            sendType = @"register_";
        }else if (type == NNHSendVerificationCodeType_changePayPassword) {
            sendType = @"update_pay_";
        }else if (type == NNHSendVerificationCodeType_updatePhone){
            sendType = @"update_phone_";
        }else if (type == NNHSendVerificationCodeType_LTTrading){
            sendType = @"cy_to_td_";
        }else if (type == NNHSendVerificationCodeType_ZZTrading){
            sendType = @"inc_to_td_";
        }else if (type == NNHSendVerificationCodeType_LTWFCC){
            sendType = @"cy_to_wl_";
        }else if (type == NNHSendVerificationCodeType_ZZWFCC){
            sendType = @"inc_to_wl_";
        }else if (type == NNHSendVerificationCodeType_TradingLT){
            sendType = @"trade_transfer_";
        }else if (type == NNHSendVerificationCodeType_LTTransfer){
            sendType = @"country_transfer_";
        }else if (type == NNHSendVerificationCodeType_XFMall){
            sendType = @"cp_to_mall_";
        }else if (type == NNHSendVerificationCodeType_TradingWFCC){
            sendType = @"td_to_wl_";
        }else if (type == NNHSendVerificationCodeType_XFWFCC){
            sendType = @"consumption_transfer_";
        }else if (type == NNHSendVerificationCodeType_WFCCTransfer){
            sendType = @"wfcc_transfer_";
        }else if (type == NNHSendVerificationCodeType_ZZTransfer){
            sendType = @"incre_transfer_";
        }else{
            sendType = @"update_loginpwd_";
        }
        
        NSString *username = @"";
        if (type != NNHSendVerificationCodeType_userRegister) {
            username = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.username;
        }
        
        if (!countryCode) {
            countryCode = @"86";
        }
        
        self.requestReServiceType = @"user.public.sendvalicode";
        self.reAPIName = @"发送短信验证码";
        self.reParams = @{
                          @"mobile"         : mobile,
                          @"username"       : username,
                          @"devicenumber"  :[[NNHProjectControlCenter sharedControlCenter].proConfig getUUId],
                          @"privatekey"     : [self md5WithCode:mobile],
                          @"sendType"       : sendType,
                          @"countrycode"    : countryCode,
                          };
    }
    return self;
}

- (instancetype)initWithMobile:(NSString *)mobile
                      username:(NSString *)username
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.public.sendvalicode";
        self.reAPIName = @"发送短信验证码";
        self.reParams = @{
                          @"mobile"         : mobile,
                          @"username"       : username,
                          @"devicenumber"   :[[NNHProjectControlCenter sharedControlCenter].proConfig getUUId],
                          @"privatekey"     : [self md5WithCode:mobile],
                          @"sendType"       : @"update_loginpwd_"
                          };
    }
    return self;
}

- (instancetype)initResetPasswordValidationWithMobile:(NSString *)mobile
                                                 code:(NSString *)code
                                             username:(NSString *)username
                                             codeType:(NNHSendVerificationCodeType)codeType
{
    self = [super init];
    if (self) {
        
        if (codeType == NNHSendVerificationCodeType_changePayPassword) {
            self.requestReServiceType = @"user.user.validPhonePay";
            self.reAPIName = @"校验修改支付密码验证码";
            self.reParams = @{
                              @"valicode"   : [self md5WithCode:code],
                              @"mobile"  : mobile
                              };
        }else if (codeType == NNHSendVerificationCodeType_updatePhone) {
            self.requestReServiceType = @"user.user.validupdatephone";
            self.reAPIName = @"校验修改手机号码校验操作";
            self.reParams = @{
                              @"valicode"   : [self md5WithCode:code],
                              @"mobile"  : mobile
                              };
        }else {
            self.requestReServiceType = @"user.user.validloginpwd";
            self.reAPIName = @"找回登录密码/修改登录密码 短信验证";
            self.reParams = @{
                              @"valicode"   : [self md5WithCode:code],
                              @"username"   : username,
                              @"mobile"     : mobile
                              };
        }
    }
    return self;
}

/** 修改资金密码 */
- (instancetype)initWithSetupPaycode:(NSString *)paypwd isFirst:(BOOL)isFirst
{
    self = [super init];
    if (self) {
        
        if (isFirst) {
            self.requestReServiceType = @"user.user.setPay";
            self.reAPIName = @"设置支付密码";
        }else{
            self.requestReServiceType = @"user.user.updatePayPwd";
            self.reAPIName = @"修改支付密码";
        }
        
        self.reParams = @{@"paypwd" : [paypwd md5String]};
    }
    return self;
}

- (instancetype)initSetUpPasswordWithPassword:(NSString *)password
                                   confirmpwd:(NSString *)confirmpwd
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.user.setloginpwd";
        self.reAPIName = @"设置登录密码";
        
        self.reParams = @{
                              @"loginpwd" : [password md5String],
                              @"confirmpwd" : [confirmpwd md5String]
                          };
    }
    return self;
}

- (instancetype)initUpdatePwdWithMobile:(NSString *)mobile
                               username:(NSString *)username
                                encrypt:(NSString *)encrypt
                                    pwd:(NSString *)pwd
                             confirmpwd:(NSString *)confirmpwd
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.user.updateloginpwd";
        self.reAPIName = @"找回登录密码/修改登录密码操作";
        
        self.reParams = @{
                              @"mobile" : mobile,
                              @"username" : username,
                              @"encrypt" : encrypt,
                              @"loginpwd" : [pwd md5String],
                              @"confirmpwd" : [confirmpwd md5String]
                          };
    }
    return self;
}

- (instancetype)initUpdatePhoneWithMobile:(NSString *)mobile
                                 valicode:(NSString *)valicode
{
    if (self = [super init]) {        
        self.requestReServiceType = @"user.user.updatePhone";
        self.reAPIName = @"校修改用户手机号码操作";
        self.reParams = @{
                          @"valicode"   : [self md5WithCode:valicode],
                          @"mobile"  : mobile
                          };
    }
    return self;
}

- (NSString *)md5WithCode:(NSString *)code
{
    NSString *string = [NSString stringWithFormat:@"%@%@",code,NNHAPI_PRIVATEKEY_IOS];
    return [string md5String];
}

@end
