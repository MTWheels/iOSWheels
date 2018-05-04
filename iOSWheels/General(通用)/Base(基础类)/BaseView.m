//
//  BaseView.m
//  iOSWheels
//
//  Created by liyan on 2018/5/3.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "BaseView.h"
#import "BaseViewModel.h"

@implementation BaseView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self mt_setupViews];
        [self mt_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(BaseViewModel *)viewModel {
    self = [super init];
    if (self) {

        [self mt_setupViews];
        [self mt_bindViewModel];
    }
    return self;
}

- (void)mt_bindViewModel {}

- (void)mt_setupViews {}


@end
