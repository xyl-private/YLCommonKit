//
//  UITableView+YLTableHeaderView.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UITableViewDelegate_HeaderViewSelection <UITableViewDelegate>

/**
 tableHeaderView 点击事件回调
 
 @param tableView tableView description
 @param headerView headerView description
 @param section section description
 @param isSelected YES 当前 headerView 被选中, NO 当前 取消选中状态
 */
- (void)yl_tableView:(UITableView *)tableView didSelectHeaderView:(UIView *)headerView inSection:(NSInteger)section isSelected:(BOOL)isSelected;

@end

@interface UITableView (YLTableHeaderView)

- (void)yl_headerView:(UIView *)headerView forSeciton:(NSInteger)section;

@end
