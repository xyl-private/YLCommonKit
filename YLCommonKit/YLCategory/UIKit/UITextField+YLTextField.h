//
//  UITextField+YLTextField.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (YLTextField)

- (void)yl_selectAllText;

- (void)yl_setSelectedRange:(NSRange)range;

@end
