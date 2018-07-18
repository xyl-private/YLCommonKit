//
//  NSString+YLString.h
//  YLCommonKit
//
//  Created by McIntosh on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//
//  字符串扩展

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (YLString)
#pragma mark - 其他相关
/**
 获取指定大小字体的size]
 @param font 字体大小
 @return size
 */
- (CGSize)yl_sizeWithAdapterFont:(UIFont *)font;
/**
 获取指定大小字体的size]
 @param font 字体大小
 @param size 限制大小
 @return size
 */
- (CGSize)yl_sizeWithAdapterFont:(UIFont *)font constrainedToSize:(CGSize)size;
/**
 *  去除字符串空格
 *
 *  @return 返回去除空格后的字符串
 */
- (NSString *)yl_removeSpaces;
/** 处理数字类型
 *  str:   需要处理的数据
 *  type:  元/期
 */
+ (NSString *)yl_numberFormateWith:(NSString *)str addType:(NSString *)type;
/**
 * 判断字符串是否是空
 */
+ (BOOL)yl_stringIsNullWith:(NSString *)str;
/**
 *  判断字符串数值
 *
 *  @return YES/NO
 */
+ (BOOL)yl_stringValid:(NSString *)str;
/**
 *  核对输入是否为空信息
 *
 *  @param text 需要核对的字符串
 *
 *  @return YES:有字符串; NO:没有字符串
 */
+ (BOOL)yl_checkInputText:(NSString*)text;
/**
 * 转换字符串：如果是空 -> @""
 */
+ (NSString *)yl_stringNoNullWith:(id)sender;
/**
 * 计算字符串宽度
 */
+ (CGFloat)yl_getStringWidthWith:(CGFloat)fontSize string:(NSString *)str;
/**
 * 计算字符串高度 twoEdge:两侧边距总和
 */
+ (CGFloat)yl_getStringHeightWith:(CGFloat)fontSize twoEdge:(CGFloat)twoEdge string:(NSString *)str;
+ (CGFloat)yl_getStringHeightWith:(UIFont *)font strWidth:(CGFloat)strWidth string:(NSString *)str;
/**
 *  隐藏手机号中间四位号码
 */
+ (NSString *)yl_hidePhoneMiddle4NumsWith:(NSString *)str;
/**
 *  MD5加密字符串
 */
+ (NSString *)yl_stringToMD5With:(NSString *)str;
/**
 * 隐藏字符中的一部分
 */
+ (NSString *)yl_hideStringWith:(NSString *)str hideRange:(NSRange)range;
/**
 *  去除字符串两边空格
 */
+ (NSString *)yl_removeSidesSpacesWith:(NSString *)str;
/**
 *  去除字符串空格
 */
+ (NSString *)yl_removeSpacesWith:(NSString *)str;
/**
 *  去除字符串'.'
 */
+ (NSString *)yl_removeDotWith:(NSString *)str;
/**
 *  验证TouchID是否可用 返回YES:可用;  NO:不可用
 */
+ (BOOL)yl_canTouchID;
/**
 *  验证TouchID是否正确 successBlock TouchID验证Block
 */
+ (void)yl_verifyTouchID:(void(^)(BOOL success,NSError *error))successBlock;
/**
 *  判断是否包含字符串 YES:包含; NO:不包含
 */
- (BOOL)yl_containsStringWith:(NSString *)str;
/**
 *  判断是否包含emoji表情 YES:包含; NO:不包含
 */
+ (BOOL)yl_stringContainsEmojiWith:(NSString *)str;
/**
 * 打电话
 */
+ (BOOL)yl_callUpWithPhoneNum:(NSString *)str;

/**
 对url字符串特殊字符处理
 @return 返回处理过的NSURL
 */
- (NSURL *)yl_url;

#pragma mark - 身份证相关
/**
 * 从身份证获取生日
 */
+ (NSString *)yl_birthdayStrFromIdentityCardWith:(NSString *)str;
/**
 * 从身份证获取性别
 */
+(NSString *)yl_getCardIdGenderWith:(NSString *)str;

#pragma mark - 金额相关
/**
 * 字符串金额至少保留两位小数位末尾去零
 */
+ (NSString*)yl_deleteFloatAllZeroWith:(NSString *)str;
/**
 * 金额保留两位小数
 */
+ (NSString *)yl_currencyFormatWith:(NSString *)str;


@end
