//
//  UIView+YLView.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "UIView+YLView.h"

@implementation UIView (YLView)

- (UIViewController *)viewController {
    return [self yl_viewController];
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

+ (instancetype)yl_viewFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)yl_setBackgroundImage:(UIImage *)image {
    UIGraphicsBeginImageContext(self.frame.size);
    [image drawInRect:self.bounds];
    UIImage *bgImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
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

/// view 转换成 图片
- (UIImage*)yl_snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}

+ (CAShapeLayer *)yl_viewClipRect:(CGRect)viewRect rectCorner:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii{
    // 圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:viewRect byRoundingCorners:rectCorner cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = viewRect;
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param cornerRadii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)yl_addRoundedCorners:(UIRectCorner)corners
                 cornerRadii:(CGSize)cornerRadii {
    [self yl_addRoundedCorners:corners cornerRadii:cornerRadii viewRect:self.bounds];
}

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param cornerRadii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param viewRect    需要设置的圆角view的rect
 */
- (void)yl_addRoundedCorners:(UIRectCorner)corners
                 cornerRadii:(CGSize)cornerRadii
                    viewRect:(CGRect)viewRect {
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:viewRect byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer* shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = viewRect;
    [shapeLayer setPath:rounded.CGPath];
    self.layer.mask = shapeLayer;
}

- (void)yl_addLayerRoundedCorners:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)yl_addLayerRoundedCorners:(CGFloat)cornerRadius
                      borderWidth:(UIRectCorner)borderWidth
                      borderColor:(UIColor *)borderColor {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
}



#pragma mark - Frame
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


- (CGFloat)yl_right{
    return self.frame.origin.x+self.frame.size.width;
}

-(void)setYl_right:(CGFloat)yl_right{
    CGRect frame = self.frame;
    frame.origin.x = yl_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)yl_bottom{
    return self.frame.origin.y+self.frame.size.height;
}

-(void)setYl_bottom:(CGFloat)yl_bottom{
    CGRect frame = self.frame;
    frame.origin.y = yl_bottom - frame.size.height;
    self.frame = frame;
}
@end
