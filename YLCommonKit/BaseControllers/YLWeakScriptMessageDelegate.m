//
//  YLWeakScriptMessageDelegate.m
//  YLCommonKit
//
//  Created by zjmac on 2019/6/24.
//  Copyright © 2019 xyanl. All rights reserved.
//

#import "YLWeakScriptMessageDelegate.h"

@implementation YLWeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate
{
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end
