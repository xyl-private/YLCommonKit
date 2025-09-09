//
//  UIView+YLView.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "UIView+YLView.h"
#import <objc/runtime.h>

static char const * const YLKeyboardObserversKey = "YLKeyboardObserversKey";

@implementation UIView (YLView)

/**
 * 从与当前类同名的 xib 文件加载视图
 *
 * @return 新创建的视图实例，如果加载失败则返回 nil
 */
+ (instancetype)yl_viewFromNib {
    NSString *className = NSStringFromClass(self);
    NSBundle *bundle = [NSBundle bundleForClass:self];
    
    // 检查 xib 文件是否存在
    if (![bundle pathForResource:className ofType:@"nib"]) {
        NSLog(@"⚠️ Warning: Could not find nib file named '%@' in bundle", className);
        return nil;
    }
    
    // 安全加载 xib 文件
    NSArray *nibObjects = [bundle loadNibNamed:className owner:nil options:nil];
    if (nibObjects.count == 0) {
        NSLog(@"⚠️ Warning: Failed to load objects from nib file '%@'", className);
        return nil;
    }
    
    // 类型安全检查
    id view = nibObjects.lastObject;
    if (![view isKindOfClass:self]) {
        NSLog(@"⚠️ Warning: Expected class '%@' but got '%@' from nib file", NSStringFromClass(self), NSStringFromClass([view class]));
        return nil;
    }
    
    return view;
}

/**
 * 通过遍历响应者链，查找并返回当前视图所属的视图控制器。
 * 此方法利用UIResponder的nextResponder属性向上查找，直到找到UIViewController实例。
 *
 * @return 当前视图所属的视图控制器，如果未找到则返回nil。
 */
- (UIViewController *)yl_viewController {
    UIResponder *responder = self;
    while (responder != nil) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    }
    return nil;
}

- (void)yl_removeAllSubviews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

/// view 转换成 图片
- (UIImage*)yl_snapshotImage {
    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:self.bounds.size];
    return [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }];
}


#pragma mark - UIGestureRecognizer
/// 添加点击手势
- (UITapGestureRecognizer *)yl_addTapGestureWithTarget:(id)target action:(nullable SEL)selector {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tap];
    return tap;
}

/// 添加长按手势
- (UILongPressGestureRecognizer *)yl_addLongPressGestureWithTarget:(id)target action:(nullable SEL)selector {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:longPress];
    return longPress;
}

/// 添加拖拽手势
- (UIPanGestureRecognizer *)yl_addPanGestureWithTarget:(id)target action:(nullable SEL)selector {
    UIPanGestureRecognizer *panPress = [[UIPanGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:panPress];
    return panPress;
}


#pragma mark - 监听键盘

/**
 * @method yl_observeKeyboardOnChange:
 * @brief 注册一个键盘帧变化通知的观察者
 * @discussion 该方法通过监听系统发出的 `UIKeyboardWillChangeFrameNotification` 通知，
 *              在键盘的frame即将发生变化时（包括显示、隐藏、大小改变、位置改变等）执行回调。
 *              回调中提供了键盘最终的顶部Y坐标和高度信息，便于调用者调整UI布局，避免键盘遮挡。
 *              该方法内部会自动处理通知的注册、线程安全、动画同步及观察者的存储，确保与键盘动画同步更新UI。
 *              注意：返回的观察者对象必须被强引用持有，并在适当时机（如视图控制器销毁时）调用 `removeObserver:` 方法移除，以避免内存泄漏。
 *
 * @param changeHandler 当键盘帧变化时执行的回调块
 *                      - keyboardTop: 键盘最终的顶部Y坐标（在屏幕坐标系中）
 *                      - height: 键盘的最终高度
 * @return 注册的键盘通知观察者对象（类型为 `id`），需要由调用者管理其生命周期，或在不再需要时使用 `yl_removeKeyboardObserver:` 移除。
 * @warning 务必在视图控制器或持有该观察者的对象销毁前移除观察者，否则可能导致内存泄漏或不可预期的行为。
 */
- (id)yl_observeKeyboardOnChange:(void (^)(CGFloat keyboardTop, CGFloat height))changeHandler {
    // 确保在主线程执行：UI操作和通知回调必须在主线程进行，以避免潜在的线程安全问题。
    if (![NSThread isMainThread]) {
        __block id observer = nil;
        dispatch_sync(dispatch_get_main_queue(), ^{
            // 递归调用自身，但在主线程上下文中执行
            observer = [self yl_observeKeyboardOnChange:changeHandler];
        });
        return observer;
    }
    
    // 创建观察者：使用 `addObserverForName:object:queue:usingBlock:` 方法，可以更精细地控制通知的处理。
    __weak __typeof(self) weakSelf = self; // 使用弱引用避免循环引用
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue]; // 指定回调块在主队列执行
    
    // 注册观察者，监听键盘帧变化通知
    id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification
                                                                    object:nil // 监听所有对象发出的该通知
                                                                     queue:mainQueue
                                                                usingBlock:^(NSNotification * _Nonnull note) {
        // 在block内部使用强引用，防止在block执行过程中self被释放
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) return; // 如果self已被释放，则直接返回
        
        // 提取键盘信息：从通知的userInfo字典中获取键盘的最终frame、动画时长和动画曲线等详细信息。
        NSDictionary *userInfo = note.userInfo;
        CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]; // 键盘最终的frame
        NSTimeInterval animDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]; // 键盘动画的持续时间
        UIViewAnimationCurve animCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]; // 键盘动画的曲线类型
        // 将UIViewAnimationCurve转换为UIViewAnimationOptions（通过左移16位）
        UIViewAnimationOptions options = (animCurve << 16) | UIViewAnimationOptionBeginFromCurrentState;
        
        // 执行回调：将键盘的顶部Y坐标和高度信息传递给外部调用者，以便其调整UI布局。
        if (changeHandler) {
            changeHandler(endFrame.origin.y, endFrame.size.height);
        }
        
        // 同步键盘动画：使用从键盘通知中获取的动画参数（时长和曲线）来执行UIView动画，
        // 确保视图的布局更新与键盘的显示/隐藏动画同步进行，提供流畅的用户体验。
        [UIView animateWithDuration:animDuration
                              delay:0
                            options:options
                         animations:^{
            // 触发布局更新：通常在此回调中，外部已经根据键盘信息调整了Auto Layout约束，
            // 调用此方法会立即应用这些约束变化，并在动画块中产生平滑的动画效果。
            [strongSelf layoutIfNeeded];
        } completion:nil];
    }];
    
    // 存储观察者：将返回的观察者对象存储起来（例如，通过关联对象），便于后续统一管理（如移除）。
    [self yl_storeObserver:observer];
    
    return observer; // 返回观察者对象，调用者需负责在适当时机移除它
}

+ (void)yl_removeKeyboardObserver:(id)observer {
    if (observer) {
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }
}

- (void)yl_removeAllKeyboardObservers {
    NSMutableArray *observers = objc_getAssociatedObject(self, YLKeyboardObserversKey);
    if (observers) {
        for (id observer in observers) {
            [[NSNotificationCenter defaultCenter] removeObserver:observer];
        }
        [observers removeAllObjects];
    }
}

#pragma mark - Private Methods

- (void)yl_storeObserver:(id)observer {
    NSMutableArray *observers = objc_getAssociatedObject(self, YLKeyboardObserversKey);
    if (!observers) {
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, YLKeyboardObserversKey, observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [observers addObject:observer];
}

- (void)dealloc {
    [self yl_removeAllKeyboardObservers];
}



@end
