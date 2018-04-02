//
//  UINavigationController+MTExtension.m
//  iOSWheels
//
//  Created by liyan on 2018/4/2.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "UINavigationController+MTExtension.h"

@implementation UINavigationController (MTExtension)


/** 寻找Navigation中的某个viewcontroler */
- (UIViewController *)mt_findViewController:(Class)className {
    
    for (UIViewController *vc in self.viewControllers) {
        if ([vc isKindOfClass:className]) {
            return vc;
        }
    }
    
    return nil;
    
}



/** 判断是否只有一个RootViewController */
- (BOOL)mt_isOnlyContainRootViewController {
    return self.viewControllers.count == 1 ;
}




/** 返回指定的viewcontroler */
- (NSArray *)mt_popToViewControllerWithClassName:(Class)className animated:(BOOL)animated {
    return [self popToViewController:[self mt_findViewController:className] animated:animated];
}


/** pop回第n层 */
- (NSArray *)mt_popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated {
    
    NSInteger viewControllersCount = self.viewControllers.count;
    if (viewControllersCount > level) {
        NSInteger idx = viewControllersCount - level - 1;
        UIViewController *viewController = self.viewControllers[idx];
        return [self popToViewController:viewController animated:animated];
    } else {
        return [self popToRootViewControllerAnimated:animated];
    }
}




///以某种动画形式push
- (void)mt_pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition {
    [UIView beginAnimations:nil context:NULL];
    [self pushViewController:controller animated:NO];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
}

///以某种动画形式pop
- (UIViewController *)mt_popViewControllerWithTransition:(UIViewAnimationTransition)transition {
    [UIView beginAnimations:nil context:NULL];
    UIViewController *controller = [self popViewControllerAnimated:NO];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
    return controller;
}




@end
