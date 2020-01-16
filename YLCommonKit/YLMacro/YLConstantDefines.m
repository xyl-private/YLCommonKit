//
//  YLConstantDefines.m
//  YLCommonKit
//
//  Created by zjmac on 2019/6/23.
//  Copyright © 2019 xyanl. All rights reserved.
//
#import "YLConstantDefines.h"

const CGFloat YLResultCode = 404;

NSString *const YLAppName = @"拼单";

NSString * NSStringFromYLBrandType(YLBrandType type) {
    switch (type) {
        case YLBrandTypeAll://：单板商城
            return @"all";
        case YLBrandTypePopular://：流行品牌
            return @"popular";
        case YLBrandTypePersonality:// ：个性品牌
            return @"personality";
        default:
            return @"";
    }
}
