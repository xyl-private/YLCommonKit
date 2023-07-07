//
//  NSObject+YLGCD.m
//  YLCommonKit
//
//  Created by xyanl on 2023/7/7.
//  Copyright © 2023 xyanl. All rights reserved.
//

#import "NSObject+YLGCD.h"

@implementation NSObject (YLGCD)

- (void)yl_afterSecond:(NSTimeInterval)afterSecond complete:(XComplete)complete{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, afterSecond * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), complete);
}


@end
