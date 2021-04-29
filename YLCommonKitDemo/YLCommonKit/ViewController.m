//
//  ViewController.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/9.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)BaseViewControllerAction:(id)sender {
    TestViewController *vc = [TestViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
