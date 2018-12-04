//
//  NNHUserModel.m
//  NNHPlatform
//
//  Created by 牛牛 on 2017/3/15.
//  Copyright © 2017年 NBT. All rights reserved.
//

#import "NNUserModel.h"

NSString *const NNH_mtoken = @"NNH_mtoken";
NSString *const NNH_username = @"NNH_username";
NSString *const NNH_nickname = @"NNH_nickname";
NSString *const NNH_truename = @"NNH_truename";
NSString *const NNH_headerpic = @"NNH_headerpic";
NSString *const NNH_idcardauth = @"NNH_idcardauth";
NSString *const NNH_idcard = @"NNH_idcard";
NSString *const NNH_logisticsDec = @"NNH_logisticsDec";
NSString *const NNH_mobile = @"NNH_mobile";
NSString *const NNH_payDec = @"NNH_payDec";
NSString *const NNH_completemobile = @"NNH_completemobile";
NSString *const NNH_isloginpwd = @"NNH_isloginpwd";
NSString *const NNH_area = @"NNH_area";
NSString *const NNH_area_code = @"NNH_area_code";
NSString *const NNH_isbank = @"NNH_isbank";
NSString *const NNH_isagent = @"NNH_isagent";
NSString *const NNH_rushbuyurl = @"NNH_rushbuyurl";
NSString *const NNH_tradeoperurl = @"NNH_tradeoperurl";
NSString *const NNH_mallurl = @"NNH_mallurl";

@implementation NNUserModel

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init]) {
        
        NSString * (^decodeStringForKey) (NSString * key) = ^NSString *(NSString *key) {
            return [aDecoder decodeObjectForKey:key] ;
        };
        
        self.mtoken = decodeStringForKey(NNH_mtoken);
        self.username = decodeStringForKey(NNH_username);
        self.nickname = decodeStringForKey(NNH_nickname);
        self.realname = decodeStringForKey(NNH_truename);
        self.headerpic = decodeStringForKey(NNH_headerpic);
        self.isnameauth = decodeStringForKey(NNH_idcardauth);
        self.idnumber = decodeStringForKey(NNH_idcard);
        self.logisticsDec = decodeStringForKey(NNH_logisticsDec);
        self.mobile = decodeStringForKey(NNH_mobile);
        self.payDec = decodeStringForKey(NNH_payDec);
        self.completemobile = decodeStringForKey(NNH_completemobile);
        self.isloginpwd = decodeStringForKey(NNH_isloginpwd);
        self.banknumber = decodeStringForKey(NNH_isbank);
        self.tradeoperurl = decodeStringForKey(NNH_tradeoperurl);
        self.mallurl = decodeStringForKey(NNH_mallurl);
    }
    return self;
    
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    void (^encodeStringForKey) (NSString *stringValue, NSString * key) = ^(NSString *stringValue, NSString *key) {
        [aCoder encodeObject:stringValue  forKey:key];
    };
    
    encodeStringForKey(self.mtoken,NNH_mtoken);
    encodeStringForKey(self.username,NNH_username);
    encodeStringForKey(self.nickname,NNH_nickname);
    encodeStringForKey(self.realname,NNH_truename);
    encodeStringForKey(self.headerpic,NNH_headerpic);
    encodeStringForKey(self.isnameauth,NNH_idcardauth);
    encodeStringForKey(self.idnumber,NNH_idcard);
    encodeStringForKey(self.logisticsDec,NNH_logisticsDec);
    encodeStringForKey(self.mobile,NNH_mobile);
    encodeStringForKey(self.payDec,NNH_payDec);
    encodeStringForKey(self.completemobile,NNH_completemobile);
    encodeStringForKey(self.isloginpwd,NNH_isloginpwd);
    encodeStringForKey(self.banknumber,NNH_isbank);
    encodeStringForKey(self.tradeoperurl,NNH_tradeoperurl);
    encodeStringForKey(self.mallurl,NNH_mallurl);
}

@end
