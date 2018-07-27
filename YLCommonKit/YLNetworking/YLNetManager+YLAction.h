//
//  YLNetManager+YLAction.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "YLNetManager.h"
#import "YLHttpResponseTip.h"

NS_ASSUME_NONNULL_BEGIN

/** 进度progressBlock回调 */
typedef void(^ProgressBlock)(YLHttpResponseTip *tip);
#define YLPROGRESSBLOCK(tip)  {[YLHttpResponseTip callbackWithCompleteBlock:^{if(progressBlock){progressBlock(tip);}}];};
/** 单个参数完成completeBlock回调 */
typedef void(^CompleteBlock)(YLHttpResponseTip *tip, id _Nullable result);
#define YLCOMPLETEBLOCK(tip, result)  {[YLHttpResponseTip callbackWithCompleteBlock:^{if(completeBlock){completeBlock(tip, result);}}];};
/** 多个参数完成completeBlock回调 - isPullDownRefresh：是否下拉刷新 */
typedef void(^CompleteBlocks)(YLHttpResponseTip *tip, id _Nullable result, BOOL isPullDownRefresh);
#define YLCOMPLETEBLOCKS(tip, result, isPullDownRefresh)  {[YLHttpResponseTip callbackWithCompleteBlock:^{if(completeBlocks){completeBlocks(tip, result, isPullDownRefresh);}}];};

/** 网络加解密Key */
UIKIT_EXTERN NSString * const AESPWDKey;
/** AES加密请求Key */
UIKIT_EXTERN NSString * const AESBodyEncrypt;
/** AES解密请求Key */
UIKIT_EXTERN NSString * const AESBodyDecrypt;

@interface YLNetManager (YLAction)
/**
 post请求
 
 @param url 请求地址
 @param params 参数字典
 @param type 请求类型
 @param completeBlock 请求回调
 */
- (void)yl_postWithUrl:(NSString *)url parameters:(NSDictionary *)params type:(YLHttpRequestType)type completeBlock:(CompleteBlock)completeBlock;

/**
 post请求 带flag请求标识
 
 @param url 请求地址
 @param params 参数字典
 @param type 请求类型
 @param flag flag
 @param completeBlock 请求回调
 */
- (void)yl_postWithUrl:(NSString *)url parameters:(NSDictionary *)params type:(YLHttpRequestType)type flag:(YLHttpRequestFlag)flag completeBlock:(CompleteBlock)completeBlock;

/**
 上传
 
 @param url 地址
 @param fileUrl 文件地址
 @param params 字典参数
 @param type 请求类型
 @param progressBlock 进度回调
 @param completeBlock 请求回调
 */
- (void)yl_uploadWithUrl:(NSString *)url fileUrl:(NSString *)fileUrl parameters:(NSDictionary *)params type:(YLHttpRequestType)type progressBlock:(_Nullable ProgressBlock)progressBlock completeBlock:(CompleteBlock)completeBlock;

/**
 上传
 
 @param url 地址
 @param fileUrl 文件地址
 @param params 字典参数
 @param type 请求类型
 @param flag flag
 @param progressBlock 进度回调
 @param completeBlock 请求回调
 */
- (void)yl_uploadWithUrl:(NSString *)url fileUrl:(NSString *)fileUrl parameters:(NSDictionary *)params type:(YLHttpRequestType)type flag:(YLHttpRequestFlag)flag progressBlock:(_Nullable ProgressBlock)progressBlock completeBlock:(CompleteBlock)completeBlock;

/**
 取消请求
 
 @param type 取消的请求类型
 */
- (void)yl_cancelRequestType:(YLHttpRequestType)type;

/**
 取消请求
 
 @param type 取消的请求类型
 @param flag 取消的请求flag
 */
- (void)yl_cancelRequestType:(YLHttpRequestType)type flag:(YLHttpRequestFlag)flag;

@end

NS_ASSUME_NONNULL_END
