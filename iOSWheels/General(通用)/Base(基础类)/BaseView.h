//
//  BaseView.h
//  iOSWheels
//
//  Created by liyan on 2018/5/3.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseViewModel;
@interface BaseView : UIView

- (instancetype)initWithViewModel:(BaseViewModel *)viewModel;

- (void)mt_bindViewModel;

- (void)mt_setupViews;


@end
