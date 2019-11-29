//
//  NSString+YLString.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "NSString+YLString.h"
#import <CommonCrypto/CommonDigest.h>
#import <LocalAuthentication/LocalAuthentication.h>

@implementation NSString (YLString)
#pragma mark - 其他相关
- (CGSize) yl_sizeWithAdapterFont:(UIFont *)font
{
    NSDictionary* dic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    return [self sizeWithAttributes:dic];
}

- (CGSize) yl_sizeWithAdapterFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    NSDictionary* dic = [NSDictionary dictionaryWithObject:font
                                                    forKey:NSFontAttributeName];
    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:dic
                                     context:nil];
    return  rect.size;
}

- (NSString *) yl_removeSpaces{
    NSString *removedString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    return removedString;
}
/** 处理数字类型
 *  str:   需要处理的数据
 *  type:  元/期
 */
+ (NSString *) yl_numberFormateWith:(NSString *)str addType:(NSString *)type{
    if (type == nil) {
        type = @"";
    }
    if (str == nil) {
        return [NSString stringWithFormat:@"0%@",type];
    }else if([str rangeOfString:@"."].location == NSNotFound){
        return [NSString stringWithFormat:@"%@%@",str,type];
    }else if([str rangeOfString:@"."].location != NSNotFound){
        return [NSString stringWithFormat:@"%.2f%@",[str floatValue],type];
    }else{
        return [NSString stringWithFormat:@"%@%@",str,type];
    }
}
// 核对输入是否为空信息
+ (BOOL) yl_checkInputText:(NSString*)text{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (!text||text.length==0) {
        return NO;
    }
    return YES;
}
/**
 * 判断字符串是否是空
 */
+ (BOOL) yl_stringIsNullWith:(NSString *)str
{
    return [self yl_stringNoNullWith:[self yl_removeSpacesWith:str]].length > 0 ? NO : YES;
}

//判断字符串数值
+ (BOOL) yl_stringValid:(NSString *)str {
    if (![str isKindOfClass:[NSString class]]) {
        return NO;
    }
    if ([[str lowercaseString] isEqualToString:@"(null)"]) {
        return NO;
    }
    if ([[str lowercaseString] isEqualToString:@"<null>"]) {
        return NO;
    }
    if ([[str lowercaseString] isEqualToString:@"null"]) {
        return NO;
    }
    if (str != nil && [str length] >0 && ![@"" isEqualToString:str]) {
        return YES;
    }else {
        return NO;
    }
}
/**
 * 转换字符串：如果是空 -> @""
 */
+ (NSString *) yl_stringNoNullWith:(id)sender
{
    if (sender == [NSNull null]){ return @"";}
    if ([sender isKindOfClass:[NSNull class]]) { return @"";}
    if (sender == nil) { return @"";}
    if ([sender isEqualToString:@"(null)"]) { return @"";}
    if ([sender isEqualToString:@"nullnull"]) { return @"";}
    return sender;
}



/**
 计算字符串的 size

 @param content 文本内容
 @param font 字体大小 默认字体 非加粗之类的
 @param size 计算范围的大小  ps:CGSizeMake(MAXFLOAT, fontSize)
 @return 文本内容的 size
 */
+ (CGSize) yl_stringSizeWithContent:(NSString *)content font:(CGFloat)font constrainedToSize:(CGSize)size{
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName : [UIFont systemFontOfSize:font]
                                 };
    
    return [content boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}

/**
 *  隐藏手机号中间四位号码
 */
+ (NSString *) yl_hidePhoneMiddle4NumsWith:(NSString *)str
{
    if (![self isPhoneNumberWith:str]) return @"";
    NSString *tempStr1 = [str substringToIndex:3];
    NSString *tempStr2 = [str substringFromIndex:7];
    return [NSString stringWithFormat:@"%@****%@",[self yl_stringNoNullWith:tempStr1], [self yl_stringNoNullWith:tempStr2]];
}
/**
 *  手机号码证验证 YES验证通过，NO验证失败
 */
+ (BOOL)isPhoneNumberWith:(NSString *)str
{
    NSString *regex = @"^1+[23456789]+\\d{9}";
    return [self isValidateByRegex:regex string:str];
}
+ (BOOL)isValidateByRegex:(NSString *)regex string:(NSString *)str
{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:str];
}
/**
 *  MD5加密字符串
 */
+ (NSString *) yl_stringToMD5With:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
/**
 * 隐藏字符中的一部分
 */
+ (NSString *) yl_hideStringWith:(NSString *)str hideRange:(NSRange)range
{
    NSMutableString *mString = [NSMutableString stringWithString:str];
    NSMutableString *comStr = [NSMutableString stringWithCapacity:range.length];
    for (int i = 0; i<range.length; i++) {
        [comStr appendString:@"*"];
    }
    [mString replaceCharactersInRange:range withString:comStr];
    return mString;
}
/**
 *  去除字符串两边空格
 */
+ (NSString *) yl_removeSidesSpacesWith:(NSString *)str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    str = [str stringByTrimmingCharactersInSet:whitespace];
    return str;
}
/**
 *  去除字符串空格
 */
+ (NSString *) yl_removeSpacesWith:(NSString *)str
{
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}
/**
 *  去除字符串'.'
 */
+ (NSString *) yl_removeDotWith:(NSString *)str
{
    return [str stringByReplacingOccurrencesOfString:@"." withString:@""];
}
/**
 *  验证TouchID是否可用 返回YES:可用;  NO:不可用
 */
+ (BOOL) yl_canTouchID
{
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    return [context canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
}
/**
 *  验证TouchID是否正确 successBlock TouchID验证Block
 */
+ (void) yl_verifyTouchID:(void(^)(BOOL success,NSError *error))successBlock
{
    LAContext *context = [[LAContext alloc] init];
    // show the authentication UI with our reason string
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请用指纹解锁" reply:
     ^(BOOL success, NSError *authenticationError) {
         if (successBlock) {
             successBlock(success,authenticationError);
         }
     }];
}
/**
 *  判断是否包含字符串 YES:包含; NO:不包含
 */
- (BOOL) yl_containsStringWith:(NSString *)str
{
    NSRange range = [[self lowercaseString] rangeOfString:[str lowercaseString]];
    return range.location != NSNotFound;
}
/**
 *  判断是否包含emoji表情 YES:包含; NO:不包含
 */
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


- (NSURL *) yl_url {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    return [NSURL URLWithString:(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8))];
#pragma clang diagnostic pop
}

#pragma mark - 身份证相关
/**
 * 从身份证获取生日
 */
+ (NSString *) yl_birthdayStrFromIdentityCardWith:(NSString *)str
{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([str length]<14)
        return result;
    
    //**截取前14位
    NSString *fontNumer = [str substringWithRange:NSMakeRange(0, 13)];
    
    //**检测前14位否全都是数字;
    const char *string = [fontNumer UTF8String];
    const char *p = string;
    while (*p!='\0') {
        if(!(*p>='0'&&*p<='9'))
            isAllNumber = NO;
        p++;
    }
    if(!isAllNumber)
        return result;
    
    year = [str substringWithRange:NSMakeRange(6, 4)];
    month = [str substringWithRange:NSMakeRange(10, 2)];
    day = [str substringWithRange:NSMakeRange(12,2)];
    
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    return result;
}
/**
 * 从身份证获取性别
 */
+ (NSString *) yl_getCardIdGenderWith:(NSString *)str
{
    NSString *sex = @"";
    //获取18位 二代身份证  性别
    if (str.length == 18) {
        int sexInt = [[str substringWithRange:NSMakeRange(16,1)] intValue];
        if (sexInt % 2 != 0) { // 男
            sex = @"1";
        } else { // 女
            sex = @"0";
        }
    }
    //  获取15位 一代身份证  性别
    if (str.length == 15) {
        int sexInt = [[str substringWithRange:NSMakeRange(14,1)] intValue];
        if (sexInt % 2 != 0) { // 男
            sex = @"1";
        } else { // 女
            sex = @"0";
        }
    }
    return sex;
}

#pragma mark - 金额相关
/**
 * 字符串金额至少保留两位小数位末尾去零
 */
+ (NSString*) yl_deleteFloatAllZeroWith:(NSString *)str
{
    if ([str containsString:@"."]) {
        NSArray *arrStr = [str componentsSeparatedByString:@"."];
        NSString *str1 = arrStr.firstObject;
        NSString *str2 = arrStr.lastObject;
        while ([str2 hasSuffix:@"0"]) {
            str2 = [str2 substringToIndex:(str2.length - 1)];
        }
        if (str2.length > 1) {
            return [NSString stringWithFormat:@"%@.%@",str1, str2];
        } else if (str2.length == 1) {
            return [NSString stringWithFormat:@"%@.%@",str1, str2];
        }
        return [NSString stringWithFormat:@"%@",str1];
    }
    return [NSString stringWithFormat:@"%@",str];
}
/**
 * 金额保留两位小数
 */
+ (NSString *) yl_currencyFormatWith:(NSString *)str
{
    if ([[self yl_stringNoNullWith:str] isEqualToString:@""]) return @"0.00";
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // 设置格式
    [numberFormatter setPositiveFormat:@"###,##0.00"];
    str = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[str doubleValue]]];
    return str;
}

///  距离格式转换
/// @param distance 距离 单位:m
+(NSString *)yl_stringTromDitance:(NSString *)distance{
    NSString * distanceStr = @"";
    if (distance.intValue >= 1000) {
        if (distance.intValue%1000 == 0) {//1000的整数倍,去掉小数
            distanceStr = [NSString stringWithFormat:@"%dkm",distance.intValue/1000];
        }else{
            distanceStr = [NSString stringWithFormat:@"%0.1fkm",distance.intValue/1000.0];
        }
    }else if (distance.intValue == 0) {
        distanceStr = @"";
    }else{
        distanceStr = [NSString stringWithFormat:@"%dm",distance.intValue];
    }
    return distanceStr;
}

#pragma mark - 二进制、十进制、十六进制 转换
/**
 二进制转换为十进制
 
 @param binary 二进制数
 @return 十进制数
 */
+ (NSInteger)yl_getDecimalByBinary:(NSString *)binary {
    
    NSInteger decimal = 0;
    for (int i=0; i<binary.length; i++) {
        
        NSString *number = [binary substringWithRange:NSMakeRange(binary.length - i - 1, 1)];
        if ([number isEqualToString:@"1"]) {
            
            decimal += pow(2, i);
        }
    }
    return decimal;
}

/**
 二进制转换成十六进制
 
 @param binary 二进制数
 @return 十六进制数
 */
+ (NSString *)yl_getHexByBinary:(NSString *)binary {
    
    NSMutableDictionary *binaryDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [binaryDic setObject:@"0" forKey:@"0000"];
    [binaryDic setObject:@"1" forKey:@"0001"];
    [binaryDic setObject:@"2" forKey:@"0010"];
    [binaryDic setObject:@"3" forKey:@"0011"];
    [binaryDic setObject:@"4" forKey:@"0100"];
    [binaryDic setObject:@"5" forKey:@"0101"];
    [binaryDic setObject:@"6" forKey:@"0110"];
    [binaryDic setObject:@"7" forKey:@"0111"];
    [binaryDic setObject:@"8" forKey:@"1000"];
    [binaryDic setObject:@"9" forKey:@"1001"];
    [binaryDic setObject:@"A" forKey:@"1010"];
    [binaryDic setObject:@"B" forKey:@"1011"];
    [binaryDic setObject:@"C" forKey:@"1100"];
    [binaryDic setObject:@"D" forKey:@"1101"];
    [binaryDic setObject:@"E" forKey:@"1110"];
    [binaryDic setObject:@"F" forKey:@"1111"];
    
    if (binary.length % 4 != 0) {
        
        NSMutableString *mStr = [[NSMutableString alloc]init];;
        for (int i = 0; i < 4 - binary.length % 4; i++) {
            
            [mStr appendString:@"0"];
        }
        binary = [mStr stringByAppendingString:binary];
    }
    NSString *hex = @"";
    for (int i=0; i<binary.length; i+=4) {
        
        NSString *key = [binary substringWithRange:NSMakeRange(i, 4)];
        NSString *value = [binaryDic objectForKey:key];
        if (value) {
            
            hex = [hex stringByAppendingString:value];
        }
    }
    return hex;
}

/**
 十进制转换为二进制
 
 @param decimal 十进制数
 @return 二进制数
 */
+ (NSString *)yl_getBinaryByDecimal:(NSInteger)decimal {
    
    NSString *binary = @"";
    while (decimal) {
        
        binary = [[NSString stringWithFormat:@"%ld", decimal % 2] stringByAppendingString:binary];
        if (decimal / 2 < 1) {
            
            break;
        }
        decimal = decimal / 2 ;
    }
    if (binary.length % 4 != 0) {
        
        NSMutableString *mStr = [[NSMutableString alloc]init];;
        for (int i = 0; i < 4 - binary.length % 4; i++) {
            
            [mStr appendString:@"0"];
        }
        binary = [mStr stringByAppendingString:binary];
    }
    return binary;
}




/**
 十进制转换十六进制
 
 @param decimal 十进制数
 @return 十六进制数
 */
+ (NSString *)yl_getHexByDecimal:(NSInteger)decimal {
    
    NSString *hex =@"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i<9; i++) {
        
        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {
                
            case 10:
                letter =@"A"; break;
            case 11:
                letter =@"B"; break;
            case 12:
                letter =@"C"; break;
            case 13:
                letter =@"D"; break;
            case 14:
                letter =@"E"; break;
            case 15:
                letter =@"F"; break;
            default:
                letter = [NSString stringWithFormat:@"%ld", (long)number];
        }
        hex = [letter stringByAppendingString:hex];
        if (decimal == 0) {
            
            break;
        }
    }
    return hex;
}

/**
 十六进制转换为二进制
 
 @param hex 十六进制数
 @return 二进制数
 */
+ (NSString *)yl_getBinaryByHex:(NSString *)hex {
    
    NSMutableDictionary *hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [hexDic setObject:@"0000" forKey:@"0"];
    [hexDic setObject:@"0001" forKey:@"1"];
    [hexDic setObject:@"0010" forKey:@"2"];
    [hexDic setObject:@"0011" forKey:@"3"];
    [hexDic setObject:@"0100" forKey:@"4"];
    [hexDic setObject:@"0101" forKey:@"5"];
    [hexDic setObject:@"0110" forKey:@"6"];
    [hexDic setObject:@"0111" forKey:@"7"];
    [hexDic setObject:@"1000" forKey:@"8"];
    [hexDic setObject:@"1001" forKey:@"9"];
    [hexDic setObject:@"1010" forKey:@"A"];
    [hexDic setObject:@"1011" forKey:@"B"];
    [hexDic setObject:@"1100" forKey:@"C"];
    [hexDic setObject:@"1101" forKey:@"D"];
    [hexDic setObject:@"1110" forKey:@"E"];
    [hexDic setObject:@"1111" forKey:@"F"];
    
    NSString *binary = @"";
    for (int i=0; i<[hex length]; i++) {
        
        NSString *key = [hex substringWithRange:NSMakeRange(i, 1)];
        NSString *value = [hexDic objectForKey:key.uppercaseString];
        if (value) {
            
            binary = [binary stringByAppendingString:value];
        }
    }
    return binary;
}

#pragma mark - 汉字转拼音
/**
 汉字转拼音

 @param chinese 汉字
 @param isSymbol YES 带音标   NO 不带
 @return 拼音
 */
+ (NSString *)yl_transform:(NSString *)chinese isSymbol:(BOOL)isSymbol{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    
    if (!isSymbol) {
        //去掉拼音的音标
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    }
    //返回最近结果
    return pinyin;
}
@end
