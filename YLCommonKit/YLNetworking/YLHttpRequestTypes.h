//
//  YLHttpRequestTypes.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//  请求类型

#ifndef YLHttpRequestTypes_h
#define YLHttpRequestTypes_h

// 请求响应错误
typedef NS_ENUM(NSInteger, YLHttpRequestErrorType){
    YLHttpRequestErrorTypeNone = 0,                             // 网络无错误
    YLHttpRequestErrorTypeLoseParam,                            // 参数丢失
    YLHttpRequestErrorTypeLoseSession,                          // 无网络
    YLHttpRequestErrorTypeSameInQueue,                          // 重复请求
    YLHttpRequestErrorTypeJsonFormat,                           // 数据格式错误
    YLHttpRequestErrorTypeTimeOut,                              // 请求超时
    YLHttpRequestErrorTypeHostNotReach,                         // 主机无响应
    YLHttpRequestErrorTypeCancel,                               // 取消请求
};

// 请求类型
typedef NS_ENUM(NSInteger, YLHttpRequestType){
    /***************基础请求类型***************/
    YLHttpRequestTypeNone = 0,                                  // 默认无
    YLRequestTypeImageShow,                                     // 专门用于展业图片返显请求，请勿用
    YLRequestTypeUploadFileLHChannelZip,                        // 专门用于展业图片上传请求，请勿用
    YLRequestTypeUploadFileMarketLHChannelZip,                  // 专门用于营销图片上传请求，请勿用
    YLRequestTypeAllProductInfo,                                // 获取全部产品信息
    
};

// 请求标识
typedef NS_ENUM(NSInteger, YLHttpRequestFlag){
    /***************基础请求类型***************/
    YLHttpRequestFlagNone = 0,                                  // 默认无
    
    /***************模块请求类型***************/
    /****首页相关请求类型****/
    
    /****客户管理相关请求类型****/
    
    /****我的相关请求类型****/
    
};

#endif /* YLHttpRequestTypes_h */
