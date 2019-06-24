//
//  YLWeakScriptMessageDelegate.h
//  YLCommonKit
//
//  Created by zjmac on 2019/6/24.
//  Copyright © 2019 xyanl. All rights reserved.
//
//  解决WKWebView不释放问题的桥接文件
#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface YLWeakScriptMessageDelegate : NSObject
@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

NS_ASSUME_NONNULL_END
