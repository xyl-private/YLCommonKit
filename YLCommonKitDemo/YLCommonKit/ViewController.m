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

#define kKeyWondow UIApplication.yl_keyWindow

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *clickBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yl_randomColor];
    
}

- (IBAction)BaseViewControllerAction:(UIButton *)sender {
    NSLog(@"%@", UIApplication.yl_keyWindow.rootViewController);
    TestViewController *vc = [TestViewController new];
    [(UINavigationController *)UIApplication.yl_keyWindow.rootViewController pushViewController:vc animated:YES];
    
    
}

@end
