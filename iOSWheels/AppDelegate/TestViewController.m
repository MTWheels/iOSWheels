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
    // Do any additional setup after loading the view.
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
