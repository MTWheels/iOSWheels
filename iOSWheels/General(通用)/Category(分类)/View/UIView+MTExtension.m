//
//  UIView+MTExtension.m
//  iOSWheelBags
//
//  Created by liyan on 2018/3/29.
//  Copyright © 2018年 liyan. All rights reserved.
//

#import "UIView+MTExtension.h"

@implementation UIView (MTExtension)

#pragma mark ----- 坐标获取 快捷方式 ---------
- (void)setMt_x:(CGFloat)mt_x {
    CGRect frame = self.frame;
    frame.origin.x = mt_x;
    self.frame = frame;
}

- (CGFloat)mt_x {
    return self.frame.origin.x;
}

- (void)setMt_y:(CGFloat)mt_y {
    CGRect frame = self.frame;
    frame.origin.y = mt_y;
    self.frame = frame;
}

- (CGFloat)mt_y {
    return self.frame.origin.y;
}

- (void)setMt_w:(CGFloat)mt_w {
    CGRect frame = self.frame;
    frame.size.width = mt_w;
    self.frame = frame;
}

- (CGFloat)mt_w {
    return self.frame.size.width;
}

- (void)setMt_h:(CGFloat)mt_h {
    CGRect frame = self.frame;
    frame.size.height = mt_h;
    self.frame = frame;
}

- (CGFloat)mt_h {
    return self.frame.size.height;
}

- (void)setMt_size:(CGSize)mt_size {
    CGRect frame = self.frame;
    frame.size = mt_size;
    self.frame = frame;
}

- (CGSize)mt_size {
    return self.frame.size;
}

- (void)setMt_origin:(CGPoint)mt_origin {
    CGRect frame = self.frame;
    frame.origin = mt_origin;
    self.frame = frame;
}

- (CGPoint)mt_origin {
    return self.frame.origin;
}



#pragma mark ---- UIView 方法扩展 ---------
/**
    移除所有子视图
 */
- (void) mt_removeAllSubviews {
    
    while (self.subviews.count) {
        UIView *childV = self.subviews.lastObject;
        [childV removeFromSuperview];
    }
}



/**
    获取当前view所添加的视图控制器
 */
- (UIViewController *)mt_viewController {
    
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        
        responder = [responder nextResponder];
    }
    return nil;
}

@end
