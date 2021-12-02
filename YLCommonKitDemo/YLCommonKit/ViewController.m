//
//  ViewController.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/9.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "YLCommonKitHeader.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yl_randomColor];
    
}

- (IBAction)BaseViewControllerAction:(UIButton *)sender {
    
    NSLog(@"timeIntervalSinceNow %f",[[NSDate date] timeIntervalSinceNow]);
    NSLog(@"timeIntervalSince1970 %f",[[NSDate date] timeIntervalSince1970]);
    [self getNowTimeTimestamp3];
}

//获取当前时间戳  （以毫秒为单位）

-(NSString *)getNowTimeTimestamp3{
   NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

   NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];

   return timeSp;

}
@end
