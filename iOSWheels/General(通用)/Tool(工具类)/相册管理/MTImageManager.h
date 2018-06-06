//
//  MTImageManager.h
//  iOSWheels
//
//  Created by liyan on 2018/6/6.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MTImageManager : NSObject

///单例对象
+ (instancetype)manager;



/**
 Return YES if Authorized 返回YES如果得到了授权
 */
- (BOOL)authorizationStatusAuthorized;




/**
 保存图片到相册中。。。。。
 */
- (void)savePhotoWithImage:(UIImage *)image
                completion:(void (^)(NSError *error))completion;




/**
 保存视频到相册
 */
- (void)saveVideoAtUrl:(NSURL *)videoURL
            completion:(void (^)(NSError *error))completion;




@end
