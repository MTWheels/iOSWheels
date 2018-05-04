//
//  UIScrollView+MTEmptyData.m
//
//  Created by 方新俊 on 2018/4/10.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "UIScrollView+MTEmptyData.h"
#import <objc/runtime.h>

static char const * const kEmptyDataSetView          =       "emptyDataSetView";
static char const * const kEmptyDataImag             =       "mt_emptyDataImag";
static char const * const kEmptyDataTitleStr         =       "mt_emptyDataTitleStr";
static char const * const kEmptyDataCustomView       =       "mt_emptyDataCustomView";
static char const * const kEmptyBtnTitle             =       "mt_btnTitle";
static char const * const kEmptyBtnBackgroundColor   =       "mt_btnBackgroundColor";
static char const * const kEmptyBtnBackgroundImage   =       "mt_btnBackgroundImage";
static char const * const kEmptyBtnSize              =       "mt_btnSize";
static char const * const kEmptyBtnisCornerRadius    =       "mt_btnIsCornerRadius";
static char const * const kEmptyBtnTitleColor        =       "mt_btnTitleColor";
static char const * const kEmptyImageViewSize        =       "mt_imageViewSize";
static char const * const kEmptyTitleColor           =       "mt_titleColor";
static char const * const kEmptyTitleFont            =       "mt_titleFont";
static char const * const kEmptyBtnClickBlcok        =       "mt_btnClickBlock";
static char const * const kEmptyBtnImage             =       "mt_btnImage";
static char const * const kEmptyContentOffsetY       =       "mt_contentOffsetY";
static char const * const kEmptyTitleLeftAndRightSpace  =    "mt_titleLeftAndRightSpace";
static char const * const kEmptyDataCustomBtn        =       "mt_emptyDataCustomBtn";
static char const * const kEmptyBtnTitleFont         =       "mt_btnTitleFont";


@interface MTEmptyDataSetView : UIView
/**内容view*/
@property (nonatomic, readonly) UIView       *contentView;
/**title*/
@property (nonatomic, readonly) UILabel      *titleLabel;
/**提示图片*/
@property (nonatomic, readonly) UIImageView  *imageView;
/**按钮*/
@property (nonatomic, strong)   UIButton     *button;
/**自定义view*/
@property (nonatomic, strong)   UIView       *customView;
/**EmptyDataSetView按钮点击*/
@property (nonatomic, copy)     BtnBlock     EmptyContentViewBlock;

- (void)loadFrameWithBtnSize:(CGSize)btnSize
               imageViewSize:(CGSize)imageViewSize
              contentOffsetY:(CGFloat)contentOffsetY
      titleLeftAndRightSpace:(CGFloat)titleLeftAndRightSpace;
- (void)prepareForReuse;

@end

@interface UIScrollView ()
// 背景view
@property (nonatomic, strong) MTEmptyDataSetView *emptyDataSetView;

@end

@implementation UIScrollView (MTEmptyData)

#pragma mark - Getters (Public)

- (MTEmptyDataSetView *)emptyDataSetView
{
    MTEmptyDataSetView *view = objc_getAssociatedObject(self, kEmptyDataSetView);
    if (!view)
    {
        view = [MTEmptyDataSetView new];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.zPosition = 100;
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        view.hidden = YES;
        self.emptyDataSetView = view;
    }
    return view;
}

- (UIImage *)mt_emptyDataImag
{
    return objc_getAssociatedObject(self, kEmptyDataImag);
}

- (NSString *)mt_emptyDataTitleStr
{
    return objc_getAssociatedObject(self, kEmptyDataTitleStr);
}

- (UIView *)mt_emptyDataCustomView
{
    return objc_getAssociatedObject(self, kEmptyDataCustomView);
}

- (UIButton *)mt_emptyDataCustomBtn
{
    return objc_getAssociatedObject(self, kEmptyDataCustomBtn);
}

- (NSString *)mt_btnTitle
{
    return objc_getAssociatedObject(self, kEmptyBtnTitle);
}

- (UIColor *)mt_btnBackgroundColor
{
    return objc_getAssociatedObject(self, kEmptyBtnBackgroundColor);
}

- (UIColor *)mt_btnTitleColor
{
    return objc_getAssociatedObject(self, kEmptyBtnTitleColor);
}

- (UIImage *)mt_btnBackgroundImage
{
    return objc_getAssociatedObject(self, kEmptyBtnBackgroundImage);
}

- (UIImage *)mt_btnImage
{
    return objc_getAssociatedObject(self, kEmptyBtnImage);
}

- (CGSize)mt_btnSize
{
    NSValue *valueSize = objc_getAssociatedObject(self, kEmptyBtnSize);
    CGSize btnSize =  [valueSize CGSizeValue];
    return btnSize;
}

- (CGFloat)mt_contentOffsetY
{
    return [objc_getAssociatedObject(self, kEmptyContentOffsetY) floatValue];
}

- (CGFloat)mt_titleLeftAndRightSpace
{
    CGFloat tempY = [objc_getAssociatedObject(self, kEmptyTitleLeftAndRightSpace) floatValue];
    return tempY;
}

- (CGSize)mt_imageViewSize
{
    NSValue *valueSize = objc_getAssociatedObject(self, kEmptyImageViewSize);
    CGSize btnSize =  [valueSize CGSizeValue];
    return btnSize;
}

- (UIColor *)mt_titleColor
{
    return objc_getAssociatedObject(self, kEmptyTitleColor);
}

- (UIFont *)mt_titleFont
{
    return objc_getAssociatedObject(self, kEmptyTitleFont);
}

- (UIFont *)mt_btnTitleFont
{
    return objc_getAssociatedObject(self, kEmptyBtnTitleFont);
}

- (BtnBlock)mt_btnClickBlock
{
    return objc_getAssociatedObject(self, kEmptyBtnClickBlcok);
}

- (BOOL)mt_btnIsCornerRadius
{
    return [objc_getAssociatedObject(self, kEmptyBtnisCornerRadius) boolValue];
}

#pragma mark - Setters (Private)

- (void)setEmptyDataSetView:(UIView *)emptyDataSetView
{
    objc_setAssociatedObject(self, kEmptyDataSetView, emptyDataSetView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMt_emptyDataImag:(UIImage *)mt_emptyDataImag
{
    objc_setAssociatedObject(self, kEmptyDataImag, mt_emptyDataImag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMt_emptyDataTitleStr:(NSString *)mt_emptyDataTitleStr
{
    objc_setAssociatedObject(self, kEmptyDataTitleStr, mt_emptyDataTitleStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setMt_emptyDataCustomView:(NSString *)mt_emptyDataCustomView
{
    objc_setAssociatedObject(self, kEmptyDataCustomView, mt_emptyDataCustomView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMt_emptyDataCustomBtn:(UIButton *)mt_emptyDataCustomBtn
{
    objc_setAssociatedObject(self, kEmptyDataCustomBtn, mt_emptyDataCustomBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMt_btnTitle:(NSString *)mt_btnTitle
{
    objc_setAssociatedObject(self, kEmptyBtnTitle, mt_btnTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setMt_btnBackgroundColor:(UIColor *)mt_btnBackgroundColor
{
    objc_setAssociatedObject(self, kEmptyBtnBackgroundColor, mt_btnBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMt_btnTitleColor:(UIColor *)mt_btnTitleColor
{
    objc_setAssociatedObject(self, kEmptyBtnTitleColor, mt_btnTitleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMt_btnBackgroundImage:(UIImage *)mt_btnBackgroundImage
{
    objc_setAssociatedObject(self, kEmptyBtnBackgroundImage, mt_btnBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMt_btnImage:(UIImage *)mt_btnImage
{
    objc_setAssociatedObject(self, kEmptyBtnImage, mt_btnImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMt_btnSize:(CGSize)mt_btnSize
{
    objc_setAssociatedObject(self, kEmptyBtnSize, [NSValue valueWithCGSize:mt_btnSize], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMt_imageViewSize:(CGSize)mt_imageViewSize
{
    objc_setAssociatedObject(self, kEmptyImageViewSize, [NSValue valueWithCGSize:mt_imageViewSize], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMt_contentOffsetY:(CGFloat)mt_contentOffsetY
{
    objc_setAssociatedObject(self, kEmptyContentOffsetY, @(mt_contentOffsetY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMt_titleLeftAndRightSpace:(CGFloat)mt_titleLeftAndRightSpace
{
    objc_setAssociatedObject(self, kEmptyTitleLeftAndRightSpace, @(mt_titleLeftAndRightSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMt_titleColor:(UIColor *)mt_titleColor
{
    objc_setAssociatedObject(self, kEmptyTitleColor, mt_titleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMt_titleFont:(UIFont *)mt_titleFont
{
    objc_setAssociatedObject(self, kEmptyTitleFont, mt_titleFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMt_btnTitleFont:(UIFont *)mt_btnTitleFont
{
    objc_setAssociatedObject(self, kEmptyBtnTitleFont, mt_btnTitleFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMt_btnIsCornerRadius:(BOOL)mt_btnIsCornerRadius
{
    objc_setAssociatedObject(self, kEmptyBtnisCornerRadius,@(mt_btnIsCornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMt_btnClickBlock:(BtnBlock)mt_btnClickBlock
{
    objc_setAssociatedObject(self, kEmptyBtnClickBlcok, mt_btnClickBlock, OBJC_ASSOCIATION_COPY);//将block 与 alertOne 关联
}

/**显示*/
- (void)showEmptyDataView
{
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
        MTEmptyDataSetView *view = self.emptyDataSetView;
        view.frame = self.bounds;
        if (!view.superview) {
            view.hidden = NO;
            if (([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]]) && self.subviews.count > 1) {
                [self insertSubview:view atIndex:self.subviews.count];
            }
            else {
                [self addSubview:view];
            }
        }

    if (self.mt_emptyDataCustomView) {  // 自定义view
        view.customView = self.mt_emptyDataCustomView;
        view.customView.layer.zPosition = 101;
        [view addSubview:view.customView];
        view.customView.center = view.center;
    }else{
        [view addSubview:view.contentView];
        view.titleLabel.text = self.mt_emptyDataTitleStr?self.mt_emptyDataTitleStr:@"暂无数据";
         CGSize mySize =CGSizeZero;
        if (self.mt_emptyDataCustomBtn){ // 自定义按钮
            [view.contentView addSubview:self.mt_emptyDataCustomBtn];
            view.button = self.mt_emptyDataCustomBtn;
            mySize = self.mt_emptyDataCustomBtn.frame.size;
        }else{
            [view.contentView addSubview:view.button];
            // 按钮
            if (self.mt_btnTitleFont)
                [view.button.titleLabel setFont:self.mt_btnTitleFont];
            if (self.mt_btnTitle){
                [view.button setTitle:self.mt_btnTitle forState:UIControlStateNormal];
                [view.button.titleLabel sizeToFit];
                mySize = view.button.titleLabel.frame.size;
            }
            if (self.mt_btnBackgroundImage)
                [view.button setBackgroundImage:self.mt_btnBackgroundImage forState:UIControlStateNormal];
            if (self.mt_btnBackgroundColor)
                [view.button setBackgroundColor:self.mt_btnBackgroundColor];
            if (self.mt_btnTitleColor)
                [view.button setTitleColor:self.mt_btnTitleColor forState:UIControlStateNormal];
            if (self.mt_btnImage) {
                [view.button setImage:self.mt_btnImage forState:UIControlStateNormal];
                mySize = self.mt_btnImage.size;
            }
            if (self.mt_btnSize.width && self.mt_btnSize.height)
                mySize = self.mt_btnSize;
            if (self.mt_btnIsCornerRadius)
                view.button.layer.cornerRadius = mySize.height/2;
            // 点击回调
            if (self.mt_btnClickBlock) {
                view.EmptyContentViewBlock = self.mt_btnClickBlock;
            }
        }
        // 图片
        CGSize imageSize = CGSizeZero;
        if (self.mt_emptyDataImag) {
            view.imageView.image = self.mt_emptyDataImag;
            imageSize = self.mt_emptyDataImag.size;
        }
        if (self.mt_imageViewSize.width && self.mt_imageViewSize.height)
            imageSize = self.mt_imageViewSize;
        // 标题
        if (self.mt_titleColor)
            view.titleLabel.textColor = self.mt_titleColor;
        if (self.mt_titleFont)
            view.titleLabel.font = self.mt_titleFont;
        CGFloat titleLeftAndRightSpace = 0;
        if (self.mt_titleLeftAndRightSpace)
            titleLeftAndRightSpace = self.mt_titleLeftAndRightSpace;
       
        CGFloat contentOffsetY = 0;
        if (self.mt_contentOffsetY)
            contentOffsetY = self.mt_contentOffsetY;
        // 加载frame
        [view loadFrameWithBtnSize:mySize imageViewSize:imageSize contentOffsetY:contentOffsetY titleLeftAndRightSpace:titleLeftAndRightSpace];
    }
}

/**隐藏*/
- (void)hiddenEmptyDataView
{
    [self.emptyDataSetView prepareForReuse];
    [self.emptyDataSetView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.emptyDataSetView removeFromSuperview];
    self.emptyDataSetView = nil;
}

@end

@implementation MTEmptyDataSetView
@synthesize contentView = _contentView;
@synthesize titleLabel = _titleLabel, imageView = _imageView, button = _button ,customView = _customView;
@synthesize EmptyContentViewBlock = _EmptyContentViewBlock;

#pragma mark - Initialization Methods

- (instancetype)init
{
    self =  [super init];
    if (self) {
    }
    return self;
}

- (void)didTapButton:(UIButton *)sender
{
    if (_EmptyContentViewBlock) {
        _EmptyContentViewBlock();
    }
}

#pragma mark - Getters
- (UIView *)contentView
{
    if (!_contentView)
    {
        _contentView = [UIView new];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.userInteractionEnabled = YES;
        _contentView.alpha = 1;
        _contentView.layer.zPosition = 101;
    }
    return _contentView;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = NO;
        _imageView.accessibilityIdentifier = @"empty set background image";
        
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:27.0];
        _titleLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
        _titleLabel.accessibilityIdentifier = @"empty set title";
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        _button.backgroundColor = [UIColor blueColor];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _button.accessibilityIdentifier = @"empty set button";
        _button.clipsToBounds = YES;
        _button.titleLabel.font = [UIFont systemFontOfSize:14];
        [_button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
    return _button;
}

- (void)loadFrameWithBtnSize:(CGSize)btnSize imageViewSize:(CGSize)imageViewSize contentOffsetY:(CGFloat)contentOffsetY titleLeftAndRightSpace:(CGFloat)titleLeftAndRightSpace
{
    self.imageView.frame = CGRectMake(0, 0, imageViewSize.width, imageViewSize.height);
    self.titleLabel.frame = CGRectMake(titleLeftAndRightSpace, CGRectGetMaxY(self.imageView.frame)+15, CGRectGetWidth(self.bounds) - titleLeftAndRightSpace*2, 0);
    [self.titleLabel sizeToFit];
    self.button.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+10, btnSize.width, btnSize.height);
    
    self.contentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetMaxY(self.button.frame));
    self.contentView.center = CGPointMake(self.center.x, self.center.y + contentOffsetY);
    self.imageView.center = CGPointMake(self.contentView.center.x, self.imageView.center.y);
    self.titleLabel.center = CGPointMake(self.contentView.center.x, self.titleLabel.center.y);
    self.button.center = CGPointMake(self.contentView.center.x, self.button.center.y);

}

- (void)prepareForReuse
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _titleLabel = nil;
    _imageView = nil;
    _button = nil;
    _customView = nil;
    _EmptyContentViewBlock = nil;
}

@end

