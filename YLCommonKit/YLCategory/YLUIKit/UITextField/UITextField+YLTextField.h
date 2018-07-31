//
//  UITextField+YLTextField.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (YLTextField)

/**
 判断textField输入的是否包含表情
 
 @param textField 输入框
 @param string 站位字符串
 @return 是否包含表情
 */
+ (BOOL) yl_isEmojiWithTextField:(UITextField *)textField replacementString:(NSString *)string;

/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
+ (BOOL) yl_isNineKeyBoard:(NSString *)string;

/**
 是否是表情键盘
 @param textField 输入框
 @return 是否是表情键盘
 */
+ (BOOL) yl_isEmojiInputMode:(UIResponder *)textField;

/*
 *利用Emoji表情最终会被编码成Unicode，因此，
 *只要知道Emoji表情的Unicode编码的范围，
 *就可以判断用户是否输入了Emoji表情。
 */
+ (BOOL) yl_stringContainsEmoji:(NSString *)string;

@end
