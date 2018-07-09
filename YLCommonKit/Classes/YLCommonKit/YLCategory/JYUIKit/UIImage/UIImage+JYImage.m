//
//  UIImage+JYImage.m
//  zhanye
//
//  Created by xyanl on 2017/11/26.
//  Copyright © 2017年 xyanl. All rights reserved.
//

#import "UIImage+JYImage.h"

@implementation UIImage (JYImage)
/**
 * 渲染为原始图片
 */
+ (UIImage *)yl_imageWithRenderingImage:(NSString *)imageName
{
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
/**
 * 颜色转为图片
 */
+ (UIImage *)yl_imageWithColor:(UIColor *)color
{
    return [UIImage yl_imageWithColor:color andSize:CGSizeMake(1, 1)];
}
/**
 * 颜色转为图片
 */
+ (UIImage *)yl_imageWithColor:(UIColor *)color andSize:(CGSize)size
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

+ (UIImage *)yl_createQRCodeWithContentText:(NSString *)contentText withSize:(CGFloat) size {
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
+ (UIImage *)yl_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
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
+ (UIImage *)yl_creatQRCodeWithContentText:(NSString *)contentText centerImage:(UIImage *)centerImage withSize:(CGFloat)size {
    
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
- (UIImage *)yl_makeImageWithView:(UIView *)view withSize:(CGSize)size {
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage *)yl_imageWithUIView:(UIView *)view1
{
    CGSize screenShotSize = view1.bounds.size;
    UIGraphicsBeginImageContextWithOptions(screenShotSize,YES,0.0);
    [view1 drawViewHierarchyInRect:view1.bounds afterScreenUpdates:NO];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *)yl_imageWithUIView:(UIView *)view1 andRect:(CGRect)rect
{
    CGSize screenShotSize = rect.size;
    UIGraphicsBeginImageContextWithOptions(screenShotSize,NO,1.0);
    [view1 drawViewHierarchyInRect:CGRectMake(0, 0, screenShotSize.width, screenShotSize.height) afterScreenUpdates:NO];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)yl_resizeToSize:(CGSize)size
{
    float imageWidth = self.size.width;
    float imageHeight = self.size.height;
    
    float widthScale = imageWidth /size.width;
    float heightScale = imageHeight /size.height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), YES,0.0);
    
    if (widthScale > heightScale) {
        [self drawInRect:CGRectMake(0, 0, imageWidth /heightScale , size.height)];
    }
    else {
        [self drawInRect:CGRectMake(0, 0, size.width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return newImage;
}

//图片裁剪
- (UIImage *)yl_cropImageWithRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}

/*两张图片合成*/
+ (UIImage *)yl_addImage:(UIImage *)image1 toImage:(UIImage *)image2
{
    UIGraphicsBeginImageContextWithOptions(image1.size, YES,1.0);
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    // Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

- (UIImage *)yl_halfStretchImage
{
    CGSize size = self.size;
    return [self stretchableImageWithLeftCapWidth:size.width/2 topCapHeight:size.height/2];
}

- (UIImage *)yl_stretchableImage
{
    CGSize size = self.size;
    return [self stretchableImageWithLeftCapWidth:size.width/2 topCapHeight:size.height/2];
}

+ (UIImage *)yl_imageWithColor:(UIColor *)color radius:(CGFloat)radius
{
    return [UIImage yl_imageWithColor:color radius:radius size:CGSizeMake(10.0f, 10.0f)];
}

+ (UIImage *)yl_imageWithColor:(UIColor *)color radius:(CGFloat)radius size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    UIGraphicsBeginImageContextWithOptions((CGSizeMake(path.bounds.origin.x  + path.bounds.size.width, path.bounds.origin.y + path.bounds.size.height)), NO, .0);
    [color set];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image yl_stretchableImage];
}

+ (UIImage *)yl_imageWithRadialGradient:(NSArray *)colors size:(CGSize)size
{
    CGPoint center = CGPointMake(size.width * 0.5, size.height * 0.5);
    CGFloat innerRadius = 0;
    CGFloat outerRadius = sqrtf(size.width * size.width + size.height * size.height) * 0.5;
    
    BOOL opaque = NO;
    UIGraphicsBeginImageContextWithOptions(size, opaque, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    const size_t locationCount = 2;
    CGFloat locations[locationCount] = { 0.0, 1.0 };
    
    NSInteger numberComponents = 0;
    CGFloat colorComponents[colors.count*4];
    for (int i=0; i<colors.count; i++){
        UIColor *color = [colors objectAtIndex:i];
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        numberComponents = CGColorGetNumberOfComponents(color.CGColor);
        
        if (numberComponents == 4){
            colorComponents[i*4+0] = components[0];
            colorComponents[i*4+1] = components[1];
            colorComponents[i*4+2] = components[2];
            colorComponents[i*4+3] = components[3];
        }
        else if (numberComponents == 2){
            colorComponents[i*4+0] = components[0];
            colorComponents[i*4+1] = components[0];
            colorComponents[i*4+2] = components[0];
            colorComponents[i*4+3] = components[1];
        }
        
    }
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, colorComponents, locations, locationCount);
    
    CGContextDrawRadialGradient(context, gradient, center, innerRadius, center, outerRadius, 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
    
    return image;
}

+ (UIImage *)yl_imageWithLinearGradient:(NSArray *)colors size:(CGSize)size
{
    CGPoint startPoint = CGPointMake(0, size.width/2);
    CGPoint endPoint = CGPointMake(0, size.height);
    
    BOOL opaque = NO;
    UIGraphicsBeginImageContextWithOptions(size, opaque, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSInteger numberComponents = 0;
    CGFloat colorComponents[colors.count*4];
    for (int i=0; i<colors.count; i++){
        UIColor *color = [colors objectAtIndex:i];
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        numberComponents = CGColorGetNumberOfComponents(color.CGColor);
        
        if (numberComponents == 4){
            colorComponents[i*4+0] = components[0];
            colorComponents[i*4+1] = components[1];
            colorComponents[i*4+2] = components[2];
            colorComponents[i*4+3] = components[3];
        }
        else if (numberComponents == 2){
            colorComponents[i*4+0] = components[0];
            colorComponents[i*4+1] = components[0];
            colorComponents[i*4+2] = components[0];
            colorComponents[i*4+3] = components[1];
        }
        
    }
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient =  CGGradientCreateWithColorComponents(colorspace, colorComponents, NULL, 2);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
    
    return [image yl_stretchableImage];
}

@end
