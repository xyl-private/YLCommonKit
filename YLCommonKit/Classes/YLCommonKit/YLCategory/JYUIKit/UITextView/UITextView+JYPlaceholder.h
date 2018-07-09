//
//  UITextView+JYPlaceholder.h
//  YLCommonKit
//
//  Created by xyanl on 2018/6/18.
//  Copyright © 2018年 JieyueUnion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (JYPlaceholder)
/**
 *  UITextView+placeholder
 */
@property (nonatomic, copy) NSString *yl_placeHolder;
/**
 *  IQKeyboardManager等第三方框架会读取placeholder属性并创建UIToolbar展示
 */
@property (nonatomic, copy) NSString *placeholder;
/**
 *  placeHolder颜色
 */
@property (nonatomic, strong) UIColor *yl_placeHolderColor;

@end
