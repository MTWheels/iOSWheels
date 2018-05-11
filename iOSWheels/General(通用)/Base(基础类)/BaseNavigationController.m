//
//  BaseNavigationController.m
//  iOSWheels
//
//  Created by liyan on 2018/5/3.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

/// 导航栏分隔线
@property (nonatomic , weak , readwrite) UIImageView * navigationBottomLine;

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setup];
}


#pragma mark - 初始化
- (void) _setup
{
    [self _setupNavigationBarBottomLine];
}

// 查询最后一条数据
- (UIImageView *)_findHairlineImageViewUnder:(UIView *)view{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews){
        UIImageView *imageView = [self _findHairlineImageViewUnder:subview];
        if (imageView){ return imageView; }
    }
    return nil;
}

#pragma mark - 设置导航栏的分割线
- (void)_setupNavigationBarBottomLine{
    //!!!:这里之前设置系统的 navigationBarBottomLine.image = xxx;无效 Why？ 隐藏了系统的 自己添加了一个分割线
    // 隐藏系统的导航栏分割线
    UIImageView *navigationBarBottomLine = [self _findHairlineImageViewUnder:self.navigationBar];
    navigationBarBottomLine.hidden = YES;
//    // 添加自己的分割线
//    CGFloat navSystemLineH = .5f;
//    UIImageView *navSystemLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationBar.frame.size.height - navSystemLineH, MH_SCREEN_WIDTH, navSystemLineH)];
//    navSystemLine.backgroundColor = MHColor(223.0f, 223.0f, 221.0f);
//    [self.navigationBar addSubview:navSystemLine];
//    self.navigationBottomLine = navSystemLine;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
