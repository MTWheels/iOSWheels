//
//  ViewController.m
//  iOSWheels
//
//  Created by 方新俊 on 2018/3/29.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()
- (IBAction)ClickEvent:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)ClickEvent:(id)sender {
    TestViewController *testVC = [[TestViewController alloc] init];
    [self.navigationController pushViewController:testVC animated:YES];
}
@end
