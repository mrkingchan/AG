//
//  LanguageManager.m
//  SwitchLanguage
//  Created by Chan on 2015/6/28.
//  Copyright © 2015年 Chan. All rights reserved.
//

#define kuserDefaults(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define kuserDefaultsSet(value,key)  [[NSUserDefaults  standardUserDefaults] setObject:value forKey:key]
#define ksynchronize          [[NSUserDefaults standardUserDefaults] synchronize]

#import "LanguageManager.h"

NSString *const appLanguageKey = @"APP_LANGUAGE_KEY";

NSString *const kAppLanguageDidChange = @"kAppLanguageDidChange";

static LanguageManager *instance;

@interface LanguageManager ()

@property (nonatomic, strong) NSBundle *currentBundle;
@property (nonatomic, strong) NSArray *languages;

@end

@implementation LanguageManager

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LanguageManager alloc] init];
    });
    return instance;
}

- (NSString *)internationalizedStringForKey:(NSString *)key value:(nullable NSString *)value{
    return [self.currentBundle localizedStringForKey:key value:@"" table:nil];
}

- (NSString *)getCurrentLanguage{
    return [self currentLanguage];
}

- (NSArray *)getAppConfigLanguages{
    return self.languages;
}

- (void)setAppLanguageWithLanguageIndex:(NSInteger)index complete:(SettingLanguageSuccess)complete{
    NSAssert(index < self.languages.count, @"Please check pre-setting languages array");
    NSString *language = kuserDefaults(appLanguageKey);
    if (![language isEqualToString:self.languages[index]]) {
        NSLog(@"new language:%@",self.languages[index]);
        kuserDefaultsSet(_languages[index], appLanguageKey);
        ksynchronize;
        [[NSNotificationCenter defaultCenter] postNotificationName:kAppLanguageDidChange object:nil];
        if (complete) {
            complete(YES);
        }
    }
}

#pragma mark - private
- (NSBundle *)currentBundle{
    _currentBundle = [NSBundle bundleWithPath:[self getBundlePath]];
    return _currentBundle;
}

- (NSString *)getBundlePath{
    NSString *path = [[NSBundle mainBundle] pathForResource:[self currentLanguage] ofType:@"lproj"];
    return path;
}

- (NSString *)currentLanguage{
    //获取当前语言
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] firstObject];
    if ( kuserDefaults(appLanguageKey)&& ![kuserDefaults(appLanguageKey) isEqualToString:language]) {
        language = kuserDefaults(appLanguageKey);
    }
    return language;
}

- (NSArray *)languages{
    if (!_languages) {
        _languages = @[@"zh-Hans",@"en",@"ja",@"ko"];
    }
    return _languages;
}
@end
