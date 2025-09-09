//
//  UIView+YLRoundedCorners.m
//  YLCommonKit
//
//  Created by xyanl on 2025/9/9.
//  Copyright © 2025 xyanl. All rights reserved.
//

#import "UIView+YLRoundedCorners.h"
#import <objc/runtime.h>

static char kRoundedCornersShapeLayerKey;

@implementation UIView (YLRoundedCorners)

#pragma mark - Public Methods

- (void)yl_addRoundedCornersRadius:(CGFloat)cornerRadius {
    [self yl_addRoundedCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius) frame:self.bounds];
}

- (void)yl_addRoundedCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    [self layoutIfNeeded]; // 确保frame已更新
    [self yl_addRoundedCorners:corners cornerRadii:cornerRadii frame:self.bounds];
}

- (void)yl_addRoundedCorners:(UIRectCorner)corners
                 cornerRadii:(CGSize)cornerRadii
                       frame:(CGRect)frame {
    [self _applyRoundedCorners:corners
                   cornerRadii:cornerRadii
                         frame:frame
                      animated:NO
                      duration:0];
}

- (void)yl_addRoundedCorners:(UIRectCorner)corners
                 cornerRadii:(CGSize)cornerRadii
           animationDuration:(NSTimeInterval)duration {
    [self layoutIfNeeded];
    [self _applyRoundedCorners:corners
                   cornerRadii:cornerRadii
                         frame:self.bounds
                      animated:YES
                      duration:duration];
}

- (void)yl_removeRoundedCorners {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.layer.mask = nil;
    [CATransaction commit];
    
    objc_setAssociatedObject(self, &kRoundedCornersShapeLayerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)yl_hasRoundedCorners {
    return [self.layer.mask isKindOfClass:[CAShapeLayer class]];
}

/// 为视图设置自定义圆角
/// - Parameters:
///   - topLeft: 左上角半径
///   - topRight: 右上角半径
///   - bottomLeft: 左下角半径
///   - bottomRight: 右下角半径
- (void)yl_addCornerRadiusWithTopLeft:(CGFloat)topLeft
                             topRight:(CGFloat)topRight
                           bottomLeft:(CGFloat)bottomLeft
                          bottomRight:(CGFloat)bottomRight {
    
    // 确保在布局完成后执行
    dispatch_async(dispatch_get_main_queue(), ^{
        UIBezierPath *maskPath = [UIBezierPath bezierPath];
        CGRect bounds = self.bounds;
        CGFloat width = CGRectGetWidth(bounds);
        CGFloat height = CGRectGetHeight(bounds);
        
        // 开始路径
        [maskPath moveToPoint:CGPointMake(0, topLeft)];
        
        // 左上角圆弧
        if (topLeft > 0) {
            [maskPath addArcWithCenter:CGPointMake(topLeft, topLeft)
                                radius:topLeft
                            startAngle:M_PI
                              endAngle:M_PI * 3 / 2
                             clockwise:YES];
        } else {
            [maskPath addLineToPoint:CGPointMake(0, 0)];
        }
        
        // 顶部线
        [maskPath addLineToPoint:CGPointMake(width - topRight, 0)];
        
        // 右上角圆弧
        if (topRight > 0) {
            [maskPath addArcWithCenter:CGPointMake(width - topRight, topRight)
                                radius:topRight
                            startAngle:M_PI * 3 / 2
                              endAngle:0
                             clockwise:YES];
        } else {
            [maskPath addLineToPoint:CGPointMake(width, 0)];
        }
        
        // 右侧线
        [maskPath addLineToPoint:CGPointMake(width, height - bottomRight)];
        
        // 右下角圆弧
        if (bottomRight > 0) {
            [maskPath addArcWithCenter:CGPointMake(width - bottomRight, height - bottomRight)
                                radius:bottomRight
                            startAngle:0
                              endAngle:M_PI / 2
                             clockwise:YES];
        } else {
            [maskPath addLineToPoint:CGPointMake(width, height)];
        }
        
        // 底部线
        [maskPath addLineToPoint:CGPointMake(bottomLeft, height)];
        
        // 左下角圆弧
        if (bottomLeft > 0) {
            [maskPath addArcWithCenter:CGPointMake(bottomLeft, height - bottomLeft)
                                radius:bottomLeft
                            startAngle:M_PI / 2
                              endAngle:M_PI
                             clockwise:YES];
        } else {
            [maskPath addLineToPoint:CGPointMake(0, height)];
        }
        
        // 闭合路径
        [maskPath closePath];
        
        // 创建形状图层
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    });
}

#pragma mark - Private Methods

- (void)_applyRoundedCorners:(UIRectCorner)corners
                 cornerRadii:(CGSize)cornerRadii
                       frame:(CGRect)frame
                    animated:(BOOL)animated
                    duration:(NSTimeInterval)duration {
    // 参数检查
    if (CGRectIsNull(frame) || CGRectIsEmpty(frame)) {
        NSLog(@"Warning: Invalid frame provided for rounded corners");
        return;
    }
    
    // 获取或创建shape layer
    CAShapeLayer *shapeLayer = [self _roundedCornersShapeLayer];
    if (!shapeLayer) {
        shapeLayer = [CAShapeLayer layer];
        objc_setAssociatedObject(self, &kRoundedCornersShapeLayerKey, shapeLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    // 创建圆角路径
    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:frame
                                                      byRoundingCorners:corners
                                                            cornerRadii:cornerRadii];
    
    // 配置shape layer
    shapeLayer.frame = frame;
    shapeLayer.path = roundedPath.CGPath;
    
    // 设置mask（禁用隐式动画）
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    self.layer.mask = shapeLayer;
    [CATransaction commit];
    
    // 添加动画（如果需要）
    if (animated && duration > 0) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.fromValue = (__bridge id _Nullable)([(CAShapeLayer *)self.layer.mask path]);
        animation.toValue = (__bridge id _Nullable)(roundedPath.CGPath);
        animation.duration = duration;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [shapeLayer addAnimation:animation forKey:@"path"];
    }
}

- (CAShapeLayer *)_roundedCornersShapeLayer {
    id layer = objc_getAssociatedObject(self, &kRoundedCornersShapeLayerKey);
    return [layer isKindOfClass:[CAShapeLayer class]] ? layer : nil;
}

#pragma mark - 边框

- (void)yl_addLayerRoundedCorners:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor {
    [self yl_addLayerRoundedCorners:cornerRadius borderWidth:borderWidth borderColor:borderColor animation:NO duration:0];
}

- (void)yl_addLayerRoundedCorners:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                        animation:(BOOL)animated
                         duration:(NSTimeInterval)duration {
    // 1. 参数校验
    if (cornerRadius < 0) {
        NSLog(@"Warning: Invalid corner radius, must be >= 0");
        cornerRadius = 0;
    }
    
    if (borderWidth < 0) {
        NSLog(@"Warning: Invalid border width, must be >= 0");
        borderWidth = 0;
    }
    
    if (animated && duration > 0) {
        [UIView animateWithDuration:duration animations:^{
            [CATransaction begin];
            [CATransaction setAnimationDuration:duration];
            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            
            [self _applyLayerRoundedCorners:cornerRadius borderWidth:borderWidth borderColor:borderColor];
            
            [CATransaction commit];
        }];
    } else {
        [self _applyLayerRoundedCorners:cornerRadius borderWidth:borderWidth borderColor:borderColor];
    }
}

- (void)_applyLayerRoundedCorners:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    
    if (borderWidth > 0) {
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = borderColor.CGColor;
    } else {
        self.layer.borderWidth = 0;
        self.layer.borderColor = nil;
    }
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)yl_removeLayerRoundedCorners {
    [self yl_addLayerRoundedCorners:0 borderWidth:0 borderColor:[UIColor whiteColor]];
}

@end
