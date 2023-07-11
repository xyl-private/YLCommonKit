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

//首先导入头文件信息,IP
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation NSString (YLString)
#pragma mark - 其他相关

/// 转换字符串：如果是空 -> @""
+ (NSString *)yl_stringNoNullWith:(id)sender {
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
+ (CGSize)yl_stringSizeWithContent:(NSString *)content font:(UIFont *)font constrainedToSize:(CGSize)size {
    return [content yl_stringSizeWithFont:font constrainedToSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading];
}


/// 计算字符串的 size
/// @param font 字体
/// @param size 计算范围的大小  ps:CGSizeMake(MAXFLOAT, fontSize)
- (CGSize)yl_stringSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    return [self yl_stringSizeWithFont:font constrainedToSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading];
}


/// 计算字符串的 size
/// @param font 字体
/// @param size 计算范围的大小  ps:CGSizeMake(MAXFLOAT, fontSize)
/// @param options options description
/// NSStringDrawingUsesLineFragmentOrigin 整个文本将以每行组成的矩形为单位计算整个文本的尺寸。
/// NSStringDrawingUsesFontLeading 以字体间的行距（leading，行距：从一行文字的底部到另一行文字底部的间距。）来计算。
/// NSStringDrawingTruncatesLastVisibleLine/NSStringDrawingUsesDeviceMetric 计算文本尺寸时将以每个字或字形为单位来计算。
/// 一般使用:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
- (CGSize)yl_stringSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size options:(NSStringDrawingOptions)options {
    NSDictionary *attributes = @{NSFontAttributeName: font};
    return [self boundingRectWithSize:size options:options attributes:attributes context:nil].size;
}



/// 隐藏字符中的一部分
/// @param content 原始字符串
/// @param range 隐藏范围
+ (NSString *)yl_hideStringWith:(NSString *)content hideRange:(NSRange)range {
    NSMutableString *mString = [NSMutableString stringWithString:content];
    NSMutableString *comStr = [NSMutableString stringWithCapacity:range.length];
    for (int i = 0; i<range.length; i++) {
        [comStr appendString:@"*"];
    }
    [mString replaceCharactersInRange:range withString:comStr];
    return mString;
}

/// 截取字符串
/// - Parameter lenght: 最大长度
- (NSString *)yl_substringWithLenght:(NSInteger)lenght {
    if (self.length > lenght) {
        return [self substringToIndex:lenght];
    }
    return self;
}

/// 打电话
/// - Parameter telephone: 电话号码,+8618212345678,区号直接加在前面
+ (void)yl_callUpWithTelephone:(NSString *)telephone {
    telephone = [NSString stringWithFormat:@"telprompt://%@", telephone];
    NSURL *url = [NSURL URLWithString:telephone];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

/*!
 * @abstract 比较两个版本号
 *
 * @param serveVersion 服务器版本
 * @param currentVesion 当前版本
 *
 * @discussion
 * serveVersion:2.9.1  currentVesion:2.9.0  返回NSOrderedDescending  serveVersion 最新
 *
 * serveVersion:2.8.1  currentVesion:2.9.0  返回NSOrderedAscending currentVesion 最新
 *
 * serveVersion:2.9.0  currentVesion:2.9.0  返回NSOrderedSame 相同
 */
+ (NSComparisonResult)yl_compareVesionWithCurrentVesion:(NSString *)currentVesion serverVersion:(NSString *)serveVersion {
    
    if ([serveVersion isEqualToString:currentVesion]) {
        // 版本相同
        return NSOrderedSame;
    }
    
    // 服务器返回版
    NSArray *versionArray = [serveVersion componentsSeparatedByString:@"."];
    // 当前版本
    NSArray *currentVesionArray = [currentVesion componentsSeparatedByString:@"."];
    // 比较两个版本的位数
    NSInteger count = MIN(versionArray.count, currentVesionArray.count);
    
    for (NSInteger i = 0; i < count; i ++) {
        
        NSInteger a = [[versionArray objectAtIndex:i] integerValue];
        NSInteger b = [[currentVesionArray objectAtIndex:i] integerValue];
        
        if (a > b) {
            return NSOrderedDescending;
        }else if(a < b){
            return NSOrderedAscending;
        }
    }
    
    // 相同位对应的版本数相同, 比较多出的那位
    if (versionArray.count > currentVesionArray.count) {
        // 服务的版本 位数多, 比较新
        return NSOrderedDescending;
    }
    return NSOrderedAscending;
}

/// 获取设备当前网络IP地址
/// - Parameter preferIPv4: YES:ipv4  NO:ipv6
+ (NSString *)yl_getCurrentIP:(BOOL)preferIPv4 {
    NSArray *searchArray = preferIPv4 ?
    @[ /*IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6,*/
        IOS_WIFI @"/" IP_ADDR_IPv4,
        IOS_WIFI @"/" IP_ADDR_IPv6,
        IOS_CELLULAR @"/" IP_ADDR_IPv4,
        IOS_CELLULAR @"/" IP_ADDR_IPv6
    ] :
    @[ /*IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4,*/
        IOS_WIFI @"/" IP_ADDR_IPv6,
        IOS_WIFI @"/" IP_ADDR_IPv4,
        IOS_CELLULAR @"/" IP_ADDR_IPv6,
        IOS_CELLULAR @"/" IP_ADDR_IPv4
    ];
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
        address = addresses[key];
        if(address) *stop = YES;
    } ];
    return address ? address : @"0.0.0.0";
}

//获取所有相关IP信息
+ (NSDictionary *)getIPAddresses {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

#pragma mark - 判断
/// 判断字符串是否为 null
+ (BOOL)yl_stringValid:(NSString *)str {
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
+ (BOOL)yl_canTouchID {
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    return [context canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
}

/// 验证TouchID是否正确 successBlock TouchID验证Block
+ (void)yl_verifyTouchID:(void(^)(BOOL success,NSError *error))successBlock {
    LAContext *context = [[LAContext alloc] init];
    // show the authentication UI with our reason string
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请用指纹解锁" reply:
     ^(BOOL success, NSError *authenticationError) {
        if (successBlock) {
            successBlock(success,authenticationError);
        }
    }];
}


/// 是否包含中文
- (BOOL)yl_isContainsChinese {
    for(int i=0; i< [self length];i++) {
        int a = [self characterAtIndex:i];
        if( a > 0x4E00 && a < 0x9FFF) {
            return YES;
        }
    }
    return NO;
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
#pragma mark - ----------------------- 警告 -----------------------
    // 去掉警告的宏
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"// 找到警告的类型
    //被警告的代码
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
#pragma clang diagnostic pop
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    // 返回一个32位长度的加密后的字符串
    return  output;
}

/// 字符串SHA256加密
- (NSString *)yl_sha256Encryption {
    const char* str = [self UTF8String];
    
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(str, (CC_LONG)strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }    
    return ret;
}

/// 字符串 转 Base64
- (NSString *)yl_base64String {
    NSData *authData =  [self dataUsingEncoding: NSUTF8StringEncoding];
    NSData *base64Data = [authData base64EncodedDataWithOptions:0];
    NSString *base64 = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    NSString *base64AuthString =[NSString stringWithFormat:@"Basic %@",base64];
    return base64AuthString;
}

#pragma mark - 身份证相关
/// 从身份证获取生日
+ (NSString *)yl_birthdayStrFromIdentityCardWith:(NSString *)str {
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
+ (NSString *)yl_getCardIdGenderWith:(NSString *)str {
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

/// 距离格式转换
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
        decimal = decimal / 2;
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
+ (NSString *)yl_transform:(NSString *)chinese isSymbol:(BOOL)isSymbol {
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
- (NSString*)yl_firstLetter {
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
- (NSURL *)yl_url {
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
+ (NSString *)yl_jsonStringFromObject:(id)obj {
    if (obj == nil) {
        return @"";
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/// JSONString  转 id
/// @param jsonString JSON 字符串
/// @param error error description
+ (id)yl_dictionaryFromJSONString:(NSString *)jsonString error:(NSError **)error {
    if (jsonString.length == 0) {
        
        if (error) {
            NSDictionary *userInfo = @{ NSDebugDescriptionErrorKey: @"JSON String 转 id 失败, JSON String 的长度不能为0"};
            *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:NSURLErrorCannotDecodeContentData userInfo:userInfo];
        }
        return nil;
    }
    
    return [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:error];
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
