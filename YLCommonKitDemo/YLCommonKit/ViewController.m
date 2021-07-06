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
    TestViewController *vc = [TestViewController new];
    vc.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
