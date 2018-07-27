//
//  YLResponseTip.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, YLRequestError){
    YLRequestErrorTokenExprired =   -999999,        //认证失败
    YLRequestErrorLoseParam     =   -10000,
    YLRequestErrorLoseSession,
    YLRequestErrorSameInQueue,
    YLRequestErrorJsonFormat,
    YLRequestErrorTimeOut,
    YLRequestErrorHostNotReach,
    YLRequestErrorCancel,               //取消请求
    YLRequestErrorNone          =   0,//无错误
};

/***************************Response********************************/
#define kResponseTip    @"ResponseTip"
/******************************************************************/

@interface YLResponseTip : NSObject

/**
 错误代码
 */
@property (nonatomic,assign)    YLRequestError errorCode;        //response code
/**
 请求代码
 */
@property (nonatomic,assign)    NSInteger requestCode;        //response code
/**
 请求类型
 */
@property (nonatomic,assign)    NSInteger type;        //request type
@property (nonatomic,assign)    NSInteger subtype;     //sub type
/**
 上传进度
 */
@property (nonatomic,assign)    float uploadProgress;     //sub type
/**
 请求标识（为准确cancel请求）
 */
@property (nonatomic,assign)      NSInteger flag;        //request flag






@end
