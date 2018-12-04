//
//  NNCoinMarketModel.h
//  YWL
//
//  Created by 牛牛 on 2018/5/17.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNCoinMarketModel : NSObject

/** 现在价格 */
@property (nonatomic, copy) NSString *now_price;
/** 最高价 */
@property (nonatomic, copy) NSString *max_price;
/** 最低价 */
@property (nonatomic, copy) NSString *min_price;
/** 成交量 */
@property (nonatomic, copy) NSString *market_volume;
/** 成交额 */
@property (nonatomic, copy) NSString *market_all_price;
/** 涨跌 */
@property (nonatomic, copy) NSString *change;

@end
