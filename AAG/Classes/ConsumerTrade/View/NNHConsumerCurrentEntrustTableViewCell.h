//
//  NNHConsumerCurrentEntrustTableViewCell.h
//  YWL
//
//  Created by 来旭磊 on 2018/5/15.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNHConsumerTradeOrderModel.h"

@interface NNHConsumerCurrentEntrustTableViewCell : UITableViewCell

/** 数据模型 */
@property (nonatomic, strong) NNHConsumerTradeOrderModel *orderModel;

/** 点击操作按钮回调 */
@property (nonatomic, copy) void(^operationActionBlock)(NNHConsumerTradeOrderModel *orderModel);

@end
