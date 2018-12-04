//
//  NNKLineGroupModel.m
//  SuperWallet
//
//  Created by 牛牛 on 2018/3/28.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNKLineGroupModel.h"
#import "Y_KLineModel.h"

@implementation NNKLineGroupModel

+ (instancetype) objectWithArray:(NSArray *)arr {
    
    NSAssert([arr isKindOfClass:[NSArray class]], @"arr不是一个数组");
    
    NNKLineGroupModel *groupModel = [NNKLineGroupModel new];
    NSMutableArray *mutableArr = @[].mutableCopy;
    __block Y_KLineModel *preModel = [[Y_KLineModel alloc]init];
    
    // 设置数据
    for (NSArray *valueArr in arr){
        Y_KLineModel *model = [[Y_KLineModel alloc] init];
        model.PreviousKlineModel = preModel;
        [model initWithArray:valueArr];
        model.ParentGroupModel = groupModel;
        
        [mutableArr addObject:model];
        
        preModel = model;
    }
    
    groupModel.models = mutableArr;
    
    //初始化第一个Model的数据
    Y_KLineModel *firstModel = mutableArr[0];
    [firstModel initFirstModel];
    
    //初始化其他Model的数据
    [mutableArr enumerateObjectsUsingBlock:^(Y_KLineModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [model initData];
    }];
    
    return groupModel;
}

@end
