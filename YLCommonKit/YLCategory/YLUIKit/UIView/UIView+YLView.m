//
//  UIView+YLView.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "UIView+YLView.h"

@implementation UIView (YLView)
/** x **/
-(void)setYl_x:(CGFloat) yl_x{
    CGRect frame = self.frame;
    frame.origin.x = yl_x;
    self.frame = frame;
}

- (CGFloat) yl_x{
    return self.frame.origin.x;
}

/** y **/
- (void)setYl_y:(CGFloat) yl_y{
    CGRect frame = self.frame;
    frame.origin.y = yl_y;
    self.frame = frame;
}

- (CGFloat) yl_y{
    return self.frame.origin.y;
}

/** 宽度 **/
- (void)setYl_width:(CGFloat) yl_width{
    CGRect frame = self.frame;
    frame.size.width = yl_width;
    self.frame = frame;
}

- (CGFloat) yl_width{
    return self.frame.size.width;
}

/** 高度 **/
- (void)setYl_height:(CGFloat) yl_height{
    CGRect frame = self.frame;
    frame.size.height = yl_height;
    self.frame = frame;
}

- (CGFloat) yl_height{
    return self.frame.size.height;
}

/** centerX **/
- (void)setYl_centerX:(CGFloat) yl_centerX{
    CGPoint center = self.center;
    center.x = yl_centerX;
    self.center = center;
}

- (CGFloat) yl_centerX{
    return self.center.x;
}

/** centerY **/
- (void)setYl_centerY:(CGFloat) yl_centerY{
    CGPoint center = self.center;
    center.y = yl_centerY;
    self.center = center;
}

- (CGFloat) yl_centerY{
    return self.center.y;
}

/** size **/
- (void)setYl_size:(CGSize) yl_size{
    CGRect frame = self.frame;
    frame.size = yl_size;
    self.frame = frame;
}

- (CGSize) yl_size{
    return self.frame.size;
}

/** origin **/
- (void)setYl_origin:(CGPoint) yl_origin{
    CGRect frame = self.frame;
    frame.origin = yl_origin;
    self.frame = frame;
}

- (CGPoint) yl_origin{
    return self.frame.origin;
}

/** 添加手势 */
- (void) yl_addTapGestureOntarget:(id)obj selector:(SEL)selector{
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:obj action:selector];
    [tap setNumberOfTapsRequired:1];
    [tap setNumberOfTouchesRequired:1];
    [self addGestureRecognizer:tap];
}

/**
 ** 绘制水平虚线
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void) yl_drawDashHorizontalLineWithLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(self.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

/**
 ** 绘制垂直虚线
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void) yl_drawDashVerticalLineWithLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetWidth(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,0, CGRectGetHeight(self.frame));
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

/**
 * 水平抖动
 */
- (void) yl_horizontalShake{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.values = @[@0, @(-10), @0, @10, @0];
    animation.repeatCount = 3;
    animation.duration = 0.06;
    animation.autoreverses = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:animation forKey:nil];
}

- (void) yl_removeAllSubviews{
    for (UIView *view in self.subviews){
        [view removeFromSuperview];
    }
}
@end
