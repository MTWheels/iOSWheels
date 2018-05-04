//
//  UIScrollView+MTEmptyData.h
//
//  Created by 方新俊 on 2018/4/10.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnBlock)(void);

@interface UIScrollView (MTEmptyData)

/*********默认图片属性设置***************/
/**提示图片*/
@property (nonatomic, strong, nullable) UIImage                   *mt_emptyDataImag;
/**图片frame*/
@property (nonatomic, assign)           CGSize                    mt_imageViewSize;

/*********默认title属性设置***************/
/**提示文本*/
@property (nonatomic, copy, nullable)   NSString                  *mt_emptyDataTitleStr;
/**标题颜色*/
@property (nonatomic, strong,nullable)  UIColor                   *mt_titleColor;
/**标题字体*/
@property (nonatomic, strong,nullable)  UIFont                    *mt_titleFont;
/**标题左右两侧间隙*/
@property (nonatomic, assign)           CGFloat                    mt_titleLeftAndRightSpace;

/*********默认按钮属性设置***************/
/**按钮btn*/
@property (nonatomic, copy, nullable)   NSString                  *mt_btnTitle;
/**按钮背景颜色*/
@property (nonatomic, strong, nullable) UIColor                   *mt_btnBackgroundColor;
/**按钮背景图片*/
@property (nonatomic, strong, nullable) UIImage                   *mt_btnBackgroundImage;
/**按钮frame*/
@property (nonatomic, assign)           CGSize                    mt_btnSize;
/**按钮是否圆角*/
@property (nonatomic, assign)           BOOL                      mt_btnIsCornerRadius;
/**按钮title颜色*/
@property (nonatomic, strong)           UIColor                   *mt_btnTitleColor;
/**BtnClickBlock*/
@property (nonatomic, copy)             BtnBlock                  mt_btnClickBlock;
/**按钮图片*/
@property (nonatomic, strong, nullable) UIImage                   *mt_btnImage;
/**btnTitle字体*/
@property (nonatomic, strong,nullable)  UIFont                    *mt_btnTitleFont;

/*********自定义***************/
/**自定义View*/
@property (nonatomic, strong, nullable) UIView                    *mt_emptyDataCustomView;
/**默认view上的 自定义按钮*/
@property (nonatomic, strong, nullable) UIButton                  *mt_emptyDataCustomBtn;

/**视图Y值偏移量*/
@property (nonatomic, assign)           CGFloat                   mt_contentOffsetY;

- (void)showEmptyDataView;
- (void)hiddenEmptyDataView;
@end
