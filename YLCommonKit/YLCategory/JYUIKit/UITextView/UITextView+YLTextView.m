//
//  UITextView+YLTextView.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "UITextView+YLTextView.h"
#import <objc/runtime.h>

static const void * yl_placeHolderKey;

@interface UITextView ()

@property (nonatomic, readonly) UILabel * yl_placeHolderLabel;

@end

@implementation UITextView (YLTextView)

+(void)load{
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")),
                                   class_getInstanceMethod(self.class, @selector(ylPlaceHolder_swizzling_layoutSubviews)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(ylPlaceHolder_swizzled_dealloc)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setText:")),
                                   class_getInstanceMethod(self.class, @selector(ylPlaceHolder_swizzled_setText:)));
}

#pragma mark - swizzled

- (void) ylPlaceHolder_swizzled_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self ylPlaceHolder_swizzled_dealloc];
}

- (void) ylPlaceHolder_swizzling_layoutSubviews {
    if (self.yl_placeHolder) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat x = lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds) - x - textContainerInset.right - 2*self.layer.borderWidth;
        CGFloat height = [self.yl_placeHolderLabel sizeThatFits:CGSizeMake(width, 0)].height;
        self.yl_placeHolderLabel.frame = CGRectMake(x, y, width, height);
    }
    [self ylPlaceHolder_swizzling_layoutSubviews];
}

- (void) ylPlaceHolder_swizzled_setText:(NSString *)text{
    [self ylPlaceHolder_swizzled_setText:text];
    if (self.yl_placeHolder) {
        [self updatePlaceHolder];
    }
}
#pragma mark - associated
-(NSString *) yl_placeHolder{
    return objc_getAssociatedObject(self, &yl_placeHolderKey);
}

-(void)setYl_placeHolder:(NSString *) yl_placeHolder{
    objc_setAssociatedObject(self, &yl_placeHolderKey, yl_placeHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePlaceHolder];
}

-(UIColor *) yl_placeHolderColor{
    return self.yl_placeHolderLabel.textColor;
}

-(void)setYl_placeHolderColor:(UIColor *) yl_placeHolderColor{
    self.yl_placeHolderLabel.textColor = yl_placeHolderColor;
}

-(void)setPlaceholder:(NSString *)placeholder{
    self.yl_placeHolder = placeholder;
}
#pragma mark - update
- (void)updatePlaceHolder{
    if (self.text.length) {
        [self.yl_placeHolderLabel removeFromSuperview];
        return;
    }
    self.yl_placeHolderLabel.font = self.font?self.font:self.cacutDefaultFont;
    self.yl_placeHolderLabel.textAlignment = self.textAlignment;
    self.yl_placeHolderLabel.text = self.yl_placeHolder;
    [self insertSubview:self.yl_placeHolderLabel atIndex:0];
}
#pragma mark - lazzing
-(UILabel *) yl_placeHolderLabel{
    UILabel *placeHolderLab = objc_getAssociatedObject(self, @selector(yl_placeHolderLabel));
    if (!placeHolderLab) {
        placeHolderLab = [[UILabel alloc] init];
        placeHolderLab.numberOfLines = 0;
        placeHolderLab.textColor = [UIColor lightGrayColor];
        objc_setAssociatedObject(self, @selector(yl_placeHolderLabel), placeHolderLab, OBJC_ASSOCIATION_RETAIN);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlaceHolder) name:UITextViewTextDidChangeNotification object:self];
    }
    return placeHolderLab;
}

- (UIFont *)cacutDefaultFont{
    static UIFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextView *textview = [[UITextView alloc] init];
        textview.text = @" ";
        font = textview.font;
    });
    return font;
}
@end
