//
//  NSAttributedString+YLAttributedString.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "NSAttributedString+YLAttributedString.h"

@implementation NSAttributedString (YLAttributedString)
/**
 * 设置段落样式
 */
+ (NSAttributedString *)yl_stringWithParagraphlineSpeace:(CGFloat)lineSpacing kernAttribute:(CGFloat)kernAttribute textColor:(UIColor *)textcolor textFont:(UIFont *)font string:(NSString *)string
{
    if (string.length == 0) return nil;
    // 设置段落
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentFromCTTextAlignment(kCTTextAlignmentJustified);
    paragraphStyle.firstLineHeadIndent = 0.1;//不设置这个，上面一行无效果
    // NSKernAttributeName字体间距
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(kernAttribute)};
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes];
    // 创建文字属性
    NSDictionary * attriBute = @{NSForegroundColorAttributeName:textcolor,NSFontAttributeName:font};
    [attriStr addAttributes:attriBute range:NSMakeRange(0, string.length)];
    return attriStr;
}
/**
 * 计算富文本字体高度
 */
+ (CGFloat)yl_getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace kernAttribute:(CGFloat)kernAttribute withFont:(UIFont *)font withWidth:(CGFloat)width string:(NSString *)string
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpeace;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentFromCTTextAlignment(kCTTextAlignmentJustified);
    paragraphStyle.firstLineHeadIndent = 0.1;//不设置这个，上面一行无效果
    // NSKernAttributeName字体间距
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@(kernAttribute)
                                 };
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size.height;
}

/**
 * 计算富文本字体宽度
 */
+ (CGFloat)yl_getSpaceLabelWidthWithSpeace:(CGFloat)lineSpeace kernAttribute:(CGFloat)kernAttribute font:(UIFont *)font height:(CGFloat)height string:(NSString *)string
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpeace;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentFromCTTextAlignment(kCTTextAlignmentJustified);
    paragraphStyle.firstLineHeadIndent = 0.1;//不设置这个，上面一行无效果
    // NSKernAttributeName字体间距
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@(kernAttribute)
                                 };
    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size.width;
}

@end
