//
//  NNHAPIConsumerTradeTool.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/15.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNHAPIConsumerTradeTool.h"
#import "NSString+Hash.h"

@implementation NNHAPIConsumerTradeTool

- (instancetype)initTradeCurrentEntrusetListDataWithPage:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"trade.index.wtlist";
        self.reAPIName = @"当前委托";
        
        self.reParams = @{
                          @"page"  : [NSString stringWithFormat:@"%zd",page],
                          };
    }
    return self;
}

- (instancetype)initTradeHistoryEntrusetListDataWithPage:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"trade.index.histwtlist";
        self.reAPIName = @"历史委托";
        
        self.reParams = @{
                          @"page"  : [NSString stringWithFormat:@"%zd",page],
                          };
    }
    return self;
}

- (instancetype)initOrderCoinData
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"trade.index.beforeuptrade";
        self.reAPIName = @"发布交易单 价格信息";
    }
    return self;
}

- (instancetype)initReleaseOrderWithTradeType:(NNConsumerTradeType)tradeType
                                  paypassword:(NSString *)paypassword
                                        price:(NSString *)price
                                          num:(NSString *)num
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"trade.index.uptrade";
        self.reAPIName = @"发布订单 买入卖出";
        
        NSString *buyType = @"1";
        if (tradeType == NNConsumerTradeType_sell) {
            buyType = @"2";
        }
        
        self.reParams = @{
                          @"paypassword"    : [paypassword md5String],
                          @"price"          : price,
                          @"num"            : num,
                          @"buy_type"       : buyType,
                          };
    }
    return self;
}

- (instancetype)initMatchOrderListDataWithTradeType:(NNConsumerTradeType)tradeType
                                               page:(NSInteger)page
{
    
    self = [super init];
    if (self) {
        
        if (tradeType == NNConsumerTradeType_sell) {
            self.requestReServiceType = @"trade.index.buywtlist";
            self.reAPIName = @"C2C交易 买入挂单";
        }else {
            self.requestReServiceType = @"trade.index.sallwtlist";
            self.reAPIName = @"C2C交易 卖出挂单";
        }
        self.hiddenProgressHUD = YES;
        
        self.reParams = @{
                          @"page"   : [NSString stringWithFormat:@"%zd", page],
                          };
    }
    return self;
}

- (instancetype)initWithTradeInfoDatailDataWithTradeID:(NSString *)tradeID
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"trade.index.tradeinfo";
        self.reAPIName = @"交易详情";
        
        self.reParams = @{
                          @"tradeid"  : tradeID,
                          };
    }
    return self;
}


- (instancetype)initDoDealTradeID:(NSString *)tradeID
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"trade.index.dotrade";
        self.reAPIName = @"买入卖出C2C";
        
        self.reParams = @{
                          @"tradeid"  : tradeID,
                          };
    }
    return self;
}

- (instancetype)initWithConfirmPayOrderWithTradeID:(NSString *)traderID
                                          password:(NSString *)password
                                           payType:(NSString *)payType
{
    self = [super init];
    if (self) {
        
        self.requestReServiceType = @"trade.index.paytrade";
        self.reAPIName = @"C2C交易 买家确认付款";
        self.reParams = @{
                          @"tradeid"   : traderID,
                          @"paytype"   : payType,
                          };
        
        
    }
    return self;
}

- (instancetype)initConfirmCollectionWithTradeID:(NSString *)traderID
                                        password:(NSString *)password;
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"trade.index.confirmtrade";
        self.reAPIName = @"C2C交易 卖家确认收款";
        self.reParams = @{
                          @"tradeid"   : traderID,
                          @"paypassword" : [password md5String],
                          };
    }
    return self;
}

- (instancetype)initCancleTradeWithTradeID:(NSString *)tradeID
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"trade.index.canceltrade";
        self.reAPIName = @"C2C 取消交易";
        
        self.reParams = @{
                          @"tradeid"  : tradeID,
                          };
    }
    return self;
}

- (instancetype)initUploadTradeVoucherWithImageUrl:(NSString *)imageUrl
                                           tradeID:(NSString *)tradeID
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"trade.index.upcertificate";
        self.reAPIName = @"上传交易凭证";
        
        self.reParams = @{
                          @"tradeid"  : tradeID,
                          @"imgpath"  : imageUrl,
                          };
    }
    return self;
}

- (instancetype)initSubmitAppealDataWithTradeID:(NSString *)tradeID
                                        content:(NSString *)content
                                           imgs:(NSString *)imgs
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"trade.index.explaintrade";
        self.reAPIName = @"交易申诉";
        
        self.reParams = @{
                          @"tradeid"  : tradeID,
                          @"imgs"     : imgs,
                          @"content"  : content,
                          };
    }
    return self;
}

@end
