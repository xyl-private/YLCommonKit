//
//  NSString+YLString.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "NSString+YLString.h"
#import "NSString+YLRegex.h"
#import <CommonCrypto/CommonDigest.h>
#import <LocalAuthentication/LocalAuthentication.h>

@implementation NSString (YLString)
#pragma mark - 其他相关

/// 转换字符串：如果是空 -> @""
+ (NSString *) yl_stringNoNullWith:(id)sender
{
    if (sender == [NSNull null]){ return @"";}
    if ([sender isKindOfClass:[NSNull class]]) { return @"";}
    if (sender == nil) { return @"";}
    if ([sender isEqualToString:@"(null)"]) { return @"";}
    if ([sender isEqualToString:@"nullnull"]) { return @"";}
    return sender;
}

/// 计算字符串的 size
/// @param content 文本内容
/// @param font 字体大小
/// @param size 计算范围的大小  ps:CGSizeMake(MAXFLOAT, fontSize)
+ (CGSize) yl_stringSizeWithContent:(NSString *)content font:(UIFont *)font constrainedToSize:(CGSize)size{
    NSDictionary *attributes = @{NSFontAttributeName : font};
    return [content boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}

/// 隐藏字符中的一部分
/// @param content 原始字符串
/// @param range 隐藏范围
+ (NSString *) yl_hideStringWith:(NSString *)content hideRange:(NSRange)range
{
    NSMutableString *mString = [NSMutableString stringWithString:content];
    NSMutableString *comStr = [NSMutableString stringWithCapacity:range.length];
    for (int i = 0; i<range.length; i++) {
        [comStr appendString:@"*"];
    }
    [mString replaceCharactersInRange:range withString:comStr];
    return mString;
}

#pragma mark - 判断
/// 判断字符串是否为 null
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

/// 验证TouchID是否可用 返回YES:可用;  NO:不可用
+ (BOOL) yl_canTouchID {
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    return [context canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
}

/// 验证TouchID是否正确 successBlock TouchID验证Block
+ (void) yl_verifyTouchID:(void(^)(BOOL success,NSError *error))successBlock {
    LAContext *context = [[LAContext alloc] init];
    // show the authentication UI with our reason string
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请用指纹解锁" reply:
     ^(BOOL success, NSError *authenticationError) {
        if (successBlock) {
            successBlock(success,authenticationError);
        }
    }];
}

#pragma mark - 加密
/// MD5加密字符串
+ (NSString *)yl_md5EncryptionWithInput:(NSString *)input {
    // OC 字符串转换位C字符串
    const char *cStr = [input UTF8String];
    // 16位加密
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    // 1: 需要加密的C字符串
    // 2: 加密的字符串的长度
    // 3: 加密长度
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    // 返回一个32位长度的加密后的字符串
    return  output;
}

#pragma mark - 身份证相关
/// 从身份证获取生日
+ (NSString *) yl_birthdayStrFromIdentityCardWith:(NSString *)str {
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

/// 从身份证获取性别
+ (NSString *) yl_getCardIdGenderWith:(NSString *)str {
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
/// 小数点取舍处理方法
/// @param roundingMode  舍入方式
/// @param number 需要计算的数值
/// @param scale 小数点后舍入值的位数
+ (NSString *)yl_decimalNumberWithRoundingMode:(NSRoundingMode)roundingMode number:(NSString *)number scale:(int)scale {
    /**
     初始化方法
     roundingMode 舍入方式
     scale 小数点后舍入值的位数
     exact 精度错误处理
     overflow 溢出错误处理
     underflow 下溢错误处理
     divideByZero 除以0的错误处理
     NSDecimalNumberHandler对象
     */
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber * ouncesDecimal = [NSDecimalNumber decimalNumberWithString:number];
    ouncesDecimal = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",ouncesDecimal];
}

///  距离格式转换
/// @param distance 距离 单位:m
+ (NSString *)yl_stringTromDitance:(NSString *)distance {
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

#pragma mark - 拼音
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

- (NSString*)yl_pinYin {
    NSMutableString *str = [self mutableCopy];
    /*转换成成带音 调的拼音*/
    CFStringTransform((CFMutableStringRef)str,NULL,kCFStringTransformMandarinLatin,NO);
    /*去掉音调*/
    CFStringTransform((CFMutableStringRef)str,NULL,kCFStringTransformStripDiacritics,NO);
    /*多音字处理*/
    if (self.length == 0) return @"";
    if ([[self substringToIndex:1] isEqualToString:@"长"]) {
        [str replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
    } else if ([[self substringToIndex:1] isEqualToString:@"沈"]) {
        [str replaceCharactersInRange:NSMakeRange(0, 4) withString:@"shen"];
    } else if ([[self substringToIndex:1] isEqualToString:@"厦"]) {
        [str replaceCharactersInRange:NSMakeRange(0, 3) withString:@"xia"];
    } else if ([[self substringToIndex:1] isEqualToString:@"地"]) {
        [str replaceCharactersInRange:NSMakeRange(0, 3) withString:@"di"];
    } else if ([[self substringToIndex:1] isEqualToString:@"重"]) {
        [str replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
    } else if ([[self substringToIndex:1] isEqualToString:@"行"]) {
        [str replaceCharactersInRange:NSMakeRange(0, 4) withString:@"xing"];
    }
    return str.lowercaseString;
}

/// 拼音首字母
- (NSString*)yl_firstLetter
{
    NSString *pinYin = [self.yl_pinYin uppercaseString];
    if (pinYin.length > 0) {
        NSString *pf = [pinYin substringToIndex:1];
        if ([NSString yl_isEnglishWith:pf]) {
            return pf;
        }
        return @"#";
    }
    return @"#";
}


#pragma mark - URL处理相关
/// 字符串 转 url
- (NSURL *) yl_url {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    return [NSURL URLWithString:(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8))];
#pragma clang diagnostic pop
}

/**
 对url特殊自己进行编码操作
 
 @param charactersInString 需要转码的特殊字符串  例:@"!$&'()*+,-./:;=?@_~%#[]"
 @return 编码后的url字符串
 */
- (NSString *)yl_urlEncodeCharacterSet:(NSString *)charactersInString {
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersInString] invertedSet];
    NSString *upSign = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return upSign;
}

/**
 urlEncode编码
 
 @return 编码后的字符串
 */
- (NSString *)yl_urlEncodeStr {
    NSString *charactersToEscape = @"!*'();:@&=+$,/?%#[]";
    NSString *upSign = [self yl_urlEncodeCharacterSet:charactersToEscape];
    return upSign;
}

/**
 urlEncode解码
 
 @return 解码后的字符串
 */
- (NSString *)yl_decoderUrlEncodeStr {
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    [outputStr replaceOccurrencesOfString:@"+" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[outputStr length])];
    return [outputStr stringByRemovingPercentEncoding];
}

#pragma mark - 数组/字典等 转 JSON 字符串
/// obj 转成 json 字符串
+ (NSString *)yl_jsonStringFromObject:(id)obj{
    if (obj == nil) {
        return @"";
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/// JSONString  转 id
/// @param jsonString JSON 字符串
+ (id)yl_dictionaryFromJSONString:(NSString *)jsonString
{
    if (jsonString == nil || jsonString.length == 0) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return obj;
}

/**
 查找子字符串在父字符串中的所有位置
 @param content 父字符串
 @param subString 子字符串
 @return 返回位置数组,NSRange的字符串类型
 */
+ (NSArray*)yl_getSubStringInRangeWithContent:(NSString *)content subString:(NSString *)subString {
    NSMutableArray *rangeArr = [[NSMutableArray alloc]init];
    NSString *tempString = content;
    NSInteger count = 0;
    while ([tempString containsString:subString]) {
        NSRange range = [tempString rangeOfString:subString];
        tempString = [tempString stringByReplacingCharactersInRange:range withString:@""];
        
        range = NSMakeRange(range.location + subString.length * count, range.length);
        [rangeArr addObject:[NSValue valueWithRange:range]];
        
        count++;
    }
    return [rangeArr copy];
}

/**
 查找子字符串在父字符串中的所有位置
 @param subString 子字符串
 @return 返回位置数组,NSRange的字符串类型
 */
- (NSArray *)yl_getSubStringInRangeWithSubString:(NSString *)subString {
    NSMutableArray *rangeArr = [[NSMutableArray alloc]init];
    NSString *tempString = self;
    NSInteger count = 0;
    while ([tempString containsString:subString]) {
        NSRange range = [tempString rangeOfString:subString];
        tempString = [tempString stringByReplacingCharactersInRange:range withString:@""];
        
        range = NSMakeRange(range.location + subString.length * count, range.length);
        [rangeArr addObject:[NSValue valueWithRange:range]];
        
        count++;
    }
    return [rangeArr copy];
}

#pragma mark - 方法1：查找 substring 在 string 中的位置范围
- (NSArray *)br_substringRange:(NSString *)substring ofString:(NSString *)string {
    NSMutableArray *rangeArr = [[NSMutableArray alloc]init];
    NSString *tempString = string;
    NSInteger count = 0;
    while ([tempString containsString:substring]) {
        NSRange range = [tempString rangeOfString:substring];
        tempString = [tempString stringByReplacingCharactersInRange:range withString:@""];
        
        range = NSMakeRange(range.location + substring.length * count, range.length);
        [rangeArr addObject:[NSValue valueWithRange:range]];
        
        count++;
    }
    return [rangeArr copy];
}

#pragma mark - 方法2：查找 substring 在 string 中的位置范围
//- (NSArray *)br_substringRange:(NSString *)substring ofString:(NSString *)string {
//    NSMutableArray *rangeArr = [[NSMutableArray alloc]init];
//    for (NSInteger i = 0; i < string.length - substring.length + 1; i++) {
//        NSString *findString = [string substringWithRange:NSMakeRange(i, substring.length)];
//        if ([findString isEqualToString:substring]) {
//            NSRange range = NSMakeRange(i, substring.length);
//            [rangeArr addObject:[NSValue valueWithRange:range]];
//        }
//    }
//    return [rangeArr copy];
//}
@end
