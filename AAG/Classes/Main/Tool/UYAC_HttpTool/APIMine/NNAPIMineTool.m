//
//  NNAPIMineTool.m
//  YWL
//
//  Created by 牛牛 on 2018/3/27.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNAPIMineTool.h"
#import "NSString+Hash.h"

@implementation NNAPIMineTool

- (instancetype)initMemberDataSource
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_User_Index;
        self.reAPIName = @"会员中心";
        self.hiddenProgressHUD = YES;
    }
    return self;
}

- (instancetype)initMyQrCode
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_User_Mycode;
        self.reAPIName = @"我的二维码";
    }
    return self;
}

- (instancetype)initMyNoticeWithPage:(NSUInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.article.articlelist";
        self.reAPIName = @"公告中心";
        self.reParams = @{@"page" : [NSString stringWithFormat:@"%zd",page]};
    }
    return self;
}

- (instancetype)initMyCommunityWithPage:(NSUInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.index.getcommunitylist";
        self.reAPIName = @"社群明细列表";
        self.reParams = @{@"page" : [NSString stringWithFormat:@"%zd",page]};
    }
    return self;
}

/** 获取用户绑定银行卡列表 */
- (instancetype)initBankCardList
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.user.banklist";
        self.reAPIName = @"获取用户绑定银行卡列表";
    }
    return self;
}

/** 根据银行卡号码识别对应银行 */
- (instancetype)initGetBankNameWithPreBankCardNum:(NSString *)bankNum
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.user.checkBankNumber";
        self.reAPIName = @"根据银行卡号码识别对应银行";
        self.reParams = @{
                          @"account_number"   : bankNum,
                          };
    }
    return self;
}

- (instancetype)initAddNewBankCardWithAccountType:(NSString *)account_type
                                     account_name:(NSString *)account_name
                                   account_number:(NSString *)account_number bank_type_name:(NSString *)bank_type_name
                                           branch:(NSString *)branch
                                           mobile:(NSString *)mobile
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.user.addbank";
        self.reAPIName = @"添加银行卡";
        self.reParams = @{
                          @"account_type"   : account_type,
                          @"account_name"   : account_name,
                          @"account_number" : account_number,
                          @"bank_type_name" : bank_type_name,
                          @"branch"         : branch,
                          @"mobile"         : mobile,
                          };
    }
    return self;
}

- (instancetype)initAddPaymentCodeWithName:(NSString *)name
                                  codeType:(NSString *)codeType
                                 payNumber:(NSString *)payNumber
                                       img:(NSString *)img
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.user.addpaybank";
        self.reAPIName = @"添加微信/支付宝收款码";
        
        self.reParams = @{
                          @"account_name" : name,
                          @"type" : codeType,
                          @"account_number" : payNumber,
                          @"img" : img
                          };
    }
    return self;
}

/** 解绑银行卡操作 */
- (instancetype)initUnBankWithCardID:(NSString *)cardID
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.user.unband";
        self.reAPIName = @"解绑银行卡";
        self.reParams = @{
                          @"bank_id"   : cardID,
                          };
    }
    return self;
}

- (instancetype)initUploadImage
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"sys.upload.policy";
        self.reAPIName = @"上传图片";
    }
    return self;
}

- (instancetype)initWithRealName:(NSString *)name
                        idnumber:(NSString *)idnumber
                       idcardimg:(NSString *)idcardimg
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.user.auth";
        self.reAPIName = @"实名认证";
        self.reParams = @{@"realname"   : name,
                          @"idnumber"   : idnumber,
                          @"idcardimg"  : idcardimg
                          };
    }
    return self;
}

- (instancetype)initAuthInfo
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.user.authinfo";
        self.reAPIName = @"实名认证信息";
    }
    return self;
}

#pragma mark --
#pragma mark -- 订单
- (instancetype)initMyOrderListWithPage:(NSUInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"order.index.orderlist";
        self.reAPIName = @"我的订单";
        self.reParams = @{@"page" : [NSString stringWithFormat:@"%zd",page]};
    }
    return self;
}

// 取消订单
- (instancetype)initCancleMyOrderWitID:(NSString *)orderID payPwd:(NSString *)pwd
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"order.index.revoke";
        self.reAPIName = @"订单撤销功能";
        
        if (!pwd) {
            pwd = @"";
        }
        
        self.reParams = @{@"orderno" : orderID, @"paypassword" : [pwd md5String]};
    }
    return self;
}


@end
