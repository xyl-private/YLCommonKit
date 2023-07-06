//
//  UIView+YLFrame.h
//  YLCommonKit
//
//  Created by xyanl on 2023/7/6.
//  Copyright © 2023 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YLFrame)

/// x
@property (nonatomic, assign) CGFloat yl_x;
/// y
@property (nonatomic, assign) CGFloat yl_y;
/// 宽度
@property (nonatomic, assign) CGFloat yl_width;
/// 高度
@property (nonatomic, assign) CGFloat yl_height;
/// centerX
@property (nonatomic, assign) CGFloat yl_centerX;
/// centerY
@property (nonatomic, assign) CGFloat yl_centerY;
/// size
@property (nonatomic, assign) CGSize  yl_size;
/// point
@property (nonatomic, assign) CGPoint yl_origin;
/// right
@property (nonatomic, assign) CGFloat yl_right;
/// bottom
@property (nonatomic, assign) CGFloat yl_bottom;

@end

NS_ASSUME_NONNULL_END
