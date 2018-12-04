//
//  NNHMineTopView.h
//  YWL
//
//  Created by 牛牛 on 2018/3/5.
//  Copyright © 2018年 NBT. All rights reserved.
//

typedef NS_ENUM(NSInteger, NNHMineTopJumpType){
    NNHMineTopJumpSetting,        // 设置
    NNHMineTopJumpNotice   // 公告
};

#import <UIKit/UIKit.h>
@class NNMineModel;

@interface NNHMineTopView : UIView

/** 我的数据 */
@property (nonatomic, strong) NNMineModel *mineModel;
/** 头部按钮跳转 */
@property (nonatomic, copy) void (^mineTopViewJumpBlock)(NNHMineTopJumpType type);
/** 九宫格跳转 */
@property (nonatomic, copy) void (^mineAssetsDetailJumpBlock)(NNHMineAssetsType type, NSString *title);

@end
