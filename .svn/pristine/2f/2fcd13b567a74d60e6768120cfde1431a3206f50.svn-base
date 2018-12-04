//
//  NNHApiLoginTool.m
//  NNHPlatform
//
//  Created by leiliao lai on 17/3/4.
//  Copyright © 2017年 NBT. All rights reserved.
//

#import "NNHApiLoginTool.h"
#import "NSString+Hash.h"

@implementation NNHApiLoginTool

- (instancetype)initLoginWithUserName:(NSString *)username
                             loginpwd:(NSString *)loginpwd
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.login.login";
        self.reAPIName = @"用户登录";
        
        self.reParams = @{
                              @"devtype"        : @"I",
                              @"username"         : username,
                              @"loginpwd"       : [loginpwd md5String]
                          };
    }
    return self;
}

- (instancetype)initRegisterWithMobile:(NSString *)mobile
                              valicode:(NSString *)valicode
                              username:(NSString *)username
                            parentname:(NSString *)parentname
                              nodename:(NSString *)nodename
                              position:(NSString *)position
                              loginpwd:(NSString *)loginpwd
                                paypwd:(NSString *)paypwd
                             checkcode:(NSString *)checkcode
                           countrycode:(NSString *)countrycode
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.register.register";
        self.reAPIName = @"用户注册";
        
        if (!checkcode) checkcode = @"";

        if (!countrycode) {
            countrycode = @"+86";
        }
        
        self.reParams = @{
                              @"devtype"        : @"I",
                              @"mobile"          : mobile,
                              @"loginpwd"       : [loginpwd md5String],
                              @"paypwd"         : [paypwd md5String],
                              @"username"       : username,
                              @"valicode"       : [self md5WithCode:valicode],
                              @"parentname"      : parentname,
                              @"nodename"      : nodename,
                              @"position"      : position,
                              @"checkcode"      : checkcode,
                              @"countrycode"    : countrycode,
                          };
    }
    return self;
}

- (instancetype)initWithMobile:(NSString *)mobile
                      valicode:(NSString *)valicode
                      loginpwd:(NSString *)loginpwd
                    confirmpwd:(NSString *)confirmpwd
                  typeregister:(NSString *)typeregister
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.login.register";
        self.reAPIName = @"用户注册或修改密码";
        
        if (!confirmpwd.length) {
            confirmpwd = @"";
        }
        
        self.reParams = @{
                          @"devtype"        : @"I",
                          @"mobile"         : mobile,
                          @"valicode"       : [self md5WithCode:valicode],
                          @"loginpwd"       : [loginpwd md5String],
                          @"confirmpwd"     : [confirmpwd md5String],
                          @"typeregister"   : typeregister,
                          };  
    
    }
    return self;
}

- (instancetype)initLoginValidationWithMobile:(NSString *)mobile
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.login.bindmobile";
        self.reAPIName = @"登录验证";
        
        self.reParams = @{
                          @"recommendMobile" : mobile
                          };
    }
    return self;
}

- (NSString *)md5WithCode:(NSString *)code
{
    NSString *string = [NSString stringWithFormat:@"%@%@",code,NNHAPI_PRIVATEKEY_IOS];
    return [string md5String];
}

- (instancetype)initCountryCodeData
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.public.getcountrycode";
        self.reAPIName = @"获取国家代码";
    }
    return self;
}

@end
