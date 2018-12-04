//
//  NNBlockFundTransferReocrdModel.h
//  YWL
//
//  Created by 来旭磊 on 2018/5/14.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNBlockFundTransferReocrdModel : NSObject

/** 数量 */
@property (nonatomic, copy) NSString *number;

/** <#注释#> */
@property (nonatomic, copy) NSString *numberstr;

/** 用户 */
@property (nonatomic, copy) NSString *mobile;

/** 时间 */
@property (nonatomic, copy) NSString *addtime;

/** 类型 */
@property (nonatomic, copy) NSString *type;

/** 用户id */
@property (nonatomic, copy) NSString *userid;

/** 转账资产类型 */
@property (nonatomic, copy) NSString *text;

/** <#注释#> */
@property (nonatomic, copy) NSString *amount;

@end
