//
//  ViewController.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/9.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "ViewController.h"
#import "NSDate+YLDate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate * date = [NSDate yl_datePeriodOfDateFromCurrentDateWithComponentsType:YLDateComponentsTypeHour periodLength:2];
    NSString * dateStr = [NSDate yl_stringFromDate:date DateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"%@",dateStr);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
