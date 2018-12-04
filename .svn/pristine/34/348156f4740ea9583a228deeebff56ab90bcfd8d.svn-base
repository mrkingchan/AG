//
//  NNHApiWalletTool.m
//  YWL
//
//  Created by 来旭磊 on 2018/3/27.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNHApiWalletTool.h"
#import "NSString+Hash.h"

@implementation NNHApiWalletTool


- (instancetype)initWithUserWalletBalance
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"bank.balance.user_balance";
        self.reAPIName = @"用户钱包余额";
    }
    return self;
}

- (instancetype)initUserRechageAddressWithCoinID:(NSString *)coinID
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"bank.transfer.get_transfer_in_address";
        self.reAPIName = @"获取用户转入地址";
        self.reParams = @{
                          @"coin" : coinID,
                          };
    }
    return self;
}

- (instancetype)initUserWithdrawWithCoinID:(NSString *)coinID
                                   address:(NSString *)address
                                    amount:(NSString *)amount
                                    paypwd:(NSString *)paypwd
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"bank.transfer.transfer";
        self.reAPIName = @"用户转出接口";
        self.reParams = @{
                          @"coin"       : coinID,
                          @"address"    : address,
                          @"amount"     : amount,
                          @"paypwd"     : [paypwd md5String],
                          };
    }
    return self;
}

- (instancetype)initUserFundRecordWithCoinID:(NSString *)coinID
                                        type:(NNHUserFundOperationType)OperationType
                                        page:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"bank.balance.get_tx_list";
        self.reAPIName = @"用户转账列表";
        if (coinID.length == 0) {
            coinID = @"";
        }
        
        NSString *type = @"";
        if (OperationType == NNHUserFundOperationType_rechargeCoin) {
            type = @"1";
        }else if(OperationType == NNHUserFundOperationType_withdrawCoin){
            type = @"2";
        }else if(OperationType == NNHUserFundOperationType_withdrawCNY){
            type = @"3";
        }
        self.reParams = @{
                          @"coin"    : coinID,
                          @"type"        : type,
                          @"page"        : [NSString stringWithFormat:@"%zd",page]
                          };
    }
    return self;
}

- (instancetype)initUserCoinEncourageWithRewardType:(NNHUserCoinRewardType)rewardType
                                               page:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.index.allrewardlist";
        self.reAPIName = @"用户所有奖励明细";
        self.reParams = @{
                          @"coin"       : [NSString stringWithFormat:@"%zd",rewardType],
                          @"page"           : [NSString stringWithFormat:@"%zd",page],
                          };
    }
    return self;
}

- (instancetype)initUserAllRewardWithType:(NNHUserCoinRewardType)rewardType
                                         page:(NSInteger)page
{
    self = [super init];
    if (self) {
        
        self.requestReServiceType = @"user.index.rewardhcoinlist";
        self.reAPIName = @"用户所有奖励明细";
        self.reParams = @{
                          @"reward_type"       : [NSString stringWithFormat:@"%zd",rewardType],
                          @"page"           : [NSString stringWithFormat:@"%zd",page],
                          };
    }
    return self;
}


- (instancetype)initCoinAddressListData
{
    self = [super init];
    if (self) {
        
        self.requestReServiceType = @"user.address.address_list";
        self.reAPIName = @"转账地址列表";
        self.reParams = @{
                          @"coin"       : @"1",
                          };
    }
    return self;
}

@end
