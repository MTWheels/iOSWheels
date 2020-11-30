//
//  MTTextView.m
//  textApp
//
//  Created by 方新俊 on 2018/4/2.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "MTTextView.h"

@interface MTTextView ()
/** 占位lable */
@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation MTTextView

- (void)awakeFromNib
{
    [super awakeFromNib];
     [self commonInit];
}

+ (instancetype)textViewWithFrame:(CGRect)frame placeholder:(NSString *)placeholder  height:(void (^)(CGFloat textViewHeight,MTTextView *textView))textViewTextHeightBlock{
    MTTextView *textView = [[self alloc] initWithFrame:frame];
    textView.textViewTextHeightBlock = textViewTextHeightBlock;
    textView.placeholder = placeholder;
    return textView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.minHeight = 30;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangeTextView:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:nil];
    [self addObserver:self
           forKeyPath:NSStringFromSelector(@selector(contentSize))
              options:NSKeyValueObservingOptionNew
              context:NULL];
}

#pragma mark - Observers & Notifications
- (void)didChangeTextView:(NSNotification *)notification
{
    MTTextView *textView = notification.object;
    if (textView.text.length == 0) {
        self.placeholderLabel.hidden = NO;
    }else{
        self.placeholderLabel.hidden = YES;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    MTTextView *textView = object;
    if ([object isEqual:self] && [keyPath isEqualToString:NSStringFromSelector(@selector(contentSize))]) {
        CGFloat textHeight = textView.contentSize.height;
        if (textHeight <  self.minHeight) {
            textHeight =  self.minHeight;
        }
        if (_textViewTextHeightBlock) {
            _textViewTextHeightBlock(textHeight,self);
        }
    }
}

#pragma mark - Overrides
- (void)setText:(NSString *)text
{
    [super setText:text];
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self.placeholderLabel sizeToFit];
}

#pragma mark - Setters
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    [self.placeholderLabel sizeToFit];
    self.placeholderLabel.frame = CGRectMake(8, 7,self.bounds.size.width - 8,self.placeholderLabel.frame.size.height);
    [self addSubview:self.placeholderLabel];
    [self sendSubviewToBack:self.placeholderLabel];
    if (self.text.length > 0 && self.placeholder.length > 0) {
        self.placeholderLabel.hidden = YES;
    }
}

- (void)setPlaceholderColor:(UIColor *)color
{
    self.placeholderLabel.textColor = color;
}

- (UIColor *)placeholderColor
{
    return self.placeholderLabel.textColor;
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    _placeholderFont = placeholderFont;
    self.placeholderLabel.font = placeholderFont;
}

- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel){
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.font = [UIFont systemFontOfSize:14];
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        _placeholderLabel.hidden = NO;

    }
    return _placeholderLabel;
}

- (void)dealloc {
#if __has_feature(objc_arc)
#else
    [super dealloc];
#endif
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize))];
    
    _placeholderLabel = nil;
}

@end
