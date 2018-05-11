//
//  MTHTTPResponse.h
//  iOSWheels
//
//  Created by liyan on 2018/5/5.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTHTTPResponse : NSObject

/// 自己服务器返回的状态码 对应于服务器json数据的 errorCode
@property (nonatomic, assign) NSInteger errorCode;

/// 自己服务器返回的信息 对应于服务器json数据的 code
@property (nonatomic, copy) NSString *message;

/// 对应于服务器json数据的 data
@property (nonatomic, strong) id data;

@end
