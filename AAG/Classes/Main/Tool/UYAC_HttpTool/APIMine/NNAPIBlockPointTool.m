//
//  NNAPIBlockPointTool.m
//  YWL
//
//  Created by 来旭磊 on 2018/7/9.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNAPIBlockPointTool.h"

@implementation NNAPIBlockPointTool

- (instancetype)initSearchNodeWithNodeAccount:(NSString *)account
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.index.nodesearch";
        self.reAPIName = @"节点查询";
        self.reParams = @{
                          @"username"      : account,
                          };
    }
    return self;
}

@end
