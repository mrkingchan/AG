//
//  NNCoinAssetsDetailModel.h
//  YWL
//
//  Created by 牛牛 on 2018/5/15.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNCoinAssetsDetailListModel : NSObject

/** (1为收入 + 2为支出 -) */
@property (nonatomic, copy) NSString *direction;
/** 金额 */
@property (nonatomic, copy) NSString *amount;
/** 流水时间 */
@property (nonatomic, copy) NSString *flowtime;
/** 流水文字 */
@property (nonatomic, copy) NSString *flowname;
/** 流水说明 */
@property (nonatomic, copy) NSString *flowinfo;

@end

@interface NNCoinAssetsDetailModel : NSObject

/** 余额 */
@property (nonatomic, copy) NSString *balance;
/** 自身算力总额 */
@property (nonatomic, copy) NSString *incomeamount;
/** 分享算力总额 */
@property (nonatomic, copy) NSString *shareamount;
/** 释放钱包释放总额 */
@property (nonatomic, copy) NSString *releaseamount;
/** 列表 */
@property (nonatomic, strong) NSMutableArray <NNCoinAssetsDetailListModel *> *list;
/** 总条数 */
@property (nonatomic, copy) NSString *total;

@end
