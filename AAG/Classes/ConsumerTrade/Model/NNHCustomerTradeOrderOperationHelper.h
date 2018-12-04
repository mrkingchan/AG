//
//  NNHCustomerTradeOrderOperationHelper.h
//  YWL
//
//  Created by 来旭磊 on 2018/5/22.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           C2C交易 用户操作辅助类
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <Foundation/Foundation.h>
#import "NNConsumerOrderDetailModel.h"
#import "NNHConsumerTradeOrderModel.h"

@interface NNHCustomerTradeOrderOperationHelper : NSObject

/** 操作回调block */
@property (nonatomic, copy) void(^reloadDataBlock)(void);
/** 当前控制器 */
@property (nonatomic, weak) UIViewController *currentViewController;

/*****************  当前委托列表上的操作  *******************/

/** 委托列表上的操作 */
- (void)orderListOperationWithOrderModel:(NNHConsumerTradeOrderModel *)orderModel;

/*****************  定案详情页上面的操作  *******************/

/** 上传凭证 */
- (void)uploadTradeVoucherWithOrderDetailModel:(NNConsumerOrderDetailModel *)orderDetailModel
                                 fromImageView:(UIImageView *)fromImageView;


/** 重新上传交易凭证 */
- (void)uploadNewTradeVoucherImageWithOrderDetailModel:(NNConsumerOrderDetailModel *)orderDetailModel;

/** 联系对方 */
- (void)callConsumerWithMobile:(NSString *)mobile;


/** 订单详情页 确认付款 确认收款 */
- (void)orderDetailOperationWithOrderDetailModel:(NNConsumerOrderDetailModel *)orderDetailModel ;



@end
