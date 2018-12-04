//
//  NNHCustomerTradeOrderOperationHelper.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/22.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNHCustomerTradeOrderOperationHelper.h"
#import "NNHAPIConsumerTradeTool.h"
#import "UIViewController+NNHExtension.h"
#import "NNConsumerOrderDetailModel.h"
#import "NNConsumerTradeDetailViewController.h"
#import "NNImagePickerViewController.h"
#import "NNUploadImageTool.h"
#import "NNHAlertTool.h"
#import "NNHApplicationHelper.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "NNHEnterPasswordView.h"
#import "NNVerifyPhoneViewController.h"
#import "NNSetUpPayPasswordViewController.h"

@interface NNHCustomerTradeOrderOperationHelper ()

/** 交易类型 */
@property (nonatomic, assign) NNConsumerTradeType tradeType;
/** 输入密码 */
@property (nonatomic, strong) NNHEnterPasswordView *enterView;
/** 当前订单模型 */
@property (nonatomic, strong) NNConsumerOrderDetailModel *orderDetailModel;

@end

@implementation NNHCustomerTradeOrderOperationHelper

- (void)orderListOperationWithOrderModel:(NNHConsumerTradeOrderModel *)orderModel;
{
    [self pushOrderDetailControllerWithOrderModel:orderModel];
}

/**
 进入订单详情

 @param orderModel 订单Model
 */
- (void)pushOrderDetailControllerWithOrderModel:(NNHConsumerTradeOrderModel *)orderModel
{
    NNHWeakSelf(self)
    NNHAPIConsumerTradeTool *tradeTool = [[NNHAPIConsumerTradeTool alloc] initWithTradeInfoDatailDataWithTradeID:orderModel.orderID];
    [tradeTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        NNConsumerOrderDetailModel *orderModel = [NNConsumerOrderDetailModel mj_objectWithKeyValues:responseDic[@"data"]];
        NNConsumerTradeDetailViewController *vc = [[NNConsumerTradeDetailViewController alloc] initWithOrderModel:orderModel];
        [weakself.currentViewController.navigationController pushViewController:vc animated:YES];
        
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

/**
 取消订单

 @param tradeID 订单号
 */
- (void)cancleOrderWithTradeID:(NSString *)tradeID
{
    NNHWeakSelf(self)
    NNHAPIConsumerTradeTool *tradeTool = [[NNHAPIConsumerTradeTool alloc] initCancleTradeWithTradeID:tradeID];
    [tradeTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [SVProgressHUD showMessage:@"取消交易成功"];
        if (weakself.reloadDataBlock) {
            weakself.reloadDataBlock();
        }
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}


- (void)orderDetailOperationWithOrderDetailModel:(NNConsumerOrderDetailModel *)orderDetailModel
{
//    5=》撤销
//    2=》提醒卖家收款
//    1=》 去付款
//    6=》 去确认收款
//    3=》提醒卖家付款
    
    if ([orderDetailModel.orderstatus.acttype isEqualToString:@"5"]) {
        [self cancleOrderWithTradeID:orderDetailModel.tradeid];
    }else if ([orderDetailModel.orderstatus.acttype isEqualToString:@"1"] || [orderDetailModel.orderstatus.acttype isEqualToString:@"6"]){
        if (![orderDetailModel.orderstatus.acttype isEqualToString:@"6"]) {
            
            if (orderDetailModel.payimg.length) {
                //确认付款
                [[NNHAlertTool shareAlertTool] showAlertView:self.currentViewController title:@"确认已付款吗？" message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
                    [self confirmTradeWithTradeID:orderDetailModel.tradeid password:nil payType:orderDetailModel.selectedPaytypeModel.paytype];
                } cancle:^{
                    
                }];
            }else {
                [SVProgressHUD showMessage:@"请先上传凭证"];
            }
        }else {
            //确认收款
            self.orderDetailModel = orderDetailModel;
            [self.enterView showInFatherView:self.currentViewController.view];
        }
    }
}

/** 输入交易密码 确认付款 */
- (void)inputPayCode:(NSString *)paycode
{
    NNHWeakSelf(self)
    NNHAPIConsumerTradeTool *tradeTool = [[NNHAPIConsumerTradeTool alloc] initConfirmCollectionWithTradeID:self.orderDetailModel.tradeid  password:paycode];
    
    [tradeTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [weakself.enterView dissmissWithCompletion:nil];
        if (weakself.reloadDataBlock) {
            weakself.reloadDataBlock();
        }
    } failBlock:^(NNHRequestError *error) {
        [weakself.enterView resetStatus];
    } isCached:NO];
}

/** 确认买入 @param traderID 交易ID */
- (void)confirmTradeWithTradeID:(NSString *)traderID password:(NSString *)password payType:(NSString *)payType
{
    NNHWeakSelf(self)
    NNHAPIConsumerTradeTool *tradeTool = [[NNHAPIConsumerTradeTool alloc] initWithConfirmPayOrderWithTradeID:traderID password:password payType:payType];
    [tradeTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        if (weakself.reloadDataBlock) {
            weakself.reloadDataBlock();
        }
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

/** 给对方打电话 */
- (void)callConsumerWithMobile:(NSString *)mobile
{
    NSArray *array = [NSArray arrayWithObject:mobile];
    
    [[NNHAlertTool shareAlertTool] showActionSheet:self.currentViewController title:nil message:nil acttionTitleArray:array confirm:^(NSInteger index) {
        
        [[NNHApplicationHelper sharedInstance] openPhoneNum:array[index] InView:self.currentViewController.view];
    } cancle:^{
        
    }];
}

/** 上传凭证 */
- (void)uploadTradeVoucherWithOrderDetailModel:(NNConsumerOrderDetailModel *)orderDetailModel
                                 fromImageView:(UIImageView *)fromImageView
{
    if (orderDetailModel.payimg.length) {
        // 1.创建图片浏览器
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        
        // 2.设置图片浏览器显示的所有图片
        NSMutableArray *photos = [NSMutableArray array];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        
        // 设置图片的路径
        photo.url = [NSURL URLWithString:orderDetailModel.payimg];
        
        // 设置来源于哪一个UIImageView
        photo.srcImageView = fromImageView;
        [photos addObject:photo];
        
        browser.photos = photos;
        // 4.设置默认显示的图片索引
        browser.currentPhotoIndex = 0;
        // 5.显示浏览器
        [browser show];
    }else {
        //选取图片
        NNImagePickerViewController *imagePickerVc = [[NNImagePickerViewController alloc] initWithMaxImagesCount:1 delegate:nil];
        
        NNHWeakSelf(self)
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
            [NNUploadImageTool uploadWithImage:[photos lastObject] successBlock:^(NSString *upUrl, NSString *wholeUrl) {
                [weakself uploadTradeImageWithImageURl:wholeUrl orderID:orderDetailModel.tradeid];
            } failedBlock:^(NNHRequestError *error) {
                
            }];
        }];
        
        [self.currentViewController presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

- (void)uploadNewTradeVoucherImageWithOrderDetailModel:(NNConsumerOrderDetailModel *)orderDetailModel
{
    //选取图片
    NNImagePickerViewController *imagePickerVc = [[NNImagePickerViewController alloc] initWithMaxImagesCount:1 delegate:nil];
    
    NNHWeakSelf(self)
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
        [NNUploadImageTool uploadWithImage:[photos lastObject] successBlock:^(NSString *upUrl, NSString *wholeUrl) {
            [weakself uploadTradeImageWithImageURl:wholeUrl orderID:orderDetailModel.tradeid];
        } failedBlock:^(NNHRequestError *error) {
            
        }];
    }];
    
    [self.currentViewController presentViewController:imagePickerVc animated:YES completion:nil];
}

/** 上传凭证 请求网络操作 */
- (void)uploadTradeImageWithImageURl:(NSString *)imageUrl orderID:(NSString *)orderID
{
    NNHWeakSelf(self)
    NNHAPIConsumerTradeTool *tradeTool = [[NNHAPIConsumerTradeTool alloc] initUploadTradeVoucherWithImageUrl:imageUrl tradeID:orderID];
    [tradeTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [SVProgressHUD showMessage:@"上传成功"];
        if (weakself.reloadDataBlock) {
            weakself.reloadDataBlock();
        }
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (NNHEnterPasswordView *)enterView
{
    if (_enterView == nil) {
        _enterView = [[NNHEnterPasswordView alloc] init];
        NNHWeakSelf(self)
        _enterView.didEnterCodeBlock = ^(NSString *password){
            NNHStrongSelf(self)
            [strongself inputPayCode:password];
        };
    }
    return _enterView;
}

@end
