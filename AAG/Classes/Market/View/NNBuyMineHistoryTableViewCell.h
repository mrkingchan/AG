//
//  NNBuyMineHistoryTableViewCell.h
//  NBTMill
//
//  Created by 来旭磊 on 2018/5/3.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           购买矿机历史记录页面 cell
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <UIKit/UIKit.h>
#import "NNHMineBuyRecordModel.h"

@interface NNBuyMineHistoryTableViewCell : UITableViewCell

/** 记录模型 */
@property (nonatomic, strong) NNHMineBuyRecordModel *recordModel;
@end
