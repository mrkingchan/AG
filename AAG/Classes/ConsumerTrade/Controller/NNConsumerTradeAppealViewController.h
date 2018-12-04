//
//  NNConsumerTradeAppealViewController.h
//  YWL
//
//  Created by 来旭磊 on 2018/5/23.
//  Copyright © 2018年 超级钱包. All rights reserved.
//
/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           C2C 申诉页面
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <UIKit/UIKit.h>

@interface NNConsumerTradeAppealViewController : UIViewController


/**
 初始化申诉页面

 @param orderID 订单id
 @return 对象
 */
- (instancetype)initWithOrderID:(NSString *)orderID;

/** 申诉成功后刷新按钮 */
@property (nonatomic, copy) void(^reloadDataBlock)(void);

@end
