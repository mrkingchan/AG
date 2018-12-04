//
//  NSDictionary+NNHExtension.m
//  NNHMyriadStore
//
//  Created by 来旭磊 on 17/3/29.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NSDictionary+NNHExtension.h"

@implementation NSDictionary (NNHExtension)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
