//
//  BaseViewModel.m
//  iOSWheels
//
//  Created by liyan on 2018/5/3.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel


+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    BaseViewModel *viewModel = [super allocWithZone:zone];
    if (viewModel) {
        [viewModel initialize];
    }
    return viewModel;
}


/// sub class can override
- (void)initialize {}








#pragma mark --- getters and setters
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}






@end
