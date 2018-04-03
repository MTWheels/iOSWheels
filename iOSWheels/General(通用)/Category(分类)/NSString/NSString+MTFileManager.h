//
//  NSString+MTFileManager.h
//  iOSWheels
//
//  Created by liyan on 2018/4/3.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 应用程序沙盒目录下有三个文件夹Documents、Library（下面有Caches和Preferences目录）、tmp。
 
 Documents：保存应用运行时生成的需要持久化的数据iTunes会自动备份该目录。苹果建议将在应用程序中浏览到的文件数据保存在该目录下。
 Library/Caches：一般存储的是缓存文件，例如图片视频等，此目录下的文件不会再应用程序退出时删除，在手机备份的时候，iTunes不会备份该目录。
 Library/Preferences：保存应用程序的所有偏好设置iOS的Settings(设置)，我们不应该直接在这里创建文件，而是需要通过NSUserDefault这个类来访问应用程序的偏好设置。iTunes会自动备份该文件目录下的内容。
 tmp：临时文件目录，在程序重新运行的时候，和开机的时候，会清空tmp文件夹。
 
 */

@interface NSString (MTFileManager)


#pragma mark ---  获取 Documents 根文件夹
+ (NSString *)mt_documentPath;


#pragma mark --- 获取 Library 根路径
+ (NSString *)mt_libraryPath;


#pragma mark --- 获取 Library/Caches 根文件夹
+ (NSString *)mt_cachesPath;


#pragma mark -- 获取 Library/Preferences 根文件夹
+ (NSString *)mt_preferencesPath;


#pragma mark -- 获取 tmp 根路径
+ (NSString *)mt_tmpPath;



@end
