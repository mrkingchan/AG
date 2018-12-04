//
//  NNBlockFundTransferReocrdCell.h
//  YWL
//
//  Created by 来旭磊 on 2018/5/14.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           区块资产转账 内部转账 记录列表cell
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <UIKit/UIKit.h>
#import "NNBlockFundTransferReocrdModel.h"

@interface NNBlockFundTransferReocrdCell : UITableViewCell


/** 是否是消费资产 */
@property (nonatomic, assign) BOOL consumeFundFlag;

/** 数据模型 */
@property (nonatomic, strong) NNBlockFundTransferReocrdModel *recordModel;

@end
