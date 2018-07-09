//
//  UIImage+JYImage.h
//  zhanye
//
//  Created by xyanl on 2017/11/26.
//  Copyright © 2017年 xyanl. All rights reserved.
//  图片扩展

#import <UIKit/UIKit.h>

@interface UIImage (JYImage)
/**
 * 渲染为原始图片
 */
+ (UIImage *)yl_imageWithRenderingImage:(NSString *)imageName;

/**
 * 颜色转为图片
 */
+ (UIImage *)yl_imageWithColor:(UIColor *)color;

/**
 * 颜色转为图片
 */
+ (UIImage *)yl_imageWithColor:(UIColor *)color andSize:(CGSize)size;

/**
 生成更清晰的图片
 @param image 需要更清晰的原图CIimage
 @param size 图片大小
 @return 更清晰的图片
 */
+ (UIImage *)yl_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;

/**
 获取二维码
 @param contentText 要生成二维码的字符串
 @param size 生成二维码的大小
 @return 生成的二维码图片
 */
+ (UIImage *)yl_createQRCodeWithContentText:(NSString *)contentText withSize:(CGFloat)size;

/**
 获取带中心图标的二维码
 @param contentText 要生成二维码的字符串
 @param centerImage 中心图标图片(大小为size的三分之一)
 @param size 生成二维码的大小
 @return 生成的二维码图片
 */
+ (UIImage *)yl_creatQRCodeWithContentText:(NSString *)contentText centerImage:(UIImage *)centerImage withSize:(CGFloat)size;
/**
 将UIView生成Image
 
 @param view 生成Image的View
 @param size 区域大小
 @return 生成后的Image
 */
- (UIImage *)yl_makeImageWithView:(UIView *)view withSize:(CGSize)size;

+ (UIImage *)yl_imageWithUIView:(UIView *)view1;
+ (UIImage *)yl_imageWithUIView:(UIView *)view1 andRect:(CGRect)rect;

- (UIImage *)yl_resizeToSize:(CGSize)size;
- (UIImage *)yl_cropImageWithRect:(CGRect)rect;
+ (UIImage *)yl_addImage:(UIImage *)image1 toImage:(UIImage *)image2;
- (UIImage *)yl_halfStretchImage;

- (UIImage *)yl_stretchableImage;
+ (UIImage *)yl_imageWithColor:(UIColor*)color radius:(CGFloat)radius;
+ (UIImage *)yl_imageWithColor:(UIColor*)color radius:(CGFloat)radius size:(CGSize)size;
+ (UIImage *)yl_imageWithRadialGradient:(NSArray*)colors size:(CGSize)size;
+ (UIImage *)yl_imageWithLinearGradient:(NSArray*)colors size:(CGSize)size;

@end
