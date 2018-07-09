//
//  JYResponseTip.h
//  Pods
//
//  Created by xyanl on 2018/4/23.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, JYRequestError){
    JYRequestErrorTokenExprired =   -999999,        //认证失败
    JYRequestErrorLoseParam     =   -10000,
    JYRequestErrorLoseSession,
    JYRequestErrorSameInQueue,
    JYRequestErrorJsonFormat,
    JYRequestErrorTimeOut,
    JYRequestErrorHostNotReach,
    JYRequestErrorCancel,               //取消请求
    JYRequestErrorNone          =   0,//无错误
};

/***************************Response********************************/
#define kResponseTip    @"ResponseTip"
/******************************************************************/

@interface JYResponseTip : NSObject

/**
 错误代码
 */
@property (nonatomic,assign)    JYRequestError errorCode;        //response code
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
