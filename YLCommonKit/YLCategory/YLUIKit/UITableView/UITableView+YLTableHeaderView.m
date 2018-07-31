//
//  UITableView+YLTableHeaderView.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "UITableView+YLTableHeaderView.h"
#import <objc/runtime.h>

@implementation UITableView (YLTableHeaderView)

- (void) yl_headerView:(UIView *)headerView forSeciton:(NSInteger)section {
    //add tapGesture to the headerView so it can be selected.
    [headerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeaderView:)]];
    //insert the headerView to an array
    [self.headerViews replaceObjectAtIndex:section withObject:headerView];
}

- (void)tapHeaderView:(UITapGestureRecognizer *)sender {
    UIView *headerView = sender.view;
    NSInteger section = [self.headerViews indexOfObject:headerView];
    //callback method depends on the headerView's selection.
    BOOL isSelected = ![self.selections[section] boolValue];
    [self.selections replaceObjectAtIndex:section withObject:@(isSelected)];
    if ([(id <UITableViewDelegate_HeaderViewSelection>)self.delegate respondsToSelector:@selector(yl_tableView:didSelectHeaderView:inSection:isSelected:)]) {
        [(id <UITableViewDelegate_HeaderViewSelection>)self.delegate yl_tableView:self didSelectHeaderView:headerView inSection:section isSelected:isSelected];
    }
}

- (BOOL)headerViewSelectedInSection:(NSInteger)section {
    return [self.selections[section] boolValue];
}

// category property to save the headerViews and selections
- (NSMutableArray *)headerViews {
    NSMutableArray *headerViews = objc_getAssociatedObject(self, "HeaderViews");
    if (!headerViews) {
        headerViews = [NSMutableArray array];
        for (int i = 0; i < [self numberOfSections]; i++) {
            [headerViews addObject:[UIView new]];
        }
        objc_setAssociatedObject(self, "HeaderViews", headerViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } return headerViews;
}

- (NSMutableArray *)selections {
    NSMutableArray *selections = objc_getAssociatedObject(self, "Selections");
    if (!selections) {
        selections = [NSMutableArray array];
        for (int i = 0; i < [self numberOfSections]; i++) {
            [selections addObject:@(NO)];
        }
        objc_setAssociatedObject(self, "Selections", selections, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } return selections;
}

@end
