//
//  BaseViewController.m
//  iOSWheels
//
//  Created by liyan on 2018/3/29.
//  Copyright © 2018年 liyan. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}



#pragma mark  ------- 用来检查 当前试图控制器内存是否被释放 ------
- (void)dealloc{
    NSLog(@"✅dealloc  %@  '%@'",self.class, NSStringFromSelector(_cmd));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
