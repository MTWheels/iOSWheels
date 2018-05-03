//
//  UIButton+ChainStyle.m
//  链式语法
//
//  Created by liyan on 2017/11/13.
//  Copyright © 2017年 liyan. All rights reserved.
//

#import "UIButton+ChainStyle.h"

@implementation UIButton (ChainStyle)


- (UIButton *(^)(CGFloat x,CGFloat y, CGFloat width,CGFloat height))btnFrame {
    return ^id(CGFloat x,CGFloat y, CGFloat width,CGFloat height) {
        self.frame = CGRectMake(x, y, width, height);
        return self;
    };
}

- (UIButton *(^)(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right))btnTitleEdgeInsets {
    return ^id(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
        self.titleEdgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
        return self;
    };
}


- (UIButton *(^)(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right))btnImageEdgeInsets {
    return ^id(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
        self.imageEdgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
        return self;
    };
}


- (UIButton *(^)(UIFont *font))btnFont {
    return ^id(UIFont *font) {
        self.titleLabel.font = font;
        return self;
    };
}



- (UIButton *(^)(NSString *title))btnTitle {
    return ^id(NSString* title) {
        [self setTitle:title forState:UIControlStateNormal];
        return self;
    };
}



- (UIButton *(^)(NSString *selectedTitle))btnSelectedTitle {
    return ^id(NSString *selectedTitle) {
        [self setTitle:selectedTitle forState:UIControlStateSelected];
        return self;
    };
}



- (UIButton *(^)(UIColor *color))btnColor {
    return ^id(UIColor *color) {
        [self setTitleColor:color forState:UIControlStateNormal];
        return self;
    };
}



- (UIButton *(^)(UIColor *selectedColor))btnSelectedColor {
    return ^id(UIColor *selectedColor) {
        [self setTitleColor:selectedColor forState:UIControlStateSelected];
        return self;
    };
}


- (UIButton *(^)(UIImage *image))btnNormalImage {
    return ^id(UIImage *image) {
        [self setImage:image forState:UIControlStateNormal];
        return self;
    };
}



- (UIButton *(^)(UIImage *image))btnSelectedImage {
    return ^id(UIImage *image) {
        [self setImage:image forState:UIControlStateSelected];
        return self;
    };
}


@end
