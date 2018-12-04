//
//  LanguageManager.h
//  SwitchLanguage
//
//  Created by Chan on 2015/6/28.
//  Copyright © 2015年 Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kLocalizedString(key) \
[[LanguageManager shareInstance] internationalizedStringForKey:(key) value:@""]

extern NSString *const kAppLanguageDidChange;

typedef void(^SettingLanguageSuccess)(BOOL success);

@interface LanguageManager : NSObject

//单粒
+ (instancetype)shareInstance;

//获取对应语言的键值
- (NSString *)internationalizedStringForKey:(NSString *)key value:(NSString *)value;

//获取当前语言
- (NSString *)getCurrentLanguage;

//获取App配置语言
- (NSArray *)getAppConfigLanguages;

//更改语言
- (void)setAppLanguageWithLanguageIndex:(NSInteger)index complete:(SettingLanguageSuccess)complete;

@end
