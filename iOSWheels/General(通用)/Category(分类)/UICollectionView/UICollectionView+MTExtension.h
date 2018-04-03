//
//  UICollectionView+MTExtension.h
//  iOSWheels
//
//  Created by liyan on 2018/4/2.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (MTExtension)


/**  注册 UICollectionViewCell */
- (void)mt_registerCell:(Class)cellClass;

/**  注册 header*/
- (void)mt_registerHeader:(Class)headerClass;

/**  注册 footer*/
- (void)mt_registerFooter:(Class)footerClass;

@end
