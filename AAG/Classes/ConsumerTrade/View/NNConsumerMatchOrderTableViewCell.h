//
//  NNConsumerMatchOrderTableViewCell.h
//  YWL
//
//  Created by 来旭磊 on 2018/5/18.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNConsumerMatchOrderModel.h"

@interface NNConsumerMatchOrderTableViewCell : UITableViewCell

/** 订单模型 */
@property (nonatomic, strong) NNConsumerMatchOrderModel *orderModel;

/** 操作回调 */
@property (nonatomic, copy) void(^actionBlock)(void);

@end
