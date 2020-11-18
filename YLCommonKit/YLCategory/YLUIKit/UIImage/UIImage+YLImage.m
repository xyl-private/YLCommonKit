//
//  UIImage+YLImage.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "UIImage+YLImage.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>

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

/// 获取 网络图片的 size
/// @param URL 图片地址 支持 NSString和NSURL
+ (CGSize)yl_getNetworkPhotoSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    
    if (imageSourceRef) {
        
        // 获取图像属性
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        
        //以下是对手机32位、64位的处理
        if (imageProperties != NULL) {
            
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            
#if defined(__LP64__) && __LP64__
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
#else
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat32Type, &width);
            }
            
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat32Type, &height);
            }
#endif
            /***************** 此处解决返回图片宽高相反问题 *****************/
            // 图像旋转的方向属性
            NSInteger orientation = [(__bridge NSNumber *)CFDictionaryGetValue(imageProperties, kCGImagePropertyOrientation) integerValue];
            CGFloat temp = 0;
            switch (orientation) {  // 如果图像的方向不是正的，则宽高互换
                case UIImageOrientationLeft: // 向左逆时针旋转90度
                case UIImageOrientationRight: // 向右顺时针旋转90度
                case UIImageOrientationLeftMirrored: // 在水平翻转之后向左逆时针旋转90度
                case UIImageOrientationRightMirrored: { // 在水平翻转之后向右顺时针旋转90度
                    temp = width;
                    width = height;
                    height = temp;
                }
                    break;
                default:
                    break;
            }
            /***************** 此处解决返回图片宽高相反问题 *****************/

            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}

// 获取视频第一帧
+ (UIImage*)yl_getVideoCoverImageWithUrl:(NSString *)url
{
    NSURL * path = [NSURL URLWithString:url];
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}

/// 截图
/// @param image 被截取的图片
/// @param rect 截取方位
+ (UIImage *)yl_snippingImgWithImg:(UIImage *)image inRect:(CGRect)rect{
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}

@end
