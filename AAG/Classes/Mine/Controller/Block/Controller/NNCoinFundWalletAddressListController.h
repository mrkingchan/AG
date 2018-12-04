//
//  NNCoinFundWalletAddressListController.h
//  YWL
//
//  Created by 来旭磊 on 2018/5/12.
//  Copyright © 2018年 超级钱包. All rights reserved.
//
/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           币种钱包地址
 
 @Remarks          <#注释#>
 
 *****************************************************/
#import <UIKit/UIKit.h>

@interface NNCoinFundWalletAddressListController : UIViewController

/** 选择地址回调 */
@property (nonatomic, copy) void(^selectAddressBlock)(NSString *address);

@end
