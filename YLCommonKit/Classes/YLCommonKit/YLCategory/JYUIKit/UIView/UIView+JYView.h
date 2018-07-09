//
//  UIView+JYView.h
//  zhanye
//
//  Created by xyanl on 2017/11/26.
//  Copyright © 2017年 xyanl. All rights reserved.
//  基础视图扩展

#import <UIKit/UIKit.h>

@interface UIView (JYView)
/** X */
@property (nonatomic, assign) CGFloat yl_x;
/** Y */
@property (nonatomic, assign) CGFloat yl_y;
/** 宽度 */
@property (nonatomic, assign) CGFloat yl_width;
/** 高度 */
@property (nonatomic, assign) CGFloat yl_height;
/** centerX */
@property (nonatomic, assign) CGFloat yl_centerX;
/** centerY */
@property (nonatomic, assign) CGFloat yl_centerY;
/** size */
@property (nonatomic, assign) CGSize yl_size;
/** point */
@property (nonatomic, assign) CGPoint yl_origin;

/** 添加手势 */
- (void)yl_addTapGestureOntarget:(id)obj selector:(SEL)selector;
/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void)yl_drawDashHorizontalLineWithLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
/**
 ** 绘制垂直虚线
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void)yl_drawDashVerticalLineWithLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
/**
 * 水平抖动
 */
- (void)yl_horizontalShake;
/**
 * 删除所有Views
 */
- (void)yl_removeAllSubviews;

@end
