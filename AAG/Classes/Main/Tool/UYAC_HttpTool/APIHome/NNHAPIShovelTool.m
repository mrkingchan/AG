//
//  NNHAPIShovelTool.m
//  YWL
//
//  Created by 来旭磊 on 2018/3/29.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNHAPIShovelTool.h"

@implementation NNHAPIShovelTool

- (instancetype)initIndexShovelData
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"index.index.index";
        self.reAPIName = @"首页挖宝数据";
    }
    return self;
}

- (instancetype)initShoveldCoinListDataWithPage:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"index.index.indexhcoinlist";
        self.reAPIName = @"已经挖了的Hcoin列表";
        self.reParams = @{
                          @"page" : [NSString stringWithFormat:@"%zd",page],
                          };
    }
    return self;
}

- (instancetype)initGetCoinWithCoinID:(NSString *)coinID
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"index.index.gethcoin";
        self.reAPIName = @"挖币HCION";
        self.reParams = @{
                          @"coinid" : coinID,
                          };
    }
    return self;
}

- (instancetype)initVersionUpdate
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"sys.index.versionupdate";
        self.reAPIName = @"版本更新";
        
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        self.reParams = @{@"version" : currentVersion};
    }
    return self;
}

@end
