//
//  NNWalletTableViewCell.h
//  YWL
//
//  Created by 来旭磊 on 2018/4/25.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           区块记账模块首页 cell
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <UIKit/UIKit.h>
#import "NNHomeListModel.h"

@interface NNWalletTableViewCell : UITableViewCell

/** 矿机运行模型 */
@property (nonatomic, strong) NNHomeListModel *mineModel;
@end
