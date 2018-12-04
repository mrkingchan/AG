//
//  NNHAPIMineCenterTool.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/7.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNHAPIMineCenterTool.h"

@implementation NNHAPIMineCenterTool

- (instancetype)initWithMineCentDataWithBlockType:(NNHBlockType)blockType page:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"bookcenter.index.index";
        self.reAPIName = @"记账中心";
        
        NSString *type = @"";
        if (blockType == NNHBlockType_mainType) {
            type = @"1";
        }else if (blockType == NNHBlockType_subType) {
            type = @"2";
        }else {
            type = @"3";
        }
        
        self.reParams = @{
                          @"type" : type,
                          @"page" : [NSString stringWithFormat:@"%zd",page],
                          };
    }
    return self;
}

- (instancetype)initWithBlockManageCenterListDataWithPage:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"bookcenter.index.achievement";
        self.reAPIName = @"记账管理中心 / 代理中心";
        
        self.reParams = @{
                          @"page" : [NSString stringWithFormat:@"%zd",page],
                          };
    }
    return self;
}

@end
