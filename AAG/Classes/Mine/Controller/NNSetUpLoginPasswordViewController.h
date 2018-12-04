//
//  NNHSetUpLoginPasswordViewController.h
//  NBTMill
//
//  Created by 来旭磊 on 2018/3/7.
//  Copyright © 2018年 NBT. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           设置登录密码

 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <UIKit/UIKit.h>

@interface NNSetUpLoginPasswordViewController : UIViewController

/** registeredSetUp 注册后第一次设置 */
- (instancetype)initWithRegisteredSetUp:(BOOL)registeredSetUp;

/** 加密串 */
@property (nonatomic, copy) NSString *encrypt;
/** 手机号码 */
@property (nonatomic, copy) NSString *mobile;
/** 初次设置登录密码 */
@property (nonatomic, assign, getter=isFirstSetUpPassword) BOOL firstSetUpPassword;

@end
