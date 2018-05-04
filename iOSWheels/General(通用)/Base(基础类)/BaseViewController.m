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


+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    BaseViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController mt_addSubviews];
        [viewController mt_bindViewModel];
    }];
    
    return viewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}



#pragma mark - RAC
/**
 *  添加控件
 */
- (void)mt_addSubviews {}

/**
 *  绑定
 */
- (void)mt_bindViewModel {}



#pragma mark  ------- 用来检查 当前试图控制器内存是否被释放 ------
- (void)dealloc{
    NSLog(@"✅dealloc  %@  '%@'",self.class, NSStringFromSelector(_cmd));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
