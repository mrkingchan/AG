//
//  NNMineOperationDeatilTableHeaderView.h
//  YWL
//
//  Created by 来旭磊 on 2018/5/14.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           矿机运行详情页 头部view
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <UIKit/UIKit.h>
#import "NNMineOperationModel.h"

@interface NNMineOperationDeatilTableHeaderView : UIView

/** 矿机运行数据 */
@property (nonatomic, strong) NNMineOperationModel *operationModel;

@end
