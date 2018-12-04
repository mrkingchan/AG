//
//  NNHAPITradingTool.m
//  YWL
//
//  Created by 来旭磊 on 2018/3/27.
//  Copyright © 2018年 NBT. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           交易模块 api接口
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import "NNHAPITradingTool.h"
#import "NSString+Hash.h"

@implementation NNHAPITradingTool


/** 转账操作 */
- (instancetype)initMineFundTransferWithNum:(NSString *)num
                                 tousername:(NSString *)tousername
                                     paypwd:(NSString *)paypwd
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"finance.finance.transfer";
        self.reAPIName = @"转出资产";
        self.reParams = @{
                          @"num" : num,
                          @"tousername" :   tousername,
                          @"paypwd"     :   [paypwd md5String],
                          
                          };
    }
    return self;
}

- (instancetype)initCreatReciveMineFundCodeImage
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"finance.finance.username";
        self.reAPIName = @"获取生成二维码用户名";
    }
    return self;
}


- (instancetype)initMineFundTransferRecorWithType:(NNMineFundOperationType)operationType
                                             page:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"finance.finance.transferlog";
        self.reAPIName = @"转账记录";
        
        NSString *type = @"";
        if (operationType == NNMineFundOperationType_recharge) {
            type = @"1";
        }
        
        if (operationType == NNMineFundOperationType_withdraw) {
            type = @"2";
        }
        
        self.reParams = @{
                          @"type"  : type,
                          @"page"  : [NSString stringWithFormat:@"%zd",page],
                          };
        
    }
    return self;
}

- (instancetype)initCoinChartWithPeriod:(NSString *)period
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"trade.index.chart";
        self.reAPIName = @"K线图数据";
        self.reParams = @{@"time_type"  : period};
        self.hiddenProgressHUD = YES;
    }
    return self;
}

- (instancetype)initNewCoinMarket
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"trade.index.market";
        self.reAPIName = @"最新行情";
        self.hiddenProgressHUD = YES;
    }
    return self;
}

@end
