//
//  NNHMineBuyModel.h
//  NBTMill
//
//  Created by 来旭磊 on 2018/5/7.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           购机界面 内容
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <Foundation/Foundation.h>
@class NNHMineModel;
@class NNBuyMinePayMethodModel;

@interface NNHMineBuyModel : NSObject

/** 矿机类型 */
@property (nonatomic, strong) NNHMineModel *mine;

/** 余额 */
@property (nonatomic, strong) NSArray <NNBuyMinePayMethodModel *>*paymethod;

@end
