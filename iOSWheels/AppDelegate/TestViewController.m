//
//  TestViewController.m
//  iOSWheels
//
//  Created by liyan on 2018/4/2.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "TestViewController.h"
#import "NSTimer+MTExtension.h"
#import "UIButton+ChainStyle.h"

@interface TestViewController (){
    NSTimer *_timer;
}

@property (nonatomic, strong) UIView *redView;

/**/
@property (nonatomic, strong) UIButton *btn;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _timer = [NSTimer mt_scheduledTimerWithTimeInterval:2 count:5 callback:^(NSTimer *timer) {
        NSLog(@"回调次数");
    }];
    
    [self.view addSubview:self.btn];
    
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 400, kScreenWith, 200)];
    view1.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view1];
    
    
}


- (UIButton *)btn {
    if (!_btn) {
        _btn = Button
        .btnColor([UIColor redColor])
        .btnTitle(@"button")
        .btnFrame(0, 0, kScreenWith, 400)
        .btnFont([UIFont systemFontOfSize:35])
        .btnNormalImage(nil);
        _btn.backgroundColor = [UIColor redColor];
    }
    return _btn;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}


- (UIView *)targetTransitionView {
    return self.btn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
