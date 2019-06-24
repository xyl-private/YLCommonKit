//
//  YLBaseWebViewController.m
//  YLCommonKit
//
//  Created by zjmac on 2019/6/24.
//  Copyright © 2019 xyanl. All rights reserved.
//

#import "YLBaseWebViewController.h"
#import "UIColor+YLColor.h"

@interface YLBaseWebViewController ()
/** 返回 */
@property (readwrite) BOOL canGoBack;
/** 前进 */
@property (nonatomic, assign, getter=isCanGoForward) BOOL canGoForward;

@end

static NSString * const kCustomUserAgent = @"iosH5App";
static NSString * const kEstimatedProgress = @"estimatedProgress";
static NSString * const kTitle = @"title";
static NSString * const kCanGoBack = @"canGoBack";
static NSString * const kCanGoForward = @"canGoForward";

@implementation YLBaseWebViewController
@synthesize webView = _webView;
@synthesize progressView = _progressView;

/**
 * web返回事件
 */
- (void)yl_popWebVC{
    // 退出控制器
    if (!self.canGoBack) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    // 返回后一页
    if (self.canGoBack) {
        [self.webView goBack];
        return;
    }
}
/**
 * 布局
 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.webView.frame = self.view.bounds;
    self.progressView.frame = CGRectMake(0, 0, self.webView.bounds.size.width, 0);
}
/**
 *  KVO
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:kEstimatedProgress]) {
        if (object == self.webView) {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            if(self.webView.estimatedProgress >= 1.0f) {
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else if ([keyPath isEqualToString:kTitle]) {
        if (object == self.webView) {
            if (self.isKVOTitle) {
                self.navigationItem.title = change[NSKeyValueChangeNewKey];
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else if ([keyPath isEqualToString:kCanGoBack]) {
        if (object == self.webView) {
            self.canGoBack = [change[NSKeyValueChangeNewKey] boolValue];
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else if ([keyPath isEqualToString:kCanGoForward]) {
        if (object == self.webView) {
            self.canGoForward = [change[NSKeyValueChangeNewKey] boolValue];
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //重要：由子类实现具体内容
}

#pragma mark - WKNavigationDelegate
// 对于HTTPS的都会触发此代理，如果不要求验证，传默认就行
// 如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler
{
    completionHandler(NSURLSessionAuthChallengeUseCredential, nil);
}
/**
 * web加载完成
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.canGoBack = webView.canGoBack;
    self.canGoForward = webView.canGoForward;
    // 友盟H5统计代码
    [webView evaluateJavaScript:@"setWebViewFlag()" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"errorUserInfo:%@", error.userInfo);
        } else {
            NSLog(@"response:%@",response);
        }
    }];
}
/**
 * web加载失败
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    if (error) {
        if (![error.userInfo[NSURLErrorFailingURLStringErrorKey] hasPrefix:@"tel"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网页加载失败,请重新尝试" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}
/**
 * web响应事件
 * 全局：处理拨打电话以及Url跳转等等
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"tel"]) {
        NSString *resourceSpecifier = [URL resourceSpecifier];
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", resourceSpecifier];
        /// 防止iOS 10及其之后，拨打电话系统弹出框延迟出现
        dispatch_async(dispatch_get_global_queue(kNilOptions, kNilOptions), ^{
            NSURL *url = [NSURL URLWithString:callPhone];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        });
    }
    // 友盟H5统计代码
    //    NSString *url = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    //    NSString *parameters = [url stringByRemovingPercentEncoding];
    //    [UMWKHybrid execute:parameters webView:webView];
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - WKUIDelegate
/**
 * web弹框
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"测试" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/**
 *  清除缓存
 */
- (void)yl_cleanWebViewCache
{
    if (@available(iOS 9.0, *)) {
        // All kinds of data
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{}];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
    } else {
        //先删除cookie
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies]) {
            [storage deleteCookie:cookie];
        }
        NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
        NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
        NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
        NSString *webKitFolderInCaches = [NSString stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
        [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
    }
}

#pragma mark - 懒加载
- (WKWebView *)webView
{
    if (_webView == nil) {
        //禁止选择 css 配置相关
        //        NSString*css = @"body{-webkit-user-select:none;-webkit-user-drag:none;}";
        //css 选中样式取消
        NSMutableString*javascript = [NSMutableString string];
        //        [javascript appendString:@"var style = document.createElement('style');"];
        //        [javascript appendString:@"style.type = 'text/css';"];
        //        [javascript appendFormat:@"var cssContent = document.createTextNode('%@');", css];
        //        [javascript appendString:@"style.appendChild(cssContent);"];
        //        [javascript appendString:@"document.body.appendChild(style);"];
        //        [javascript appendString:@"document.documentElement.style.webkitUserSelect='none';"];//禁止选择
        //        [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];//禁止长按
        //javascript 注入
        WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        //进行配置控制器
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        //实例化对象
        configuration.userContentController = [[WKUserContentController alloc] init];
        [configuration.userContentController addUserScript:noneSelectScript];
        // 创建webView
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        if (@available(iOS 9.0, *)) {
            webView.allowsLinkPreview = NO; // 禁止长按链接
            webView.customUserAgent = kCustomUserAgent;
            if (@available(iOS 11.0, *)) {
                webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
        webView.UIDelegate = self;
        webView.navigationDelegate = self;
        // KVO
        [webView addObserver:self forKeyPath:kEstimatedProgress options:NSKeyValueObservingOptionNew context:nil];
        [webView addObserver:self forKeyPath:kTitle options:NSKeyValueObservingOptionNew context:nil];
        [webView addObserver:self forKeyPath:kCanGoBack options:NSKeyValueObservingOptionNew context:nil];
        [webView addObserver:self forKeyPath:kCanGoForward options:NSKeyValueObservingOptionNew context:nil];
        // 是否自动获取标题
        self.KVOTitle = YES;
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}

- (UIProgressView *)progressView
{
    if (_progressView == nil) {
        UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        progressView.progressTintColor = [UIColor yl_colorWithHexString:@"43C01C"];
        [self.view addSubview:progressView];
        _progressView = progressView;
    }
    return _progressView;
}
/**
 *  控制器销毁
 */
- (void)dealloc
{
    NSLog(@"%@ ----- dealloc", [self class]);
    // 清除缓存
    [self yl_cleanWebViewCache];
    
    [self.progressView setAlpha:0.0f];
    [self.progressView removeFromSuperview];
    
    [self.webView removeObserver:self forKeyPath:kEstimatedProgress];
    [self.webView removeObserver:self forKeyPath:kTitle];
    [self.webView removeObserver:self forKeyPath:kCanGoBack];
    [self.webView removeObserver:self forKeyPath:kCanGoForward];
}

@end
