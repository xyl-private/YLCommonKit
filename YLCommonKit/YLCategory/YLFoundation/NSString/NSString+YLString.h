//
//  NSString+YLString.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//
//  字符串扩展

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (YLString)
#pragma mark - 其他相关

/// 转换字符串：如果是空 -> @""
+ (NSString *)yl_stringNoNullWith:(id)sender;

/// 计算字符串的 size
/// @param content 文本内容
/// @param font 字体大小
/// @param size 计算范围的大小  ps:CGSizeMake(MAXFLOAT, fontSize)
+ (CGSize)yl_stringSizeWithContent:(NSString *)content font:(UIFont *)font constrainedToSize:(CGSize)size;
/// 计算字符串的 size
/// @param font 字体
/// @param size 计算范围的大小  ps:CGSizeMake(MAXFLOAT, fontSize)
- (CGSize)yl_stringSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
/// 计算字符串的 size
/// @param font 字体
/// @param size 计算范围的大小  ps:CGSizeMake(MAXFLOAT, fontSize)
/// @param options options description
/// NSStringDrawingUsesLineFragmentOrigin 整个文本将以每行组成的矩形为单位计算整个文本的尺寸。
/// NSStringDrawingUsesFontLeading 以字体间的行距（leading，行距：从一行文字的底部到另一行文字底部的间距。）来计算。
/// NSStringDrawingTruncatesLastVisibleLine/NSStringDrawingUsesDeviceMetric 计算文本尺寸时将以每个字或字形为单位来计算。
/// 一般使用:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
- (CGSize)yl_stringSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size options:(NSStringDrawingOptions)options;

/// 隐藏字符中的一部分
/// @param content 原始字符串
/// @param range 隐藏范围
+ (NSString *)yl_hideStringWith:(NSString *)content hideRange:(NSRange)range;

/// 截取字符串
/// - Parameter lenght: 最大长度
- (NSString *)yl_substringWithLenght:(NSInteger)lenght;

/// 打电话
/// @param telephone 电话号码,+8618212345678,区号直接加在前面
+ (void)yl_callUpWithTelephone:(NSString *)telephone;

/*!
 * @abstract 比较两个版本号
 *
 * @param currentVesion 当前版本
 * @param serveVersion 服务器版本
 *
 * @discussion
 * serveVersion:2.9.1  currentVesion:2.9.0  返回NSOrderedDescending  serveVersion 最新(需要更新)
 *
 * serveVersion:2.8.1  currentVesion:2.9.0  返回NSOrderedAscending currentVesion 最新
 *
 * serveVersion:2.9.0  currentVesion:2.9.0  返回NSOrderedSame 相同
 */
+ (NSComparisonResult)yl_compareVesionWithCurrentVesion:(NSString *)currentVesion serverVersion:(NSString *)serveVersion;

/// 获取设备当前网络IP地址
/// - Parameter preferIPv4: YES:ipv4  NO:ipv6
+ (NSString *)yl_getCurrentIP:(BOOL)preferIPv4;

#pragma mark - 判断
/// 判断字符串是否为 null
+ (BOOL)yl_stringValid:(NSString *)str;
/// 验证TouchID是否可用 返回YES:可用;  NO:不可用
+ (BOOL)yl_canTouchID;
/// 验证TouchID是否正确 successBlock TouchID验证Block
+ (void)yl_verifyTouchID:(void(^)(BOOL success,NSError *error))successBlock;
/// 是否包含中文
- (BOOL)yl_isContainsChinese;

#pragma mark - 加密
/// MD5加密字符串
+ (NSString *)yl_md5EncryptionWithInput:(NSString *)input;
/// 字符串SHA256加密
- (NSString *)yl_sha256Encryption;

#pragma mark - 身份证相关
/// 从身份证获取生日
+ (NSString *)yl_birthdayStrFromIdentityCardWith:(NSString *)str;
/// 从身份证获取性别
+ (NSString *)yl_getCardIdGenderWith:(NSString *)str;

#pragma mark - 金额相关
/// 小数点取舍处理方法
/// @param roundingMode  舍入方式
/// @param number 需要计算的数值
/// @param scale 小数点后舍入值的位数
+ (NSString *)yl_decimalNumberWithRoundingMode:(NSRoundingMode)roundingMode number:(NSString *)number scale:(int)scale;

///  距离格式转换
/// @param distance 距离 单位:m
+ (NSString *)yl_stringTromDitance:(NSString *)distance;

#pragma mark - 二进制、十进制、十六进制 转换
/**
 二进制转换为十进制
 
 @param binary 二进制数
 @return 十进制数
 */
+ (NSInteger)yl_getDecimalByBinary:(NSString *)binary;

/**
 二进制转换成十六进制
 
 @param binary 二进制数
 @return 十六进制数
 */
+ (NSString *)yl_getHexByBinary:(NSString *)binary;

/**
 十进制转换为二进制
 
 @param decimal 十进制数
 @return 二进制数
 */
+ (NSString *)yl_getBinaryByDecimal:(NSInteger)decimal;

/**
 十进制转换十六进制
 
 @param decimal 十进制数
 @return 十六进制数
 */
+ (NSString *)yl_getHexByDecimal:(NSInteger)decimal;

/**
 十六进制转换为二进制
 
 @param hex 十六进制数
 @return 二进制数
 */
+ (NSString *)yl_getBinaryByHex:(NSString *)hex;

#pragma mark - 拼音

/// 汉字转拼音
/// @param chinese 汉字
/// @param isSymbol YES 带音标   NO 不带
+ (NSString *)yl_transform:(NSString *)chinese isSymbol:(BOOL)isSymbol;

/// 汉字转拼音
- (NSString*)yl_pinYin;

/// 首字母
- (NSString*)yl_firstLetter;

#pragma mark - URL处理相关
/// 字符串 转 url
- (NSURL *)yl_url;

/**
 对url特殊自己进行编码操作
 
 @param charactersInString 需要转码的特殊字符串  例:@"!$&'()*+,-./:;=?@_~%#[]"
 @return 编码后的url字符串
 */
- (NSString *)yl_urlEncodeCharacterSet:(NSString *)charactersInString;

/**
 urlEncode编码
 
 @return 编码后的字符串
 */
- (NSString *)yl_urlEncodeStr;

/**
 urlEncode解码
 
 @return 解码后的字符串
 */
- (NSString *)yl_decoderUrlEncodeStr;

#pragma mark - 数组/字典等 转 JSON 字符串
/// obj 转成 json 字符串
+ (NSString *)yl_jsonStringFromObject:(id)obj;

/// JSONString  转 id
/// @param jsonString JSON 字符串
+ (id)yl_dictionaryFromJSONString:(NSString *)jsonString;

/**
 查找子字符串在父字符串中的所有位置
 @param content 父字符串
 @param subString 子字符串
 @return 返回位置数组,NSRange的字符串类型
 */
+ (NSArray*)yl_getSubStringInRangeWithContent:(NSString *)content subString:(NSString *)subString;

/**
 查找子字符串在父字符串中的所有位置
 @param subString 子字符串
 @return 返回位置数组,NSRange的字符串类型
 */
- (NSArray*)yl_getSubStringInRangeWithSubString:(NSString *)subString;

@end
