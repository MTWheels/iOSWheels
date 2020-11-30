//
//  MTTextView.h
//  textApp
//
//  Created by 方新俊 on 2018/4/2.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString    *placeholder;

/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor   *placeholderColor;
/** 占位文字字体 */
@property (nonatomic, strong) UIFont   *placeholderFont;
/** 最小高度,默认高度 */
@property (nonatomic, assign) CGFloat   minHeight;

/**文本高度block*/
@property (nonatomic, copy) void        (^ textViewTextHeightBlock)(CGFloat textHeight,MTTextView *textVeiw);

+ (instancetype)textViewWithFrame:(CGRect)frame placeholder:(NSString *)placeholder  height:(void (^)(CGFloat textViewHeight,MTTextView *textView))textViewTextHeightBlock;

@end
