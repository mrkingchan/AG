//
//  NNWalletAddressModel.h
//  YWL
//
//  Created by 来旭磊 on 2018/5/12.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           钱包地址model
 
 @Remarks          <#注释#>
 
 *****************************************************/
#import <Foundation/Foundation.h>

@interface NNWalletAddressModel : NSObject

/** 备注信息 */
@property (nonatomic, copy) NSString *name;

/** 地址 */
@property (nonatomic, copy) NSString *addr;

/** 地址ID */
@property (nonatomic, copy) NSString *addressID;

@end
