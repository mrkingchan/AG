//
//  UIWindow+NNExtension.m
//  YWL
//
//  Created by 牛牛 on 2018/3/27.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "UIWindow+NNExtension.h"
#import "NNTabBarController.h"
#import "NNNavigationController.h"
#import "NNHLoginViewController.h"

@implementation UIWindow (NNExtension)

- (void)loadRootViewController
{
    if ([NNHProjectControlCenter sharedControlCenter].userControl.isLoginIn) {
        self.rootViewController = [[NNTabBarController alloc] init];
    }else{
        NNHLoginViewController *loginVC = [[NNHLoginViewController alloc] init];
        NNHWeakSelf(self)
        loginVC.successLoginblock = ^{
            weakself.rootViewController = [[NNTabBarController alloc] init];
        };
        NNNavigationController *nav = [[NNNavigationController alloc] initWithRootViewController:loginVC];
        self.rootViewController = nav;
    }
}

@end
