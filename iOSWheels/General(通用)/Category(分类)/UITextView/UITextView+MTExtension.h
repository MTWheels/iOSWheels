//
//  UITextView+MTExtension.h
//  iOSWheels
//
//  Created by liyan on 2018/5/4.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITextView (MTExtension)

/// 限制最大长度
- (void)mt_limitMaxLength:(NSInteger)maxLength;

///if <=0, no limit
@property (assign, nonatomic)  NSInteger jk_maxLength;


@end
