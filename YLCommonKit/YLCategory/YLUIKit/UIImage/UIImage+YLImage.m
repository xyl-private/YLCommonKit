//
//  UIImage+YLImage.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "UIImage+YLImage.h"

@implementation UIImage (YLImage)

/**
 * 渲染为原始图片
 */
+ (UIImage *) yl_imageWithRenderingImage:(NSString *)imageName
{
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
/**
 * 颜色转为图片
 */
+ (UIImage *) yl_imageWithColor:(UIColor *)color
{
    return [UIImage yl_imageWithColor:color andSize:CGSizeMake(1, 1)];
}
/**
 * 颜色转为图片
 */
+ (UIImage *) yl_imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 获取二维码
 @param contentText 要生成二维码的字符串
 @param size 生成二维码的大小
 @return 生成的二维码图片
 */

+ (UIImage *) yl_createQRCodeWithContentText:(NSString *)contentText withSize:(CGFloat) size {
    // 1. 创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    
    // 2. 给滤镜添加数据
    NSString *string = contentText;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 使用KVC的方式给filter赋值
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 3. 生成二维码
    CIImage *image = [filter outputImage];
    //--------生成更清晰的图片---------
    return [self yl_createNonInterpolatedUIImageFormCIImage:image withSize:size];
}
/**
 生成更清晰的图片
 
 @param image 需要更清晰的原图CIimage
 @param size 图片大小
 @return 更清晰的图片
 */
+ (UIImage *) yl_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}
/**
 获取带中心图标的二维码
 
 @param contentText 要生成二维码的字符串
 @param centerImage 中心图标图片(大小为size的三分之一)
 @param size 生成二维码的大小
 @return 生成的二维码图片
 */
+ (UIImage *) yl_creatQRCodeWithContentText:(NSString *)contentText centerImage:(UIImage *)centerImage withSize:(CGFloat)size {
    
    UIImage *img = [self yl_createQRCodeWithContentText:contentText withSize:size];
    //----------合成图片-----------
    UIGraphicsBeginImageContextWithOptions(img.size, NO,[UIScreen mainScreen].scale);
    //绘制最下面一层的图片
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    //绘制上层图片
    [centerImage drawInRect:CGRectMake((size - (size/3))/2, (size - (size/3))/2, size/3, size/3)];
    //获取会之后的 图片
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    // 绘制后结束
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

/**
 将UIView生成Image
 @param view 生成Image的View
 @param size 区域大小
 @return 生成后的Image
 */
- (UIImage *) yl_makeImageWithView:(UIView *)view withSize:(CGSize)size {
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/*两张图片合成*/
+ (UIImage *) yl_imageSynthesis:(UIImage *)image1 toImage:(UIImage *)image2{
    UIGraphicsBeginImageContextWithOptions(image1.size, YES,1.0);
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    // Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}
@end
