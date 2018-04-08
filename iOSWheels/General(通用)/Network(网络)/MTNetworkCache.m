//
//  MTNetworkCache.m
//  iOSWheels
//
//  Created by liyan on 2018/4/6.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "MTNetworkCache.h"

static NSString *const kMTNetworkResponseCache = @"kMTNetworkResponseCache";


@implementation MTNetworkCache

static YYCache *_dataCache;
+ (void)initialize {
    _dataCache = [YYCache cacheWithName:kMTNetworkResponseCache];
}


+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}


+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}


+ (NSInteger)getAllHttpCacheSize {
    return [_dataCache.diskCache totalCost];
}

+ (void)removeAllHttpCache {
    [_dataCache.diskCache removeAllObjects];
}




+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    if(!parameters || parameters.count == 0){return URL;};
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@%@",URL,paraString];
}


@end
