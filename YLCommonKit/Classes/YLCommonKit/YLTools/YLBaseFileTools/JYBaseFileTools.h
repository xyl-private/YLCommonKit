//
//  JYBaseFileTools.h
//  JieYueKit_Example
//
//  Created by xyanl on 2018/5/16.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYBaseFileTools : NSObject

+ (JYBaseFileTools *)sharedInstance;

/**
 在本地沙盒创建App文件夹
 @param folderName 文件夹名称
 */
+ (void)yl_createAppFolder:(NSString*)folderName;

/**
 得到本地沙盒文件夹路径
 @param folderPath 文件夹名称
 @return 本地沙盒路径
 */
+ (NSString*)yl_appFolderPath:(NSString*)folderPath;

+ (void)yl_copy_file:(NSString *)sourcePath distPath:(NSString*)distPath;

+ (BOOL)yl_changeFileName:(NSString *)srcPath toPath:(NSString *)dstPath;
+ (BOOL)yl_remove_file:(NSString *)path;
+ (BOOL)yl_remove_filePath:(NSString*)filePath;
+ (void)yl_make_directory:(NSString *)path;
+ (bool)yl_file_exists:(NSString *)filename;
+ (BOOL)yl_addSkipBackupAttributeToItemAtURL:(NSString *)path;
+ (long long)yl_fileLength:(NSString*)path;
+ (NSDate*)yl_getFileCreatDate:(NSString*)path;

/**
 *reference:adjust file exist
 *parameters:strPath(file path)
 *return:yes or no
 */
+ (BOOL)yl_adjustFileAtPath:(NSString*)strPath;

/**
 *reference:delete file
 *parameters:strPath(file path)
 *return:yes or no
 */
+ (BOOL)yl_deleteFileAtPath:(NSString*)strPath;

/**
 *reference:create directory or file
 *parameters:strPath(file path)
 *return:yes or no
 */
+ (BOOL)yl_createDirectoryAtPath:(NSString*)strPath;

/**
 *reference:copy src  to des
 *parameters:srcPath(source file path),desPath(des filepath)
 *return:yes or no
 */
+ (BOOL)yl_copyItemAtPath:(NSString*)srcPath toPath:(NSString*)desPath;

/**
 *reference:get temp path
 *return:temp path
 */
+ (NSString*)yl_tempPath;

/**
 *reference:get document path
 *return:temp path
 */
+ (NSString*)yl_documentPath;

/**
 *reference:get cache path
 *return:temp path
 */
+ (NSString*)yl_cachedPath;

/**
 *reference:get random file path
 *parameters:suffix: jpg,jpeg,mp4...
 *return:file path
 */
+ (NSString*)yl_randomFileNameWithSuffix:(NSString*)suffix;

/**
 *reference:get mime type
 *parameters:fileName ,have suffix
 *return:mime type
 */
+ (NSString*)yl_mimeType:(NSString*)fileName;

@end
