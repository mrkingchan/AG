//
//  NNHApplicationHelper.m
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/31.
//  Copyright © 2016年 NBT. All rights reserved.
//

#import "NNHApplicationHelper.h"
#import "UIViewController+NNHExtension.h"
#import "NNHAlertTool.h"
#import "NNRealNameAuthenticationViewController.h"
#import "NNWebViewController.h"
#import "NNHAPIShovelTool.h"
#import "NNVerifyPhoneViewController.h"

@interface NNHApplicationHelper ()


@end

@implementation NNHApplicationHelper
NNHSingletonM

/** 打开系统设置 */
- (void)openApplcationSetting
{
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark --
#pragma mark -- 打电话
- (void)openPhoneNum:(NSString *)phoneNum InView:(UIView *)view
{
    NSString *phoneStr = [[NSString alloc] initWithFormat:@"telprompt://%@",phoneNum];
    NSURL *phoneUrl = [NSURL URLWithString:phoneStr];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
            [[UIApplication sharedApplication] openURL:phoneUrl];
        }
    });
}

- (void)openQQWithQQNumber:(NSString *)qqNum
{
    NSURL *qqUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://wpa.b.qq.com/cgi/wpa.php?ln=2&uin=%@",qqNum]];
    if ([[UIApplication sharedApplication] canOpenURL:qqUrl]) {
        [[UIApplication sharedApplication] openURL:qqUrl];
    }
}

//判断实名认证
- (BOOL)isRealName
{
    if ([[NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.isnameauth isEqualToString:@"1"]) {
        return YES;
    }else if ([[NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.isnameauth isEqualToString:@"2"]) {
        [SVProgressHUD showMessage:@"实名认证审核中"];
        return NO;
    }else if ([[NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.isnameauth isEqualToString:@"0"]) {
        UIViewController *currentVC = [UIViewController currentViewController];
        [[NNHAlertTool shareAlertTool] showAlertView:currentVC title:@"您还未实名认证，请完善实名认证！" message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"去认证" confirm:^{
            NNRealNameAuthenticationViewController *vc = [[NNRealNameAuthenticationViewController alloc] init];
            [currentVC.navigationController pushViewController:vc animated:YES];
        } cancle:^{

        }];
        return NO;
    }else {
        return NO;
    }
}

#pragma mark --
#pragma mark -- 版本更新
- (void)versionUpdate
{
    NNHAPIShovelTool *tool = [[NNHAPIShovelTool alloc] initVersionUpdate];
    [tool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        
        // update 2强制 1有 0无 url 跳转的地址
        NSDictionary *data = responseDic[@"data"];
        if ([data[@"update"] integerValue] == 0) return;
        
        UIViewController *currentVC = [UIViewController currentViewController];
        [[NNHAlertTool shareAlertTool] showAlertView:currentVC title:data[@"title"] message:data[@"info"] cancelButtonTitle:[data[@"update"] integerValue] == 1 ? @"取消" : nil otherButtonTitle:@"去更新" confirm:^{
            
            NSURL *url = [NSURL URLWithString:data[@"url"]];
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                    
                }];
            }else{
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
            
        } cancle:^{
            
        }];
        
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

#pragma mark --
#pragma mark -- 更新支付密码

- (BOOL)isSetupPayCode
{
    if ([[NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.payDec isEqualToString:@"1"]) {
        return YES;
    }else{
        UIViewController *currentVC = [UIViewController currentViewController];
        [[NNHAlertTool shareAlertTool] showAlertView:currentVC title:@"您还未设置支付密码，请先设置支付密码" message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"去设置" confirm:^{
            [self updatePayPassword];
        } cancle:^{
            
        }];
        return NO;
    }
}

- (void)updatePayPassword
{
    UIViewController *currentController = [UIViewController currentViewController];
    
    NNVerifyPhoneViewController *verifyVC = [[NNVerifyPhoneViewController alloc] initWithType:NNHSendVerificationCodeType_changePayPassword];
    [currentController.navigationController pushViewController:verifyVC animated:YES];
}


@end
