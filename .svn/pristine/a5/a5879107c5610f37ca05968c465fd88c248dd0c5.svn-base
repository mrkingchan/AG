//
//  NNTabBarController.m
//  YWL
//
//  Created by 牛牛 on 2018/3/16.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNTabBarController.h"
#import "NNHomeViewController.h"
#import "NNConsumerTradeMainViewController.h"
#import "NNMineViewController.h"
#import "NNNavigationController.h"

@interface NNTabBarController () <UITabBarControllerDelegate>

@end

@implementation NNTabBarController

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBar属性
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIConfigManager fontThemeTextMinTip];

    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIConfigManager colorTabBarTitleHeight];

    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
    
    // 添加子控制器
    [self setupChildVc:[[NNHomeViewController alloc] init] title:@"首页" image:@"ic_nav_center" selectedImage:@"ic_nav_center_pressed"];
    [self setupChildVc:[[NNConsumerTradeMainViewController alloc] init] title:@"交易" image:@"ic_nav_assignment" selectedImage:@"ic_nav_assignment_pressed"];
    [self setupChildVc:[[NNMineViewController alloc] init] title:@"我的" image:@"ic_nav_mine" selectedImage:@"ic_nav_mine_pressed"];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    NNNavigationController *nav = [[NNNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


@end
