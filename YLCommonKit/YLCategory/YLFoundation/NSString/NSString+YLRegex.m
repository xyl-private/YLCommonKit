//
//  NSString+YLRegex.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "NSString+YLRegex.h"

@implementation NSString (YLRegex)
#pragma mark - 正则表达式验证
+ (BOOL) yl_isValidateByRegex:(NSString *)regex string:(NSString *)str
{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:str];
}
/**
 * 是否是邮箱
 */
+ (BOOL) yl_isEmailWith:(NSString *)str
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self yl_isValidateByRegex:regex string:str];
}

/**
 * 判断字符串是否包含某些字符
 */
+ (BOOL) yl_isStringContainSomeSymbolWithString:(NSString * )string Symbol:(NSArray *)symbols
{
    BOOL isOK = NO;//不包含
    for (NSString * symbol in symbols) {
        if ([string rangeOfString:symbol].location != NSNotFound) {
            isOK = YES;
        }
    }
    return isOK;
}

/**
 * 只包含 汉字、数字、英文、-、_ 、#字符
 */
+ (BOOL) yl_isAddressWith:(NSString *)address
{
    NSString * un = @"^[\u4e00-\u9fa5_-#a-zA-Z0-9]+$";
    return [self yl_isValidateByRegex:un string:address];
}

/**
 *  手机号码证验证 YES验证通过，NO验证失败
 */
+ (BOOL) yl_isPhoneNumberWith:(NSString *)str
{
    if (str.length != 11) {
        return NO;
    }
    NSString *regex = @"^1+[23456789]+\\d{9}";
    return [self yl_isValidateByRegex:regex string:str];
}
/**
 *  验证数字 YES:是数字; NO:不是数字
 */
+ (BOOL) yl_isNumberWith:(NSString *)str
{
    NSString *regex = @"[0-9.]*";
    return [self yl_isValidateByRegex:regex string:str];
}
/**
 *  验证是否是中文 YES:是; NO:不是
 */
+ (BOOL) yl_isChineseWith:(NSString *)str
{
    NSString *regex = @"[\u4e00-\u9fa5]+";
    return [self yl_isValidateByRegex:regex string:str];
}
/**
 *  验证是否是英文 YES:是; NO:不是
 */
+ (BOOL) yl_isEnglishWith:(NSString *)str
{
    NSString *regex = @"[a-zA-Z]";
    return [self yl_isValidateByRegex:regex string:str];
}
/**
 *  验证金额，输入只限小数点后两位 YES:是数字; NO:不是数字
 */
+ (BOOL) yl_isMoneyWith:(NSString *)str
{
    NSString *regex = @"^[0-9]+(\\.[0-9]{1,2})?$";
    return [self yl_isValidateByRegex:regex string:str];
}
/**
 *   车牌号的有效性验证 YES:是数字; NO:不是数字
 */
+ (BOOL) yl_isCarNumberWith:(NSString *)str
{
    //车牌号:湘K-DE829 香港车牌号码:粤Z-J499港
    NSString *regex = @"^[\\u4e00-\\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\\u4e00-\\u9fff]$";//其中\\u4e00-\\u9fa5表示unicode编码中汉字已编码部分，\\u9fa5-\\u9fff是保留部分，将来可能会添加
    return [self yl_isValidateByRegex:regex string:str];
}
/**
 * 是否邮政编码
 */
+ (BOOL) yl_isPostalcodeWith:(NSString *)str
{
    //    NSString *regex = @"^[0-8]\\\\d{5}(?!\\\\d)$";
    
    NSString *regex = @"[1-9]\\d{5}(?!\\d)$";
    return [self yl_isValidateByRegex:regex string:str];
}

+ (BOOL) yl_isPasswordValidWith:(NSString *)str{
    NSString * regex = @"^(?![0-9]+$)(?![a-z]+$)(?![A-Z]+$)(?![@.#_`]+$)[@.#_0-9A-Za-z]{6,12}$";
    return [self yl_isValidateByRegex:regex string:str];
}

/**
 * 银行卡号有效性校验
 * 银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
- (BOOL) yl_isBankCard
{
    NSString * lastNum = [[self substringFromIndex:(self.length - 1)] copy];//取出最后一位
    NSString * forwardNum = [[self substringToIndex:(self.length - 1)] copy];//前15或18位
    
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++) {
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    
    NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = (int)(forwardArr.count-1); i> -1; i--) {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }
    
    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    
    for (int i=0; i< forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2) {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        }else{//奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            }else{
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    
    __block NSInteger sumEvenNumTotal =0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    
    NSInteger lastNumber = [lastNum integerValue];
    
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    
    return (luhmTotal%10 ==0)?YES:NO;
}
/**
 *  身份证验证
 */
+ (BOOL) yl_isIDCardWith:(NSString *)str
{
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length =0;
    if (!str) {
        return NO;
    }else {
        length = str.length;
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [str substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    if (!areaFlag) {
        return false;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [str substringWithRange:NSMakeRange(6,2)].intValue +1900;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:str
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, str.length)];
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [str substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:str
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, str.length)];
            
            if(numberofMatch >0) {
                int S = ([str substringWithRange:NSMakeRange(0,1)].intValue + [str substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([str substringWithRange:NSMakeRange(1,1)].intValue + [str substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([str substringWithRange:NSMakeRange(2,1)].intValue + [str substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([str substringWithRange:NSMakeRange(3,1)].intValue + [str substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([str substringWithRange:NSMakeRange(4,1)].intValue + [str substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([str substringWithRange:NSMakeRange(5,1)].intValue + [str substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([str substringWithRange:NSMakeRange(6,1)].intValue + [str substringWithRange:NSMakeRange(16,1)].intValue) *2 + [str substringWithRange:NSMakeRange(7,1)].intValue *1 + [str substringWithRange:NSMakeRange(8,1)].intValue *6 + [str substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[str substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return false;
    }
}

- (BOOL) yl_isContainsString:(NSString *)aString
{
    NSRange range = [[self lowercaseString] rangeOfString:[aString lowercaseString]];
    return range.location != NSNotFound;
}

+ (BOOL) yl_regularCheck:(NSString *)regularStr content:(NSString*)centent
{
    if ([NSString yl_isNumber:centent]) {
        
        NSString *regex =regularStr;//@""
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        if ([pred evaluateWithObject:centent]) {
            return YES;
        }
    }
    
    return NO;
}
//验证数字
+ (BOOL) yl_isNumber:(NSString*)number {
    BOOL res = YES;
    if (!number) {
        return NO;
    }
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
/**
 * 座机区号验证
 */
+ (BOOL) yl_isTelephoneAreaCodeWith:(NSString *)telephoneAreaCode
{
    NSString *regex = @"^0[0-9]{2,3}$";
    return [self yl_isValidateByRegex:regex string:telephoneAreaCode];
}
/**
 * 座机电话验证
 */
+ (BOOL) yl_isTelephoneWith:(NSString *)telephone
{
    NSString * regex = @"^((0\\d{2,3})-)?(\\d{7,8})(-(\\d{3,}))?$";
    return [self yl_isValidateByRegex:regex string:telephone];
}

/// 判断是否包含emoji表情 YES:包含; NO:不包含
+ (BOOL) yl_stringContainsEmojiWith:(NSString *)str
{
    __block BOOL returnValue = NO;
    [str enumerateSubstringsInRange:NSMakeRange(0, [str length])
                            options:NSStringEnumerationByComposedCharacterSequences
                         usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange,BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
}

@end
