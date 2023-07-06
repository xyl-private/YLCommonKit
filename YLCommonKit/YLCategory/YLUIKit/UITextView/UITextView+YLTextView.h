//
//  UITextView+YLTextView.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (YLTextView)

/**
 * UITextView+placeholder
 */
@property (nonatomic, copy) NSString *yl_placeHolder;

/**
 * placeHolder颜色
 */
@property (nonatomic, strong) UIColor *yl_placeHolderColor;

@end
