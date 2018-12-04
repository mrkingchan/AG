//
//  NNHApiMarketHomeTool.m
//  YWL
//
//  Created by 来旭磊 on 2018/3/12.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNHApiMarketHomeTool.h"
#import "NSString+Hash.h"

@implementation NNHApiMarketHomeTool


- (instancetype)initMineListData;
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"wfcc.index.index";
        self.reAPIName = @"WFCC首页";
    }
    return self;
}

- (instancetype)initHomePowerFlowDetailWithID:(NSString *)powerID
                                         Page:(NSUInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"wfcc.index.powerflowlist";
        self.reAPIName = @"WFCC记账明细";
        
        self.reParams = @{
                           @"pid" : powerID,
                           @"page" : [NSString stringWithFormat:@"%zd",page]
                         };
    }
    return self;
}

- (instancetype)initBuyMineDataWithMineID:(NSString *)mineID
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"ltc.ltc.getinfoandbalance";
        self.reAPIName = @"购买矿机信息显示";
        
        self.reParams = @{
                          @"lid" : mineID,
                          };
    }
    return self;
}

- (instancetype)initBuyMinePayOrderWithMineID:(NSString *)mineID
                                     minetype:(NSString *)minetype
                                     iscomput:(NSString *)iscomput
                                          num:(NSString *)num
                                  paypassword:(NSString *)paypassword
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"ltc.ltc.buyltc";
        self.reAPIName = @"购买矿机支付";
        
        
        self.reParams = @{
                          @"lid"            : mineID,
                          @"buytype"        : minetype,
                          @"iscomput"        : iscomput,
                          @"num"            : num,
                          @"paypassword"    : [paypassword md5String],
                          };
    }
    return self;
}

- (instancetype)initBuyMineRecordWithPage:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"ltc.ltc.ltcbuylog";
        self.reAPIName = @"矿机购买记录";
        
        self.reParams = @{
                          @"page" : [NSString stringWithFormat:@"%zd",page],
                          };
    }
    return self;
}

- (instancetype)initMineOperationListDataWithType:(NNHMineOperationType)operationType
                                             page:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"ltc.ltc.ltcfuninfo";
        self.reAPIName = @"矿机运行信息";
        
        NSString *type = @"0";
        if (operationType == NNHMineOperationType_end) {
            type = @"1";
        }
        
        self.reParams = @{
                          @"page" : [NSString stringWithFormat:@"%zd",page],
                          @"status" : type,
                          };
    }
    return self;
}

- (instancetype)initMineOperationDataWithMineID:(NSString *)mainID
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"wfcc.index.powerinfo";
        self.reAPIName = @"WFCC记账详情";
        
        self.reParams = @{
                          @"pid" : mainID,
                          };
    }
    return self;
}

@end
