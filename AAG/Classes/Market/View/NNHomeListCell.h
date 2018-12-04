//
//  NNHomeListTableViewCell.h
//  YWL
//
//  Created by 来旭磊 on 2018/4/25.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNHomeListModel.h"

@interface NNHomeListCell : UITableViewCell

@property (nonatomic, strong) NNHomeListModel *homeListModel;

/** 购买回调 */
@property (nonatomic, copy) void(^buyActionBlock)(void);

@end
