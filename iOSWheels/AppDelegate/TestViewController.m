//
//  TestViewController.m
//  iOSWheels
//
//  Created by liyan on 2018/4/2.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "TestViewController.h"
#import "NSTimer+MTExtension.h"

@interface TestViewController (){
    NSTimer *_timer;
}

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _timer = [NSTimer mt_scheduledTimerWithTimeInterval:2 count:5 callback:^(NSTimer *timer) {
        NSLog(@"回调次数");
    }];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
