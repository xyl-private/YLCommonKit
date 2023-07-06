//
//  NSData+YLData.h
//  YLCommonKit
//
//  Created by xyanl on 2018/6/29.
//  Copyright © 2018年 xyanl. All rights reserved.
//
//  二进制数据扩展

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (YLData)

/**
 图片压缩的处理逻辑:
 
 一 尺寸压缩(一般参照像素为1280)
 a. 宽高均<=1280px时    图片尺寸保持不变
 b. 宽高均>1280px时     图片宽高比<=2，则将图片宽或者高取大的等比压缩至1280px; 图片宽高比＞2时，则宽或者高取小的等比压缩至1280px;
 c. 宽或高某一个>1280px，另一个<1280px时  图片宽高比＞2时，则宽高尺寸不变;图片宽高比≤2时,则将图片宽或者高取大的等比压缩至1280px.
 
 二 质量压缩
 一般压缩在90%
 */


/// 图片压缩
/// @param sourceImage 原图
/// @param targetPx 压缩后的图片宽高
+ (NSData *)yl_imageCompressForSizeWithImage:(UIImage *)sourceImage targetPx:(NSInteger)targetPx;

@end

NS_ASSUME_NONNULL_END
