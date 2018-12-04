//
//  NSString+NNHExtension.m
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/19.
//  Copyright © 2016年 NBT. All rights reserved.
//

#import "NSString+NNHExtension.h"
//#import "NSDate+NNHExtension.h"

@implementation NSString (NNHExtension)

// 谁调用就计算谁的size
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:textAttrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

- (BOOL)nn_isValidNumber
{
    NSString *regex = @"^[0-9]+$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

- (BOOL)checkIsPhoneNumber
{
    NSString *pattern = @"^1[34578]\\d{9}$";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return results.count > 0;
}

- (BOOL)checkIsEmail
{
    NSString *pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return results.count > 0;
}

- (BOOL)checkIsCardNumber
{
    NSString *pattern = @"^\\d{15}|\\d{18}$";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return results.count > 0;
    
    
//    //判断是否为空
//    if (identityCard==nil||identityCard.length <= 0) {
//        return NO;
//    }
//    //判断是否是18位，末尾是否是x
//    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
//    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
//    if(![identityCardPredicate evaluateWithObject:identityCard]){
//        return NO;
//    }
//    //判断生日是否合法
//    NSRange range = NSMakeRange(6,8);
//    NSString *datestr = [identityCard substringWithRange:range];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat : @"yyyyMMdd"];
//    if([formatter dateFromString:datestr]==nil){
//        return NO;
//    }
//    
//    //判断校验位
//    if(identityCard.length==18)
//    {
//        NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
//        NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
//        int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
//        for(int i=0;i<17;i++){
//            idCardWiSum+=[[identityCard substringWithRange:NSMakeRange(i,1)] intValue]*[idCardWi[i] intValue];
//        }
//        
//        int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
//        NSString *idCardLast=[identityCard substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
//        
//        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
//        if(idCardMod==2){
//            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
//                return YES;
//            }else{
//                return NO;
//            }
//        }else{
//            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
//            if([idCardLast intValue]==[idCardY[idCardMod] intValue]){
//                return YES;
//            }else{
//                return NO;
//            }
//        }
//    }
//    return NO;
}

- (BOOL)checkIsValidateNickname
{
    NSString *nicknameRegex = @"^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}

// 判断字符串内容是否合法：2-12位汉字、字母、数字
- (BOOL)validateFormatByRegexForString:(NSString *)string {
    BOOL isValid = YES;
    NSUInteger len = string.length;
    if (len > 0) {
        NSString *numberRegex = @"^[a-zA-Z0-9\u4e00-\u9fa5]{2,12}$";
        NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
        isValid = [numberPredicate evaluateWithObject:string];
    }
    return isValid;
}

/** 正则匹配用户密码 6 - 20 位数字和字母组合 */
-(BOOL)checkPassWord
{
    //6-20位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

//判断是否银行卡
+ (BOOL)checkCardNum:(NSString*)cardNum{
    int oddsum = 0;    //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNum length];
    int lastNum = [[cardNum substringFromIndex:cardNoLength-1] intValue];
    
    cardNum = [cardNum substringToIndex:cardNoLength -1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNum substringWithRange:NSMakeRange(i-1,1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) ==0)
        return YES;
    else
        return NO;
}


+ (BOOL)isEmptyString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (NSString *)replaceStringWithAsterisk:(NSInteger)startLocation length:(NSInteger)length
{
    if (self.length == 0) return @"";
    NSString *replaceStr = self;
    NSRange range;
    for (NSInteger i = 0; i < length; i++) {
        range = NSMakeRange(startLocation, 1);
        replaceStr = [replaceStr stringByReplacingCharactersInRange:range withString:@"*"];
        startLocation ++;
    }
    return replaceStr;
}

+(NSString *)JsonModel:(NSDictionary *)dictModel
{
    if ([NSJSONSerialization isValidJSONObject:dictModel])
    {
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictModel options:NSJSONWritingPrettyPrinted error:nil];
        NSString * jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;
    }
    return nil;
}

+ (NSString *)arrayToJSONString:(NSArray *)array
{
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return jsonString;
}


/** 拼接牛豆 元 */
+ (NSString *)goodsPriceWithAmount:(NSString *)amount bull:(NSString *)bull
{
    if ([NSString isEmptyString:amount] && [NSString isEmptyString:bull]) return @"";
    
    BOOL amountNone = [amount isEqualToString:@"0"] || [amount isEqualToString:@"0.00"];
    BOOL bullNone = [bull isEqualToString:@"0"] || [bull isEqualToString:@"0.00"];
    
    if (!amountNone && !bullNone) {
        return [NSString stringWithFormat:@"¥%@ + %@%@",amount, bull,NNHCurrency];
    }else if (!amountNone && bullNone) {
        return [NSString stringWithFormat:@"¥%@",amount];
    }else if (amountNone && !bullNone) {
        return [NSString stringWithFormat:@"%@%@",bull,NNHCurrency];
    }else {
        return [NSString stringWithFormat:@"¥%@",amount];
    }
}

/** 拼接牛豆 元 运费*/
+ (NSString *)goodsPriceWithAmount:(NSString *)amount bull:(NSString *)bull franking:(NSString *)franking
{
    CGFloat postage = 0;
    
    if (![franking isEqualToString:@"0"] || franking != nil) {
        postage = [franking floatValue];
    }
    
    CGFloat amountFloat = amount.floatValue + postage;
    amount = [NSString stringWithFormat:@"%.2f",amountFloat];
    
    NSString *text;
    
    if (![amount isEqualToString:@"0.00"] && ![bull isEqualToString:@"0"]) {
        text = [NSString stringWithFormat:@"¥%@ + %@牛豆",amount, bull];
    }else if (![amount isEqualToString:@"0.00"] && [bull isEqualToString:@"0"]) {
        text = [NSString stringWithFormat:@"¥%@",amount];
    }else if ([amount isEqualToString:@"0.00"] && ![bull isEqualToString:@"0"]) {
        text = [NSString stringWithFormat:@"%@牛豆",bull];
    }else {
        text = [NSString stringWithFormat:@"¥%@",amount];
    }
    
    return text;
}

+ (NSString *)nnh_hourStringWithTimeStamp:(NSString *)stamp
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    NSTimeInterval _interval=[stamp doubleValue] / 1000.0;
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd"];
//    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [objDateformat stringFromDate:createDate];
}

+ (NSString *)dateStringWithTimeStamp:(NSString *)stamp
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 设置日期格式（声明字符串里面每个数字和单词的含义）
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    NSTimeInterval _interval=[stamp doubleValue];
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [objDateformat stringFromDate:createDate];
}

+ (NSString *)nn_Timestamp
{
    return  [[NSNumber numberWithLongLong:[[NSDate date] timeIntervalSince1970]*1000] stringValue];
}

- (NSDictionary *)getUrlParameters
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:self];
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    for (NSURLQueryItem *item in urlComponents.queryItems) {
        [paramsDic setObject:item.value forKey:item.name];
    }
    return paramsDic;
}



@end
