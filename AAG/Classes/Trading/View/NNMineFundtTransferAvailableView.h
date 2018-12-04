//
//  NNMineFundtTransferAvailableView.h
//  YWL
//
//  Created by 来旭磊 on 2018/4/28.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           顶部可用 余额view
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <UIKit/UIKit.h>

@interface NNMineFundtTransferAvailableView : UIView

/** 标题 */
@property (nonatomic, copy) NSString *title;

- (void)configCoinName:(NSString *)coinName count:(NSString *)count;

@end
