//
//  AppDelegate.m
//  YWL
//
//  Created by 牛牛 on 2018/3/2.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "NNAppDelegate.h"
#import "YTKNetworkConfig.h"
#import "UIWindow+NNExtension.h"
#import "UIViewController+NNHExtension.h"
#import "NNConsumerTradeDetailViewController.h"
#import "LanguageManager.h"

@interface NNAppDelegate ()
@end

@implementation NNAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window loadRootViewController];
    
    // 配置第三方
    [[NNHProjectControlCenter sharedControlCenter].proConfig setupIQKeyboardManager];
    
    [self netWorkConfig];
    
    [NSThread sleepForTimeInterval:1.5f];

    [self configureLanguage];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - 配置多语言国际化切换
- (void)configureLanguage {
    NSString *currentLanguage = [[NSBundle mainBundle] preferredLocalizations].firstObject;
    NSArray *configureAppLanguages = [[LanguageManager shareInstance] getAppConfigLanguages];
    if ([configureAppLanguages containsObject:currentLanguage]) {
        NSUInteger index = [configureAppLanguages indexOfObject:currentLanguage];
        [[LanguageManager shareInstance] setAppLanguageWithLanguageIndex:index complete:^(BOOL success) {
#warning ########重新初始化所有界面 ,另外在login和其他的所有页面替换国际化即可。。
            [[[UIApplication sharedApplication] keyWindow] loadRootViewController];
        }];
    }
}

- (void)netWorkConfig
{
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = [[NNHProjectControlCenter sharedControlCenter] Config_isTestMode] ? @"http://192.168.1.16:10989/" :  @"http://aagapi.zthycbec.com/";
    config.cdnUrl = [[NNHProjectControlCenter sharedControlCenter] Config_isTestMode] ? @"http://www.niuniuhuiapp.net:30985/" : @"http://aagmobile.zthycbec.com/";
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    //刷新C2C订单详情页面
    UIViewController *vc = [UIViewController currentViewController];
    NSString *className = NSStringFromClass([vc class]);
    if ([className isEqualToString:@"NNConsumerTradeDetailViewController"]) {
        NNConsumerTradeDetailViewController *detailVC = (NNConsumerTradeDetailViewController *)vc;
        [detailVC loadNetworkData];
    }
    
    //检查版本更新
    [[NNHApplicationHelper sharedInstance] versionUpdate];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
