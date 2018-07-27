//
//  YLHttpResponseTip.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "YLHttpResponseTip.h"

/** 相应信息 */
//NSString * const kResponseTip = @"ResponseTip";
/** 响应结果 */
NSString * const kResponseBody = @"responseBody";
/** 响应错误 */
NSString * const kErrorDesc = @"errorDesc";
/** 无网络 */
NSString * const kNoNetworkErrorDescStr = @"网络请求失败,请稍后再试";
/** 重复请求 */
NSString * const kSameRequestErrorDescStr = @"无效的重复网络请求";
/** 返回数据错误 */
NSString * const kResultDataErrorDescStr = @"返回数据格式错误";
/** 接口返回成功code */
NSString * const kResultCodeSuccessStr = @"200";
/** 接口返回失败code */
NSString * const kResultCodeErrorStr = @"201";

@implementation YLHttpResponseTip

- (void)setRetCode:(NSString *)retCode
{
    _retCode = retCode;
    self.success = [_retCode isEqualToString:kResultCodeSuccessStr];
}
/**
 * 设置错误返回码、信息描述
 */
- (void)setUpVerifyInfoWithRetCode:(NSString *)retCode errorDesc:(NSString *)errorDesc
{
    self.retCode = retCode;
    self.errorDesc = errorDesc;
}
/**
 * 设置错误代码、请求类型、返回码、错误信息
 */
- (void)setUpWithRequestErrorType:(YLHttpRequestErrorType)requestErrorType requestType:(YLHttpRequestType)requestType requestFlag:(YLHttpRequestFlag)requestFlag retCode:(NSString *)retCode errorDesc:(NSString *)errorDesc
{
    self.requestErrorType = requestErrorType;
    self.requestType = requestType;
    self.requestFlag = requestFlag;
    self.retCode = retCode;
    self.errorDesc = errorDesc;
}
/**
 * 每次请求的公用回调
 */
+ (void)callbackWithCompleteBlock:(void(^)(void))completeBlock
{
    if (completeBlock) {
        completeBlock();
    }
}

@end
