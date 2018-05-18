//
//  BaseViewModel.h
//  iOSWheels
//
//  Created by liyan on 2018/5/3.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseViewModel : NSObject

/*分页*/
@property (nonatomic, assign) NSInteger currentPage;
/*数据源*/
@property (nonatomic, strong) NSMutableArray *dataArray;



/// sub class can override
- (void)initialize;



@end
