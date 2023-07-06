//
//  NSData+YLData.m
//  YLCommonKit
//
//  Created by xyanl on 2018/6/29.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "NSData+YLData.h"

@implementation NSData (YLData)

+ (NSData *)yl_imageCompressForSizeWithImage:(UIImage *)sourceImage targetPx:(NSInteger)targetPx {
    BOOL drawImge = NO;              // 是否需要重绘图片 默认是NO
    CGFloat scaleFactor = 0.0;       // 压缩比例
    CGFloat scaledWidth = targetPx;  // 压缩后的宽度 默认是参照像素1280px
    CGFloat scaledHeight = targetPx; // 压缩后的高度 默认是参照像素1280px
    // 压缩尺寸
    // 新图片(尺寸压缩后的)
    UIImage *newImage = nil;
    // 原size
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    // 判断尺寸
    if (width < targetPx && height < targetPx) {            // a.宽高均<=参照像素时:尺寸不变
        newImage = sourceImage;
    }else if (width > targetPx && height > targetPx) {      // b.宽或高均＞1280px时
        drawImge = YES;
        CGFloat factor = width / height;
        if (factor <= 2) {  // b.1图片宽高比≤2，则将图片宽或者高取大的等比压缩至1280px
            if (width > height) {
                scaleFactor  = targetPx / width;
            } else {
                scaleFactor = targetPx / height;
            }
        } else {            // b.2图片宽高比＞2时，则宽或者高取小的等比压缩至1280px
            if (width > height) {
                scaleFactor  = targetPx / height;
            } else {
                scaleFactor = targetPx / width;
            }
        }
    }else if (width > targetPx &&  height < targetPx ) {    // c.宽高一个＞1280px，另一个＜1280px 宽大于1280
        if (width / height > 2) {
            newImage = sourceImage;
        } else {
            drawImge = YES;
            scaleFactor = targetPx / width;
        }
    }else if (width < targetPx &&  height > targetPx) {     // c.宽高一个＞1280px，另一个＜1280px 高大于1280
        if (height / width > 2) {
            newImage = sourceImage;
        } else {
            drawImge = YES;
            scaleFactor = targetPx / height;
        }
    }
    if (drawImge == YES) {      // 图片需要重绘 按新宽高压缩重绘图片
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        UIGraphicsBeginImageContext(CGSizeMake(scaledWidth, scaledHeight));
        [sourceImage drawInRect:CGRectMake(0, 0, scaledWidth,scaledHeight)];
        newImage =UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    if (newImage == nil) {
        newImage = sourceImage;
    }
    
    // 质量压缩(图片>200kb 时)
    NSData * scaledImageData = nil;
    if (UIImageJPEGRepresentation(newImage, 1) == nil) {
        scaledImageData = UIImagePNGRepresentation(newImage);
    }else{
        scaledImageData = UIImageJPEGRepresentation(newImage, 1);
        if (scaledImageData.length >= 1024 * 200) {
            scaledImageData = UIImageJPEGRepresentation(newImage, 0.5);
        }
    }
    return scaledImageData;
}
@end
