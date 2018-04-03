//
//  NSString+MTFileManager.m
//  iOSWheels
//
//  Created by liyan on 2018/4/3.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "NSString+MTFileManager.h"

@implementation NSString (MTFileManager)

#pragma mark ---  获取 Documents 根文件夹
+ (NSString *)mt_documentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}



#pragma mark --- 获取 Library 根路径
+ (NSString *)mt_libraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES)firstObject];
}



#pragma mark --- 获取 Library/Caches 根文件夹
+ (NSString *)mt_cachesPath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) lastObject];
}



#pragma mark -- 获取 Library/Preferences 根文件夹
+ (NSString *)mt_preferencesPath {
    return [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                 NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Preferences"];
    
}




#pragma mark -- 获取 tmp 根路径
+ (NSString *)mt_tmpPath {
    return NSTemporaryDirectory();
}



@end
