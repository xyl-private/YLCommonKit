//
//  UIView+YLView.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "UIView+YLView.h"

@implementation UIView (YLView)

+ (instancetype)yl_viewFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (UIViewController *)yl_viewController{
    UIView *view = self;
    while (view) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
        view = view.superview;
    }
    return nil;
}

- (void)yl_removeAllSubviews{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)yl_setBackgroundImage:(UIImage *)image {
    UIGraphicsBeginImageContext(self.frame.size);
    [image drawInRect:self.bounds];
    UIImage *bgImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
}

/// view 转换成 图片
- (UIImage*)yl_snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}

/// 监听键盘 改变 view 的位置
- (void)yl_observeKeyboardOnChange:(void(^)(CGFloat keyboardTop, CGFloat height))changeHandler {
    __weak __typeof(self) wSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        // 获取键盘弹出或收回时frame
        CGRect endFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        // 获取键盘弹出所需时长
        double animDuration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        changeHandler(endFrame.origin.y, endFrame.size.height);
        [UIView animateWithDuration:animDuration animations:^{
            [wSelf layoutIfNeeded];
        }];
    }];
}

#pragma mark - UIGestureRecognizer
/// 添加点击手势
- (UITapGestureRecognizer *)yl_addTapGestureWithTarget:(id)target action:(nullable SEL)selector {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tap];
    return tap;
}

/// 添加长按手势
- (UILongPressGestureRecognizer *)yl_addLongPressGestureWithTarget:(id)target action:(nullable SEL)selector {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:longPress];
    return longPress;
}

/// 添加拖拽手势
- (UIPanGestureRecognizer *)yl_addPanGestureWithTarget:(id)target action:(nullable SEL)selector {
    UIPanGestureRecognizer *panPress = [[UIPanGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:panPress];
    return panPress;
}


#pragma mark - 圆角
- (void)yl_addRoundedCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius {
    [self yl_addRoundedCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius) frame:self.bounds];
}

- (void)yl_addRoundedCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    [self yl_addRoundedCorners:corners cornerRadii:cornerRadii frame:self.bounds];
}

- (void)yl_addRoundedCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii frame:(CGRect)frame {
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer* shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = frame;
    [shapeLayer setPath:rounded.CGPath];
    self.layer.mask = shapeLayer;
}

- (void)yl_addLayerRoundedCorners:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)yl_addLayerRoundedCorners:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
}

@end
