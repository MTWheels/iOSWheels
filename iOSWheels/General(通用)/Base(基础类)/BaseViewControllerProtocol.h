//
//  BaseViewControllerProtocol.h
//  iOSWheels
//
//  Created by liyan on 2018/5/3.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseViewControllerProtocol <NSObject>


@optional

//绑定viewModel
- (void)mt_bindViewModel;
//添加控件
- (void)mt_addSubviews;


@end
