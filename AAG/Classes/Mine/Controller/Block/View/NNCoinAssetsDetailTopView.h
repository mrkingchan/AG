//
//  NNCoinAssetsDetailTopView.h
//  YWL
//
//  Created by 牛牛 on 2018/5/15.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NNCoinAssetsDetailModel;

@interface NNCoinAssetsDetailTopView : UIView

- (instancetype)initWithTopAssetsType:(NNHMineAssetsType)type title:(NSString *)title;

@property (nonatomic, strong) NNCoinAssetsDetailModel *assetsDetailModel;

/** 返回 */
@property (nonatomic, copy) void (^backActionBlock)(void);
/** 转账 */
@property (nonatomic, copy) void (^extractionAssetsBlock)(NNHMineAssetsType currentAssetsType);
/** 转出易物通 */
@property (nonatomic, copy) void (^rollOutActionBlock)(NNHMineAssetsType type);

@end
