//
//  ViewController.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/9.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "ViewController.h"
#import "NSString+YLString.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * str = [NSString yl_deleteFloatAllZeroWith:@"10.10"];
    NSLog(@"%@",str);
    
}
- (IBAction)BaseViewControllerAction:(id)sender {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
