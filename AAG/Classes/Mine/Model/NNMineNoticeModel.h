//
//  NNMineNoticeModel.h
//  YWL
//
//  Created by 牛牛 on 2018/4/27.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNMineNoticeModel : NSObject

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 副标题 */
@property (nonatomic, copy) NSString *content;
/** 时间 */
@property (nonatomic, copy) NSString *addtime;
/** 时间 */
@property (nonatomic, copy) NSString *url;

// 辅助属性
/** 返回cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
