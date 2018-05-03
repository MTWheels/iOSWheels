//
//  UIButton+ChainStyle.h
//  链式语法
//
//  Created by liyan on 2017/11/13.
//  Copyright © 2017年 liyan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Button ([UIButton buttonWithType:UIButtonTypeCustom])


@interface UIButton (ChainStyle)

#pragma mark --- frame
/**frame*/
@property (nonatomic, copy, readonly) UIButton* (^btnFrame)(CGFloat x,CGFloat y, CGFloat width,CGFloat height);

/** <^(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)> */
@property (nonatomic, copy, readonly) UIButton* (^btnTitleEdgeInsets)(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);
/** <^(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)> */
@property (nonatomic, copy, readonly) UIButton* (^btnImageEdgeInsets)(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);


#pragma mark --- 字体
/**font*/
@property (nonatomic, copy, readonly) UIButton* (^btnFont)(UIFont *font);


#pragma mark - Title and color
/**默认UIControlStateNormal下 文本内容 */
@property (nonatomic, copy, readonly) UIButton* (^btnTitle)(NSString* title);
/**UIControlStateSelected 状态下内容*/
@property (nonatomic, copy, readonly) UIButton* (^btnSelectedTitle)(NSString* selectedTitle);


/**默认UIControlStateNormal下 文本颜色 */
@property (nonatomic, copy, readonly) UIButton* (^btnColor)(UIColor* color);

/**UIControlStateSelected 状态下文本颜色*/
@property (nonatomic, copy, readonly) UIButton* (^btnSelectedColor)(UIColor* selectedColor);


#pragma mark -- image ---
/**默认UIControlStateNormal下 image */
@property (nonatomic, copy, readonly) UIButton* (^btnNormalImage)(UIImage *image);
/**UIControlStateSelected image*/
@property (nonatomic, copy, readonly) UIButton* (^btnSelectedImage)(UIImage *image);


@end
