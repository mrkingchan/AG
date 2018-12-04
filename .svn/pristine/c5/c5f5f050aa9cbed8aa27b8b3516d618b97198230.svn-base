//
//  NNAPIBlockFundTransferTool.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/14.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNAPIBlockFundTransferTool.h"
#import "NSString+Hash.h"

@implementation NNAPIBlockFundTransferTool

- (instancetype)initWalletTransferWithTransferType:(NNHWalletTransferType)transferType
                                       transferNum:(NSString *)transferNum
                                           account:(NSString *)account
                                  verificationCode:(NSString *)verificationCode
                                            paypwd:(NSString *)paypwd
{
    self = [super init];
    if (self) {
        
        if (transferType == NNHWalletTransferTypeLTTrading) {
            self.requestReServiceType = @"user.transfer.cytotd";
        }else if (transferType == NNHWalletTransferTypeZZTrading) {
            self.requestReServiceType = @"user.transfer.inctotd";
        }else if (transferType == NNHWalletTransferTypeLTWFCC) {
            self.requestReServiceType = @"user.transfer.cytowl";
        }else if (transferType == NNHWalletTransferTypeZZWFCC) {
            self.requestReServiceType = @"user.transfer.inctowl";
        }else if (transferType == NNHWalletTransferTypeLTTransfer) {
            self.requestReServiceType = @"amount.circulationamount.addcointransfer";
        }else if (transferType == NNHWalletTransferTypeTradingLT) {
            self.requestReServiceType = @"user.circulationamount.addtradetocirculatorder";
        }else if (transferType == NNHWalletTransferTypeTradingWFCC) {
            self.requestReServiceType = @"user.transfer.tdtowl";
        }else if (transferType == NNHWalletTransferTypeXFWFCC) {
            self.requestReServiceType = @"user.consumption.transfer";
        }else if (transferType == NNHWalletTransferTypeWFCCTransfer) {
            self.requestReServiceType = @"amount.circulationamount.addwfcctransfer";
        }else if (transferType == NNHWalletTransferTypeZZTransfer) {
            self.requestReServiceType = @"amount.circulationamount.addincretransfer";
        }else if (transferType == NNHWalletTransferTypeZZAAG) {
            self.requestReServiceType = @"user.transfer.inctoaag";
        }else{
            self.requestReServiceType = @"user.transfer.cptomall";
        }
        
        if (!account) {
            account = @"";
        }
        if (!paypwd) {
            paypwd = @"";
        }
        
        self.reAPIName = @"区块资产内部转账";
        self.reParams = @{
                              @"amount"             :   transferNum,
                              @"valicode"           :   [self md5WithCode:verificationCode],
                              @"paypassword"        :   [paypwd md5String],
                              @"tousername"         :   account
                         };
    }
    return self;
}

- (instancetype)initWalletTransferRecordWithTransferType:(NNHWalletTransferType)transferType
                                                    page:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.amount.transflowlist";
        self.reAPIName = @"转账明细";
        
        NSString *type;
        if (transferType == NNHWalletTransferTypeLTWFCC) {
            type = @"11";
        }else if (transferType == NNHWalletTransferTypeZZWFCC) {
            type = @"12";
        }else if (transferType == NNHWalletTransferTypeLTTransfer) {
            type = @"17";
        }else if (transferType == NNHWalletTransferTypeTradingWFCC) {
            type = @"14";
        }else if (transferType == NNHWalletTransferTypeLTTrading) {
            type = @"15";
        }else if (transferType == NNHWalletTransferTypeZZTrading) {
            type = @"16";
        }else if (transferType == NNHWalletTransferTypeXFWFCC) {
            type = @"8";
        }else if (transferType == NNHWalletTransferTypeWFCCTransfer) {
            type = @"18";
        }else if (transferType == NNHWalletTransferTypeZZTransfer) {
            type = @"19";
        }else if (transferType == NNHWalletTransferTypeC2C) {
            type = @"5";
        }else {
            type = @"13";
        }
        
        self.reParams = @{
                              @"type"  : type,
                              @"page"  : [NSString stringWithFormat:@"%zd",page]                              
                         };
        
    }
    return self;
}

- (instancetype)initBlockFundTransferRecorWithPage:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"trade.transfer.zhuangzhanglist";
        self.reAPIName = @"转账记录";
        
        self.reParams = @{
                          @"page"  : [NSString stringWithFormat:@"%zd",page],
                          };
        
    }
    return self;
}

- (instancetype)initBalanceFundTransferToConsumeFundWithNum:(NSString *)num
                                                       type:(NSString *)type
                                                     paypwd:(NSString *)paypwd
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"finance.finance.transferconsumption";
        self.reAPIName = @"转到消费资产";
        self.reParams = @{
                          @"num"           :   num,
                          @"type"          :   type,
                          @"paypwd"        :   [paypwd md5String],
                          
                          };
    }
    return self;
}

- (instancetype)initConsumeFundTransferRecordWithPage:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"finance.finance.consumptionlog";
        self.reAPIName = @"转到消费资产记录";
        
        self.reParams = @{
                          @"page"  : [NSString stringWithFormat:@"%zd",page],
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
