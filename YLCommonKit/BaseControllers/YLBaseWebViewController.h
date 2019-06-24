//
//  YLBaseWebViewController.h
//  YLCommonKit
//
//  Created by zjmac on 2019/6/24.
//  Copyright © 2019 xyanl. All rights reserved.
//

#import "YLBaseViewController.h"
#import <WebKit/WebKit.h>
#import "YLWeakScriptMessageDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLBaseWebViewController : YLBaseViewController
<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>
/** 网页 */
@property (nonatomic, weak, readonly) WKWebView *webView;
/** 进度条 */
@property (nonatomic, weak, readonly) UIProgressView *progressView;
/** 是否自动获取标题 默认：YES */
@property (nonatomic, assign, getter=isKVOTitle) BOOL KVOTitle;
/** 返回 */
@property (nonatomic, assign, readonly, getter=isCanGoBack) BOOL canGoBack;

/**
 * web返回事件
 */
- (void)yl_popWebVC;
/**
 * 清除缓存
 */
- (void)yl_cleanWebViewCache;

@end

NS_ASSUME_NONNULL_END
