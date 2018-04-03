//
//  UICollectionView+MTExtension.m
//  iOSWheels
//
//  Created by liyan on 2018/4/2.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "UICollectionView+MTExtension.h"

@implementation UICollectionView (MTExtension)

/**  注册 UICollectionViewCell */
- (void)mt_registerCell:(Class)cellClass {
    NSAssert(cellClass != nil, @"cellClass 不能为 nil");
    
    [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}


/**  注册 header*/
- (void)mt_registerHeader:(Class)headerClass {
    NSAssert(headerClass != nil, @"headerClass 不能为 nil");
    [self registerClass:headerClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:NSStringFromClass(headerClass)];
}


/**  注册 footer*/
- (void)mt_registerFooter:(Class)footerClass {
    NSAssert(footerClass != nil, @"footerClass 不能为 nil");
    [self registerClass:footerClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(footerClass)];
}

@end
