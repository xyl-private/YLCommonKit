//
//  UIButton+YLButton.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "UIButton+YLButton.h"
#import "UIImage+YLImage.h"
#import <objc/runtime.h>

@implementation UIButton (YLButton)

- (UIEdgeInsets)touchAreaInsets {
    return [objc_getAssociatedObject(self, @selector(touchAreaInsets)) UIEdgeInsetsValue];
}

- (void)setTouchAreaInsets:(UIEdgeInsets)touchAreaInsets {
    objc_setAssociatedObject(self, @selector(touchAreaInsets), [NSValue valueWithUIEdgeInsets:touchAreaInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)enlargedRect{
    if (UIEdgeInsetsEqualToEdgeInsets(self.touchAreaInsets, UIEdgeInsetsZero)) {
        return self.bounds;
    }
    
    return CGRectMake(self.bounds.origin.x - self.touchAreaInsets.left, 
                      self.bounds.origin.y - self.touchAreaInsets.top, 
                      self.bounds.size.width + self.touchAreaInsets.left + self.touchAreaInsets.right, 
                      self.bounds.size.height + self.touchAreaInsets.top + self.touchAreaInsets.bottom);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.alpha <= 0.01 || !self.userInteractionEnabled || self.hidden) {
        return nil;
    }
    
    CGRect rect = [self enlargedRect];    
    return CGRectContainsPoint(rect, point) ? self : nil;
}

/// 设置按钮图片和文字的相对位置及间距
/// - Parameters:
///   - position: 图片相对于文字的位置
///   - spacing: 图片和文字之间的间距
- (void)yl_setImagePosition:(YLImagePosition)position spacing:(CGFloat)spacing {
    // 确保按钮有图片和文字
    if (!self.currentImage || !self.currentTitle) {
        NSLog(@"Warning: Button must have both image and title for position adjustment");
        return;
    }
    
    // 重置状态以确保获取正确的图片和文字
    [self setTitle:self.currentTitle forState:UIControlStateNormal];
    [self setImage:self.currentImage forState:UIControlStateNormal];
    
    // 获取图片和文字的尺寸
    CGSize imageSize = self.imageView.image.size;
    CGSize labelSize = [self.titleLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    
    // 计算偏移量
    CGFloat imageOffsetX = (imageSize.width + labelSize.width) / 2 - imageSize.width / 2;
    CGFloat imageOffsetY = imageSize.height / 2 + spacing / 2;
    CGFloat labelOffsetX = (imageSize.width + labelSize.width / 2) - (imageSize.width + labelSize.width) / 2;
    CGFloat labelOffsetY = labelSize.height / 2 + spacing / 2;
    
    // 计算内容尺寸调整
    CGFloat maxWidth = MAX(labelSize.width, imageSize.width);
    CGFloat changedWidth = labelSize.width + imageSize.width - maxWidth;
    CGFloat maxHeight = MAX(labelSize.height, imageSize.height);
    CGFloat changedHeight = labelSize.height + imageSize.height + spacing - maxHeight;
    
    // 根据位置设置不同的边距
    switch (position) {
        case YLImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case YLImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelSize.width + spacing/2, 0, -(labelSize.width + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + spacing/2), 0, imageSize.width + spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case YLImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
            break;
            
        case YLImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            break;
    }
    
    // 强制布局更新
    [self layoutIfNeeded];
}

/// 设置按钮的背景色
/// - Parameters:
///   - backgroundColor: 背景色
///   - state: 状态
- (void)yl_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIImage yl_imageWithColor:backgroundColor] forState:state];
}

@end
