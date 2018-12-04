//
//  NNMineModel.h
//  YWL
//
//  Created by 牛牛 on 2018/3/27.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNMineAmountInfoModel : NSObject

/** WFCC积分 */
@property (nonatomic, copy) NSString *wfccamount;
/** 通用积分 */
@property (nonatomic, copy) NSString *coinamount;
/** 增值积分 */
@property (nonatomic, copy) NSString *increamount;
/** 消费积分 */
@property (nonatomic, copy) NSString *mallamount;
/** WTA锁定钱包 */
@property (nonatomic, copy) NSString *lockwareamount;
/** 赠送钱包 */
@property (nonatomic, copy) NSString *giveamount;

@end

@interface NNMineModel : NSObject

/** 用户模型 */
@property (nonatomic, strong) NNUserModel *userModel;
/** 用户金额信息 */
@property (nonatomic, strong) NNMineAmountInfoModel *amountInfoModel;
/** 货币单位 */
@property (nonatomic, copy) NSString *unit;
/** 会员等级 */
@property (nonatomic, copy) NSString *levelname;
/** 是否显示具备搜索资格 */
@property (nonatomic, copy) NSString *isshowsearch;

// 辅助属性
/** 头部高度 */
@property (nonatomic, assign, readonly) CGFloat topViewH;

@end
