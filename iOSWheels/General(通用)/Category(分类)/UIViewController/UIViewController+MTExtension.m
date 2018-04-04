//
//  UIViewController+MTExtension.m
//  iOSWheels
//
//  Created by liyan on 2018/4/2.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "UIViewController+MTExtension.h"

@implementation UIViewController (MTExtension)

/**  找到当前试图控制器 */
+ (UIViewController *)mt_currentViewController {
    
    UIViewController *viewController = [[UIApplication sharedApplication].delegate window].rootViewController;
    return [self findBestViewController:viewController];
}









#pragma mark --- private API

//遍历查找当前视图控制器
+ (UIViewController *)findBestViewController:(UIViewController *)vc
{
    if (vc.presentedViewController) {
        
        return [self findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0) {
            return [self findBestViewController:svc.topViewController];
        } else {
            return vc;
        }
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController* svc = (UITabBarController *)vc;
        if (svc.viewControllers.count > 0) {
            return [self findBestViewController:svc.selectedViewController];
        } else {
            return vc;
        }
        
    } else {
        return vc;
    }
}


@end
