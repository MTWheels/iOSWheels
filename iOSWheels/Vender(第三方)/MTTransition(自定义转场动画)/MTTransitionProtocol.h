//
//  MTTransitionProtocol.h
//  iOSWheels
//
//  Created by liyan on 2018/5/15.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MTTransitionProtocol <NSObject>
@optional
/**
 转场动画的目标View 需要转场动画的对象必须实现该方法并返回要做动画的View
 
 @return view
 */
-(UIView *)targetTransitionView;

@end
