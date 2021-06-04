//
//  MTRedBookAnimation.m
//  iOSWheels
//
//  Created by liyan on 2018/5/15.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "MTRedBookAnimation.h"
#import "MTTransitionProtocol.h"
#import "UIView+MTExtension.h"

@interface MTRedBookAnimation()

///缩放比例
@property (nonatomic, assign) CGFloat animationScale;


@end

@implementation MTRedBookAnimation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.animationDuration = 0.5f;
    }
    return self;
}


///转场动画过渡时间
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.animationDuration;
}



- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    [self pushAnimateTransition:transitionContext];
}





#pragma mark ————— push —————
- (void)pushAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //获取跳转的Controller和目标Controller
    UIViewController<MTTransitionProtocol> * fromVC = (UIViewController <MTTransitionProtocol> * )[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController<MTTransitionProtocol> * toVC = (UIViewController <MTTransitionProtocol> * )[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //from和to的两个视图
    __block UIView * fromView = fromVC.view;
    __block UIView * toView = toVC.view;
    
    //container容器加入要显示的视图 不加入fromVC 返回的时候就无法返回
    UIView * containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor whiteColor];
    
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    
    //转场动画的目标View
    UIView *fromCellView = [fromVC targetTransitionView];
    UIView *toCellView = [toVC targetTransitionView];
    
    //获取cell相对左上角坐标 计算相对坐标
//    CGPoint nowViewPoint = [fromCellView convertPoint:CGPointZero toView:nil];
//
//    //获取当前view相对窗口坐标
//    CGPoint toViewPoint = [toCellView convertPoint:CGPointZero toView:nil];
    toView.hidden = YES;
    
    
    //复制一个Cell用于显示动画效果
    __block UIImageView * snapShot =[[UIImageView alloc] initWithImage:[fromCellView mt_snapshotImage]];
    snapShot.backgroundColor = [UIColor clearColor];
    [containerView addSubview:snapShot];
    //计算缩放比例
    _animationScale = MAX([toVC targetTransitionView].mj_w, snapShot.mj_w) / MIN([toVC targetTransitionView].mj_w, snapShot.mj_w);
    CGRect originFrame = fromCellView.frame;
    snapShot.frame = originFrame;
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        //设置缩放变换 x,y分别放大多少倍
        snapShot.transform =  CGAffineTransformMakeScale(self.animationScale,self.animationScale);
        snapShot.frame = toCellView.frame;
        
        fromView.alpha = 0;
        fromView.transform = snapShot.transform;
//        fromView.frame = CGRectMake(-(nowViewPoint.x)*self.animationScale,
//                                    -(nowViewPoint.y)*self.animationScale + toViewPoint.y,
//                                    fromVC.view.frame.size.width,
//                                    fromVC.view.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            //没有这句过滤动画就不会结束
            [snapShot removeFromSuperview];
            toView.hidden = NO;
            fromView.alpha = 1;
            fromVC.view.transform = CGAffineTransformIdentity;
            fromVC.view.frame = originFrame;
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }
    }];
    
}











@end
