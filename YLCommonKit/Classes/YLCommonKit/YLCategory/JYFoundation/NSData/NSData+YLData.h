//
//  NSData+YLData.h
//  zhanye
//
//  Created by xyanl on 2017/11/30.
//  Copyright © 2017年 xyanl. All rights reserved.
//  二进制数据扩展

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSData (YLData)

/**
 压缩图片到指定大小,大小为多少KB
 @param image 需要压缩的图片
 @param maxFileSize 压缩的大小
 @return 压缩后的图片Data
 */
+ (NSData *)yl_compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;

/**
 将图片二进制字符串转成NSData
 @param encoding 二进制字符串
 @return 图片的NSData类型
 */
+ (NSData *)yl_dataFromBase64String:(NSString *)encoding;

@end
