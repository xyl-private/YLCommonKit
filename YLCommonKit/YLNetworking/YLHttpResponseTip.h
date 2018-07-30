//
//  YLHttpResponseTip.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "YLResponseTip.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YLHttpRequestTypes.h"

/** 响应信息 */
//UIKIT_EXTERN NSString * const kResponseTip;
/** 响应结果 */
UIKIT_EXTERN NSString * const kResponseBody;
/** 响应错误 */
UIKIT_EXTERN NSString * const kErrorDesc;
/** 无网络 */
UIKIT_EXTERN NSString * const kNoNetworkErrorDescStr;
/** 重复请求 */
UIKIT_EXTERN NSString * const kSameRequestErrorDescStr;
/** 返回数据错误 */
UIKIT_EXTERN NSString * const kResultDataErrorDescStr;
/** 接口返回成功code */
UIKIT_EXTERN NSString * const kResultCodeSuccessStr;
/** 接口返回失败code */
UIKIT_EXTERN NSString * const kResultCodeErrorStr;


@interface YLHttpResponseTip : YLResponseTip
/** 返回码 */
@property (nonatomic, copy) NSString *retCode;
/** 信息描述 */
@property (nonatomic, copy) NSString *errorDesc;

/**
 * 辅助
 */
/** 请求类型 */
@property (nonatomic, assign) YLHttpRequestType requestType;
/** 请求标识（为准确cancel请求）*/
@property (nonatomic, assign) YLHttpRequestFlag requestFlag;
/** 错误类型 */
@property (nonatomic, assign) YLHttpRequestErrorType requestErrorType;
/** 状态 */
@property (nonatomic, assign, getter=isSuccess) BOOL success;
/** 上传进度 */
//@property (nonatomic, assign) long long uploadProgress;
/**
 * 设置错误返回码、信息描述
 */
- (void)setUpVerifyInfoWithRetCode:(NSString *)retCode errorDesc:(NSString *)errorDesc;
/**
 * 设置错误类型、请求类型、返回码、错误信息
 */
- (void)setUpWithRequestErrorType:(YLHttpRequestErrorType)requestErrorType requestType:(YLHttpRequestType)requestType requestFlag:(YLHttpRequestFlag)requestFlag retCode:(NSString *)retCode errorDesc:(NSString *)errorDesc;
/**
 * 每次请求的公用回调
 */
+ (void)callbackWithCompleteBlock:(void (^)(void))completeBlock;

@end
