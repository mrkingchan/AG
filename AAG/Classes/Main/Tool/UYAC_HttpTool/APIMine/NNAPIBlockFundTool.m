//
//  NNAPIBlockFundTool.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/12.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNAPIBlockFundTool.h"
#import "NSString+Hash.h"

@implementation NNAPIBlockFundTool

- (instancetype)initCoinAssetsDetailWithType:(NNHMineAssetsType)type
                                    flowType:(NSString *)flowType
                                        page:(NSUInteger)page
{
    self = [super init];
    if (self) {

        self.requestReServiceType = @"user.amount.balancedetail";
        self.reAPIName = @"钱包余额和明细";
        self.reParams = @{
                          @"page" : [NSString stringWithFormat:@"%zd",page],
                          @"type" : [NSString stringWithFormat:@"%zd",type]
                          };        
        
    }
    return self;
}

- (instancetype)initCoinAssetsRewardDetailWithType:(NNHMineAssetsType)type
                                              page:(NSUInteger)page
{
    self = [super init];
    if (self) {
        
//        if(type == NNHMineAssetsType_chargeAccountPool){
//            self.requestReServiceType = @"user.index.bookpool";
//            self.reAPIName = @"记账池奖励列表";
//        }else if(type == NNHMineAssetsType_teamPerformance){
//            self.requestReServiceType = @"user.index.teamperformance";
//            self.reAPIName = @"团队业绩列表";
//        }else if(type == NNHMineAssetsType_teamPerformanceAward){
//            self.requestReServiceType = @"user.index.teamaward";
//            self.reAPIName = @"团队业绩奖列表";
//        }else{
//            self.requestReServiceType = @"user.index.recommendaward";
//            self.reAPIName = @"推荐奖列表";
//        }
        
        self.reParams = @{@"page" :  [NSString stringWithFormat:@"%zd",page]};
    }
    return self;
}

- (instancetype)initAddWalletAddrrssWithRemark:(NSString *)remark
                                       address:(NSString *)address
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"finance.address.add";
        self.reAPIName = @"添加钱包地址";
        self.reParams = @{
                          @"title"      : remark,
                          @"address"    : address,
                          };
    }
    return self;
}

- (instancetype)initUserWalletAddressListData
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"finance.address.list";
        self.reAPIName = @"钱包地址列表";
    }
    return self;
}

- (instancetype)initDeleteWalletAddressWithAddressID:(NSString *)addressID
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"finance.address.del";
        self.reAPIName = @"删除钱包地址";
        self.reParams = @{
                          @"qid" : addressID,
                          };
    }
    return self;
}

- (instancetype)initBlockFundBalance
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"finance.coin.balance";
        self.reAPIName = @"提现NBT余额显示";
    }
    return self;
}

- (instancetype)initFundDetailInfoWithFundType:(NNFundBanlanceType)fundType
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"finance.coin.withdrawcurrencyinfo";
        self.reAPIName = @"提取/转账资产详情页";
        
        NSString *type = @"1";
        if (fundType == NNFundBanlanceType_jizhangFund) {
            type = @"1";
        }else if (fundType == NNFundBanlanceType_huzhuanFund) {
            type = @"2";
        }else {
            type = @"3";
        }
        
        self.reParams = @{
                          @"type" : type,
                          };
    }
    return self;
}

- (instancetype)initBlockFundCoinRechageAddressData
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.coin.recharge";
        self.reAPIName = @"钱包地址";
    }
    return self;
}

- (instancetype)initBlockFundCoinWithdrawWithAddress:(NSString *)address
                                          coinamount:(NSString *)coinamount
                                              paypwd:(NSString *)paypwd
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"finance.coin.putforward";
        self.reAPIName = @"提现NBT";
        self.reParams = @{
                          @"address"    : address,
                          @"coinamount" : coinamount,
                          @"paypwd"     : [paypwd md5String],
                          };
    }
    return self;
}

- (instancetype)initBlockFundCoinTransferRecordWithType:(NNMineFundOperationType)operationType
                                                   page:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"finance.coin.transferlog";
        self.reAPIName = @"充提记录";
        NSString *type = @"";
        if (operationType == NNMineFundOperationType_recharge) {
            type = @"1";
        }
        if (operationType == NNMineFundOperationType_withdraw) {
            type = @"2";
        }
        self.reParams = @{
                          @"type"    :  type,
                          @"page"    :  [NSString stringWithFormat:@"%zd",page],
                          
                          };
    }
    return self;
}

- (instancetype)initWalletTransferWithType:(NNHWalletTransferType)type
{
    self = [super init];
    if (self) {
        
        self.reAPIName = @"钱包转账余额";
        self.requestReServiceType = @"user.transfer.info";
        self.reParams = @{@"type" : [NSString stringWithFormat:@"%zd",type]};
        
    }
    return self;
}

@end
