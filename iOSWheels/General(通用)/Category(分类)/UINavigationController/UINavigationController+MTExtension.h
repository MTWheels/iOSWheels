//
//  UINavigationController+MTExtension.h
//  iOSWheels
//
//  Created by liyan on 2018/4/2.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (MTExtension)

/** 寻找Navigation中的某个viewcontroler */
- (UIViewController *)mt_findViewController:(Class)className;


/** 判断是否只有一个RootViewController */
- (BOOL)mt_isOnlyContainRootViewController;


/** 返回指定的viewcontroler */
- (NSArray *)mt_popToViewControllerWithClassName:(Class)className animated:(BOOL)animated;


/** pop回第n层 */
- (NSArray *)mt_popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated;


///以某种动画形式push
- (void)mt_pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition;

///以某种动画形式pop
- (UIViewController *)mt_popViewControllerWithTransition:(UIViewAnimationTransition)transition;



@end
