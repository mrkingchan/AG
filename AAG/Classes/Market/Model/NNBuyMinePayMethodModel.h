//
//  NNBuyMinePayMethodModel.h
//  WTA
//
//  Created by 来旭磊 on 2018/9/10.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function          购买矿机支付方法模型
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <Foundation/Foundation.h>

@interface NNBuyMinePayMethodModel : NSObject

/** 支付方式 是否被选中 */
@property (nonatomic, assign) BOOL selectedFalg;

/** 支付类型名称 */
@property (nonatomic, copy) NSString *name;

/** 可用余额 */
@property (nonatomic, copy) NSString *amount;

/** 支付类型名称 */
@property (nonatomic, copy) NSString *paytype;

@end
