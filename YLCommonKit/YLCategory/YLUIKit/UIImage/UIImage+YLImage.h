//
//  UIImage+YLImage.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YLImage)
/**
 * 渲染为原始图片
 */
+ (UIImage *) yl_imageWithRenderingImage:(NSString *)imageName;

/**
 * 颜色转为图片
 */
+ (UIImage *) yl_imageWithColor:(UIColor *)color;

/**
 * 颜色转为图片
 */
+ (UIImage *) yl_imageWithColor:(UIColor *)color andSize:(CGSize)size;

/**
 生成更清晰的图片
 @param image 需要更清晰的原图CIimage
 @param size 图片大小
 @return 更清晰的图片
 */
+ (UIImage *) yl_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;

/**
 获取二维码
 @param contentText 要生成二维码的字符串
 @param size 生成二维码的大小
 @return 生成的二维码图片
 */
+ (UIImage *) yl_createQRCodeWithContentText:(NSString *)contentText withSize:(CGFloat)size;

/**
 获取带中心图标的二维码
 @param contentText 要生成二维码的字符串
 @param centerImage 中心图标图片(大小为size的三分之一)
 @param size 生成二维码的大小
 @return 生成的二维码图片
 */
+ (UIImage *) yl_creatQRCodeWithContentText:(NSString *)contentText centerImage:(UIImage *)centerImage withSize:(CGFloat)size;
/**
 将UIView生成Image
 
 @param view 生成Image的View
 @param size 区域大小
 @return 生成后的Image
 */
- (UIImage *) yl_makeImageWithView:(UIView *)view withSize:(CGSize)size;

/*两张图片合成*/
+ (UIImage *) yl_imageSynthesis:(UIImage *)image1 toImage:(UIImage *)image2;


/// 获取 网络图片的 size
/// @param URL 图片地址 支持 NSString和NSURL
+ (CGSize)yl_getNetworkPhotoSizeWithURL:(id)URL;

/// 获取视频url第一帧图片
/// @param url video url
+ (UIImage*)yl_getVideoCoverImageWithUrl:(NSString *)url;

@end
