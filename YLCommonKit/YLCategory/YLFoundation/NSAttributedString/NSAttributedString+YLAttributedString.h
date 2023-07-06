//
//  NSAttributedString+YLAttributedString.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (YLAttributedString)

/**
 * 设置段落样式
 */
+ (NSAttributedString *)yl_stringWithParagraphlineSpeace:(CGFloat)lineSpacing kernAttribute:(CGFloat)kernAttribute textColor:(UIColor *)textcolor textFont:(UIFont *)font string:(NSString *)string;
/**
 * 计算富文本字体高度
 */
+ (CGFloat)yl_getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace kernAttribute:(CGFloat)kernAttribute withFont:(UIFont *)font withWidth:(CGFloat)width string:(NSString *)string;
/**
 * 计算富文本字体宽度
 */
+ (CGFloat)yl_getSpaceLabelWidthWithSpeace:(CGFloat)lineSpeace kernAttribute:(CGFloat)kernAttribute font:(UIFont *)font height:(CGFloat)height string:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
