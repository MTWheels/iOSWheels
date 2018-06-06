//
//  MTImageManager.m
//  iOSWheels
//
//  Created by liyan on 2018/6/6.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "MTImageManager.h"

#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface MTImageManager()

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (nonatomic, strong) ALAssetsLibrary *assetLibrary;


@end

@implementation MTImageManager


+ (instancetype)manager {
    static MTImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}



/// Return YES if Authorized 返回YES如果得到了授权
- (BOOL)authorizationStatusAuthorized {
    return [self authorizationStatus] == 3;
}

- (NSInteger)authorizationStatus {
    if (iOS8_VERSTION_LATER) {
        return [PHPhotoLibrary authorizationStatus];
    } else {
        return [ALAssetsLibrary authorizationStatus];
    }
    return NO;
}



///获取图片方向
- (ALAssetOrientation)orientationFromImage:(UIImage *)image {
    NSInteger orientation = image.imageOrientation;
    return orientation;
}



#pragma mark - Save photo
- (void)savePhotoWithImage:(UIImage *)image completion:(void (^)(NSError *error))completion {
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    if (iOS9_VERSTION_LATER) {  // 这里有坑... iOS8系统下这个方法保存图片会失败 原来是因为PHAssetResourceType是iOS9之后的...
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetResourceCreationOptions *options = [[PHAssetResourceCreationOptions alloc] init];
            options.shouldMoveFile = YES;
            [[PHAssetCreationRequest creationRequestForAsset] addResourceWithType:PHAssetResourceTypePhoto data:data options:options];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (success && completion) {
                    completion(nil);
                } else if (error) {
                    NSLog(@"保存照片出错:%@",error.localizedDescription);
                    if (completion) {
                        completion(error);
                    }
                }
            });
        }];
        
    }  else {         //iOS9.0 以前
        
        [self.assetLibrary writeImageToSavedPhotosAlbum:image.CGImage orientation:[self orientationFromImage:image] completionBlock:^(NSURL *assetURL, NSError *error) {
            if (error) {
                NSLog(@"保存图片失败:%@",error.localizedDescription);
                if (completion) {
                    completion(error);
                }
            } else {
                // 多给系统0.5秒的时间，让系统去更新相册数据
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(nil);
                    }
                });
            
            }
        }];
        
        
    }
    
}




#pragma mark - 保存视频
- (void)saveVideoAtUrl:(NSURL *)videoURL
            completion:(void (^)(NSError *error))completion {
    
    if (iOS9_VERSTION_LATER) {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetResourceCreationOptions *options = [[PHAssetResourceCreationOptions alloc] init];
            options.shouldMoveFile = YES;
            [PHAssetCreationRequest creationRequestForAssetFromVideoAtFileURL:videoURL];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (success && completion) {
                    NSLog(@"保存成功");
                    completion(nil);
                } else if (error) {
                    NSLog(@"保存视频失败:%@",error.localizedDescription);
                    if (completion) {
                        completion(error);
                    }
                }
            });
        }];
    } else {
        [self.assetLibrary writeVideoAtPathToSavedPhotosAlbum:videoURL completionBlock:^(NSURL *assetURL, NSError *error) {
            if (error) {
                NSLog(@"保存视频失败:%@",error.localizedDescription);
                if (completion) {
                    completion(error);
                }
            } else {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NSLog(@"保存成功");
                    if (completion) {
                        completion(nil);
                    }
                });
            }
        }];
    }
    
}







#pragma mark ----- Getter and Setter -----
- (ALAssetsLibrary *)assetLibrary {
    if (!_assetLibrary) {
        _assetLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetLibrary;
}



@end
