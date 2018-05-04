//
//  HomeViewModel.h
//  iOSWheels
//
//  Created by liyan on 2018/5/3.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "BaseViewModel.h"

@interface HomeViewModel : BaseViewModel

//刷新数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//加载更多
@property (nonatomic, strong) RACCommand *nextPageCommand;



@end
