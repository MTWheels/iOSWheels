//
//  HomeViewModel.m
//  iOSWheels
//
//  Created by liyan on 2018/5/3.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel


- (void)initialize {
    //订阅成功数据
  
    [[self.refreshDataCommand.executionSignals.switchToLatest doNext:^(id x) {
        NSLog(@"don.................");
        
    }] subscribeNext:^(MTHTTPResponse *result) {
        
        NSLog(@"refreshDataCommand == %@",result);
    }];
    
    //加载数据网络请求失败
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeError:^(NSError *error) {
        NSLog(@"error == %@",error);
    }];
    
    
    //订阅加载更多数据
    [self.nextPageCommand.executionSignals.switchToLatest subscribeNext:^(MTHTTPResponse *result) {
        NSLog(@"nextPageCommand == %@",result);
    }];
    
    
    //加载更多网络请求失败
    [self.nextPageCommand.executionSignals.switchToLatest subscribeError:^(NSError *error) {
        NSLog(@"nexterror == %@",error);
    }];
    
    
    

    
}





#pragma mark --- getters and setters
- (RACCommand *)refreshDataCommand {
    if (!_refreshDataCommand) {
        @weakify(self)
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            self.currentPage = 1;
            NSString *urlPath = RequestWebsite(@"api/banner/api_get_front_banner_info_list/index");
            NSDictionary *dict = @{@"login_user_id":@"1258",
                                   @"category_id":@(2),
                                   @"page":@(self.currentPage)};
            return [MTNetworkHelper rac_POST:urlPath parameters:dict];
        }];
    }
    return _refreshDataCommand;
}




- (RACCommand *)nextPageCommand {
    if (!_nextPageCommand) {
        @weakify(self)
        _nextPageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            
            self.currentPage ++;
            NSString *urlPath = RequestWebsite(@"api/banner/api_get_front_banner_info_list/index");
            NSDictionary *dict = @{@"login_user_id":@"1258",
                                   @"category_id":@(2),
                                   @"page":@(self.currentPage)};
            return [MTNetworkHelper rac_POST:urlPath parameters:dict];
            
        }];
    }
    return _nextPageCommand;
}


@end
