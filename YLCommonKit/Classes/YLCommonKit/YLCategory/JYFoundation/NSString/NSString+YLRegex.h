//
//  NSString+YLRegex.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YLRegex)

#pragma mark - 正则表达式验证
/**
 * 是否是邮箱 YES:是; NO:不是
 */
+ (BOOL)yl_isEmailWith:(NSString *)str;

/**
 * 验证地址是否合法只包含 汉字、数字、英文、-、_ 、#字符
 */
+ (BOOL)yl_isAddressWith:(NSString *)address;

/**
 * 判断字符串是否包含某些字符
 */
+ (BOOL)yl_isStringContainSomeSymbolWithString:(NSString * )string Symbol:(NSArray *)symbols;

/**
 * 手机号码证验证 YES验证通过，NO验证失败
 */
+ (BOOL)yl_isPhoneNumberWith:(NSString *)str;

/**
 * 验证数字 YES:是数字; NO:不是数字
 */
+ (BOOL)yl_isNumberWith:(NSString *)str;

/**
 * 验证是否是中文 YES:是; NO:不是
 */
+ (BOOL)yl_isChineseWith:(NSString *)str;

/**
 * 验证是否是英文 YES:是; NO:不是
 */
+ (BOOL)yl_isEnglishWith:(NSString *)str;

/**
 * 验证金额，输入只限小数点后两位 YES:是数字; NO:不是数字
 */
+ (BOOL)yl_isMoneyWith:(NSString *)str;

/**
 * 车牌号的有效性验证 YES:是数字; NO:不是数字
 */
+ (BOOL)yl_isCarNumberWith:(NSString *)str;

/**
 * 是否邮政编码
 */
+ (BOOL)yl_isPostalcodeWith:(NSString *)str;

/**
 *  银行卡号有效性校验
 *  银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
- (BOOL)yl_isBankCard;

/**
 *  身份证验证 YES:是正确身份证; NO:不是有效身份证
 */
+ (BOOL)yl_isIDCardWith:(NSString *)str;

/**
 *  判断是否包含字符串
 *  @param aString 包含的字符串
 *  @return YES:包含; NO:不包含
 */
- (BOOL)yl_isContainsString:(NSString *)aString;

/**
 正则校验
 @param regularStr 正则表达式
 @param centent 验证的内容
 @return 结果
 */
+ (BOOL)yl_regularCheck:(NSString *)regularStr content:(NSString*)centent;
/**
 *  验证数字
 *  @param number 所需验证字符串
 *  @return YES:是数字; NO:不是数字
 */
+ (BOOL)yl_isNumber:(NSString*)number;

/**
 座机区号验证
 @param telephoneAreaCode 需要验证的字符串
 @return YES:验证通过; NO:验证不通过
 */
+ (BOOL)yl_isTelephoneAreaCodeWith:(NSString *)telephoneAreaCode;

/**
 座机电话验证
 @param telephone 需要验证的字符串
 @return YES:验证通过; NO:验证不通过
 */
+ (BOOL)yl_isTelephoneWith:(NSString *)telephone;


@end
