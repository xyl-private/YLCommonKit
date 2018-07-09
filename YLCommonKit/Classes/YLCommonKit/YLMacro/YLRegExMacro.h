//
//  JYRegExMacro.h
//  Pods
//
//  Created by xyanl on 2018/5/15.
//  正则方面的宏定义

#ifndef JYRegExMacro_h
#define JYRegExMacro_h

/***************************************************************************
 * 正则表达式
 **************************/
//邮箱
#define kRegexEmail            @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"
//手机号
#define kRegexTelPhoneNO       @"^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\\d{8})$"
//昵称
#define kRegexNickName         @"^[\\u4e00-\\u9fa5\\w]+$"
//银行卡号校验
#define kRegexBankCardNO       @"\\d{15}|\\d{18}|\\d{17}x|\\d{17}X"
//金额校验
#define kRegexAmount           @"^(([0-9]|([1-9][0-9]{0,9}))((\\.[0-9]{1,2})?))$"
// 正则密码检查
#define kRegexPwd              @"[0-9A-Za-z]{6,12}"

// 正则发薪日期检查1~31数字
#define kRegular_PayDate       @"^([12][0-9]|31|30|[1-9])$"

#endif /* JYRegExMacro_h */
