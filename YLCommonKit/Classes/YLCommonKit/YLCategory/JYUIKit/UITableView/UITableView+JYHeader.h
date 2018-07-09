//
//  UITableView+JYHeader.h
//  LoanInternal
//
//  Created by xyanl on 2018/4/23.
//  Copyright © 2018年 xyanl. All rights reserved.
//
//  tableHeaderView 点击事件
#import <UIKit/UIKit.h>
@protocol UITableViewDelegate_HeaderViewSelection <UITableViewDelegate>


/**
 tableHeaderView 点击事件回调

 @param tableView tableView description
 @param headerView headerView description
 @param section section description
 @param isSelected YES 当前 headerView 被选中, NO 当前 取消选中状态
 */
- (void)tableView:(UITableView *)tableView didSelectHeaderView:(UIView *)headerView inSection:(NSInteger)section isSelected:(BOOL)isSelected;

@end

@interface UITableView (JYHeader)
- (void)headerView:(UIView *)headerView forSeciton:(NSInteger)section;
@end
