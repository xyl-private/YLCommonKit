//
//  UIButton+YLButton.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YLImagePosition) {
    YLImagePositionLeft = 0,          //图片在左，文字在右，默认
    YLImagePositionRight,             //图片在右，文字在左
    YLImagePositionTop,               //图片在上，文字在下
    YLImagePositionBottom,            //图片在下，文字在上
};

@interface UIButton (YLButton)

/// 设置按钮额外热区
@property (nonatomic, assign) UIEdgeInsets touchAreaInsets;

/// 利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列, 注意:这个方法需要在设置图片和文字之后才可以调用, 且button的大小要大于图片大小+文字大小+spacing
/// - Parameters:
///   - postion: 图片的位置
///   - spacing: 图片和文字的间距
- (void)yl_setImagePosition:(YLImagePosition)postion spacing:(CGFloat)spacing;

/// 设置按钮的背景色
/// - Parameters:
///   - backgroundColor: 背景色
///   - state: 状态
- (void)yl_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
