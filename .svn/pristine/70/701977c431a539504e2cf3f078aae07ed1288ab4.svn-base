//
//  NNConsumerTradeDetailOrderPayMessageView.h
//  YWL
//
//  Created by 来旭磊 on 2018/5/22.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           支付信息view
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <UIKit/UIKit.h>
#import "NNConsumerOrderDetailModel.h"

@interface NNConsumerTradeDetailOrderPayMessageView : UIView

/** 选择支付方式 */
@property (nonatomic, copy) void(^selectedPayTypeBlock)(void);
/** 订单模型 */
@property (nonatomic, strong) NNConsumerOrderDetailModel *orderModel;
/** 修改支付方式 */
- (void)changePayTypeWithPayModel:(NNConsumerOrderDetailPayTypeModel *)payTypeModel;
/** 点击凭证按钮 */
@property (nonatomic, copy) void(^voucherActionBlock)(UIImageView *imageView);
/** 更改支付方式 */
@property (nonatomic, copy) void(^changedPaytypeBlock)(NNConsumerOrderDetailPayTypeModel *payModel);
/** 重新上传图片 */
@property (nonatomic, copy) void(^uploadAgainActionBlock)(void);

@end
