//
//  JYBaseFileTools.m
//  JieYueKit_Example
//
//  Created by xyanl on 2018/5/16.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "JYBaseFileTools.h"
#include <sys/xattr.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation JYBaseFileTools

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (JYBaseFileTools*) sharedInstance {
    static JYBaseFileTools *_singleton = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        _singleton = [[self alloc] init];
    });
    return _singleton;
}

+ (NSString*)yl_tempPath {
    return NSTemporaryDirectory();
}

+ (NSString*)yl_documentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *folderPath  = [paths objectAtIndex:0];
    return folderPath;
}

+ (NSString *)yl_cachedPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *folderPath  = [paths objectAtIndex:0];
    return folderPath;
}

+ (NSInteger)yl_getRandomNumber:(NSInteger)from to:(NSInteger)to
{
    return (NSInteger)(from+(arc4random()%(to-from +1)));
}

+ (NSString*)yl_randomFileNameWithSuffix:(NSString*)suffix
{
    NSString* strTemp = (suffix && suffix.length > 0)?suffix:@"";
    NSTimeInterval var = [[NSDate date] timeIntervalSince1970];
    NSInteger rand = [self yl_getRandomNumber:100000 to:999999];
    return [NSString stringWithFormat:@"%.0f%ld.%@",var*1000,(long)rand,strTemp];
}

+ (NSString *)yl_mimeType:(NSString*)fileName {
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[fileName pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    NSString *mimeType = [(__bridge NSString *)MIMEType copy];
    CFRelease(UTI);
    CFRelease(MIMEType);
    
    return mimeType;
}

+ (BOOL)yl_remove_file:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    bool ret = [fileManager removeItemAtPath:path error:nil];
    NSLog(@"delete file %@ : %d",path,ret);
    return ret;
}

+ (BOOL)yl_remove_filePath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents          = [fileManager contentsOfDirectoryAtPath:filePath error:NULL];
    NSEnumerator *e            = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        if (![fileManager removeItemAtPath:[filePath stringByAppendingPathComponent:filename] error:NULL]) {
            return NO;
        }
        
    }
    return YES;
}

+ (void)yl_createAppFolder:(NSString *)folderName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *folderPath  = [[paths objectAtIndex:0]stringByAppendingPathComponent:folderName];
    
    [JYBaseFileTools yl_make_directory:folderPath];
    
    [JYBaseFileTools yl_addSkipBackupAttributeToItemAtURL:folderPath];
}

+ (NSString *)yl_appFolderPath:(NSString *)folderPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [[paths objectAtIndex:0]stringByAppendingPathComponent:folderPath];
    return documentsDirectory;
}

+(void)yl_make_directory:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error=nil;
    if(![JYBaseFileTools yl_file_exists:path])
    [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
}

+ (BOOL)yl_addSkipBackupAttributeToItemAtURL:(NSString *)path
{
    const char* filePath = [path fileSystemRepresentation];
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue   = 1;
    int result           = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}

+(bool)yl_file_exists:(NSString *)filename
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filename];
}

+(long long)yl_fileLength:(NSString*)path
{
    NSFileManager *fm      = [NSFileManager defaultManager];
    NSError *error         = nil;
    NSDictionary* dictFile = [fm attributesOfItemAtPath:path error:&error];
    if (error)
    {
        NSLog(@"getfilesize error: %@", error);
        return NO;
    }
    long long nFileSize = [dictFile fileSize]; //得到文件大小
    return nFileSize;
}
//获取文件创建时间
+ (NSDate*)yl_getFileCreatDate:(NSString *)path {
    NSDate *creatDate;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fm attributesOfItemAtPath:path error:nil];
    if (fileAttributes) {
        if ((creatDate = [fileAttributes objectForKey:NSFileCreationDate])) {
            NSLog(@"date = %@",creatDate);
            return creatDate;
        }
    }
    return nil;
}

+ (void)yl_copy_file:(NSString *)sourcePath distPath:(NSString*)distPath
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error    = nil;
    [fm copyItemAtPath:sourcePath toPath:distPath error:&error];
}

+ (BOOL)yl_changeFileName:(NSString *)srcPath toPath:(NSString *)dstPath{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error    = nil;
    return [fm moveItemAtPath:srcPath toPath:dstPath error:&error];
}

+ (BOOL)yl_adjustFileAtPath:(NSString*)strPath
{
    if (!strPath) return NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:strPath];
}

+ (BOOL)yl_deleteFileAtPath:(NSString*)strPath
{
    if (!strPath) return NO;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:strPath]) return YES;
    
    NSError *error = nil;
    BOOL bRet = [fileManager removeItemAtPath:strPath error:&error];
    if (error){
    }
    return bRet;
}

+ (BOOL)yl_createDirectoryAtPath:(NSString*)strPath
{
    if (!strPath) return NO;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL bRet = [fileManager createDirectoryAtPath:strPath withIntermediateDirectories:YES attributes:nil error:&error];
    
    if (error){
    }
    return bRet;
}

+ (BOOL)yl_copyItemAtPath:(NSString*)srcPath toPath:(NSString*)desPath
{
    if (!srcPath || !desPath) return NO;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:srcPath]) return NO;
    
    NSError *error = nil;
    BOOL bRet = [fileManager copyItemAtPath:srcPath toPath:desPath error:&error];
    
    if (error){
    }
    return bRet;
}

@end
