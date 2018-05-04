//
//  HomeViewModel.m
//  iOSWheels
//
//  Created by liyan on 2018/5/3.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

- (void)mt_bindRAC {
    //订阅成功数据
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"success == %@",x);
    }];
    
    //加载数据网络请求失败
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeError:^(NSError *error) {
        NSLog(@"error == %@",error);
    }];
    
    
    //订阅加载更多数据
    [self.nextPageCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        
    }];
    
    
    //加载更多网络请求失败
    [self.nextPageCommand.executionSignals.switchToLatest subscribeError:^(NSError *error) {
        
    }];
    
    //异步执行
    [self.refreshDataCommand execute:nil];

    
}





#pragma mark --- getters and setters
- (RACCommand *)refreshDataCommand {
    if (!_refreshDataCommand) {
        @weakify(self)
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
          @strongify(self)
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                self.currentPage = 1;
                [MTNetworkHelper POST:@"https://101.200.75.215:90/api/banner/api_get_front_banner_info_list/index" parameters:@{@"login_user_id":@"1258",@"category_id":@(2),@"page":@(self.currentPage)} success:^(id responseObject) {
                    
                    [subscriber sendNext:responseObject];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    [subscriber sendError:error];
                    [subscriber sendCompleted];
                }];
                
                return nil;
            }];
            
        }];
    }
    return _refreshDataCommand;
}



- (RACCommand *)nextPageCommand {
    if (!_nextPageCommand) {
        @weakify(self)
        _nextPageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                self.currentPage ++;
                [MTNetworkHelper POST:@"https://101.200.75.215:90/api/banner/api_get_front_banner_info_list/index" parameters:@{@"login_user_id":@"1258",@"category_id":@(2),@"page":@(self.currentPage)} success:^(id responseObject) {
                    
                    [subscriber sendNext:responseObject];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    @strongify(self);
                    self.currentPage --;
                    [subscriber sendError:error];
                    [subscriber sendCompleted];
                }];
                
                return nil;
            }];
            
        }];
    }
    return _nextPageCommand;
}


@end
