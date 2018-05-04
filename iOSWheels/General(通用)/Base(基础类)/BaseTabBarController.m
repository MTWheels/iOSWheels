//
//  BaseTabBarController.m
//  iOSWheels
//
//  Created by liyan on 2018/5/3.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "MineViewController.h"



@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarItems];
}




#pragma mark -------------设置TabBar控制的各个视图控制器-------------------
-(void)setTabBarItems{
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self addChildViewController:homeVC title:@"首页" image:@"py_tabbar_home1" selectedImage:@"py_tabbar_home_selected1"];
    
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    [self addChildViewController:mineVC title:@"我的" image:@"py_tabbar_mine1" selectedImage:@"py_tabbar_mine_selected1"];
    
    
}





#pragma mark 添加子控制器的方法
- (void)addChildViewController:(UIViewController *)childVc
                         title:(NSString*)title
                         image:(NSString*)image
                 selectedImage:(NSString*)selectedImage {
    
    // 始终绘制图片原始状态，不使用Tint Color,系统默认使用了Tint Color（灰色）
    [childVc.tabBarItem setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [childVc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    childVc.tabBarItem.title = title;
    childVc.title = title;
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
