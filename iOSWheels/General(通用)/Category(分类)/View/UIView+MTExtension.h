//
//  UIView+MTExtension.h
//  iOSWheelBags
//
//  Created by liyan on 2018/3/29.
//  Copyright © 2018年 liyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MTExtension)


@property (assign, nonatomic) CGFloat mt_x;
@property (assign, nonatomic) CGFloat mt_y;
@property (assign, nonatomic) CGFloat mt_w;
@property (assign, nonatomic) CGFloat mt_h;
@property (assign, nonatomic) CGSize mt_size;
@property (assign, nonatomic) CGPoint mt_origin;



/**
    移除所有子视图
 */
- (void) mt_removeAllSubviews;


/**
 获取当前view所添加的视图控制器
 */
- (UIViewController *)mt_viewController;



/**
 * xib创建的view
 */
+ (instancetype)mt_viewFromXib;



@end
