//
//  UIView+AutoSize.m
//  GoApp
//
//  Created by 瞿伦平 on 15/1/13.
//  Copyright (c) 2015年 allran.mine. All rights reserved.
//

#import "UIView+AutoSize.h"

@implementation UIView (UIView_AutoSize)

#pragma mark -
#pragma mark - UIView-->New
- (UIView *)newUIView {
    UIView *view = UIView.new;
    [self addSubview:view];
    return view;
}
- (UIView *)newUIViewWithBgColor:(UIColor *)bgColor {
    UIView *view = [self newUIView];
    view.backgroundColor = bgColor;
    return view;
}
- (UIView *)newDefaultLineView {
    UIView *view = [self newUIView];
    view.backgroundColor = [UIColor colorWithRed:0.912 green:0.902 blue:0.902 alpha:1.000];
    return view;
}


- (UILabel *)newUILableWithText:(NSString *)text
{
    UILabel *lable = [self newUILable];
    if (text!=nil)
        lable.text = text;
    return lable;
}
- (UILabel *)newUILableWithText:(NSString *)text textColor:(UIColor *)color {
    UILabel *lable = [self newUILable];
    if (text!=nil)
        lable.text = text;
    if (color!=nil)
        lable.textColor = color;
    return lable;
}

- (UILabel *)newUILable {
    UILabel *view = UILabel.new;
    [self addSubview:view];
    return view;
}
- (UILabel *)newUILableWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font
{
    UILabel *lable = [self newUILableWithText:text textColor:color];
    if (font!=nil)
        lable.font = font;
    return lable;
}
- (UILabel *)newUILableWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *lable = [self newUILableWithText:text textColor:color font:font];
    lable.textAlignment = textAlignment;
    return lable;
}


- (UIImageView *)newUIImageView {
    UIImageView *view = UIImageView.new;
    //view.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:view];
    return view;
}
- (UIImageView *)newUIImageViewWithImg:(UIImage *)img {
    UIImageView *view = UIImageView.new;
    view.image = img;
    [self addSubview:view];
    return view;
}




- (UIButton *)newUIButton {
    UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:view];
    return view;
}
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel {
    UIButton *btn = [self newUIButton];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel title:(NSString *)title {
    UIButton *btn = [self newUIButtonWithTarget:target mehotd:sel];
    if (title != nil)
        [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel title:(NSString *)title titleColor:(UIColor *)titleColor{
    UIButton *btn = [self newUIButtonWithTarget:target mehotd:sel title:title];
    if (titleColor != nil)
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    return btn;
}
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font{
    UIButton *btn = [self newUIButtonWithTarget:target mehotd:sel title:title titleColor:titleColor];
    if (font != nil)
        btn.titleLabel.font = font;
    return btn;
}
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font bgImgNormal:(UIImage *)bgImageNameNormal{
    UIButton *btn = [self newUIButtonWithTarget:target mehotd:sel title:title titleColor:titleColor titleFont:font];
    if (bgImageNameNormal != nil)
        [btn setBackgroundImage:bgImageNameNormal forState:UIControlStateNormal];
    return btn;
}
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font bgImgNormal:(UIImage *)bgImageNameNormal bgImgHighlighted:(UIImage *)bgImageNameHighlighted {
    UIButton *btn = [self newUIButtonWithTarget:target mehotd:sel title:title titleColor:titleColor titleFont:font bgImgNormal:bgImageNameNormal];
    if (bgImageNameHighlighted != nil)
        [btn setBackgroundImage:bgImageNameHighlighted forState:UIControlStateHighlighted];
    return btn;
}
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font highlightedTitleColor:(UIColor *)highlightedTitleColor{
    UIButton *btn = [self newUIButtonWithTarget:target mehotd:sel title:title titleColor:titleColor titleFont:font];
    if (highlightedTitleColor!=nil)
        [btn setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
    return btn;
}
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel imgNormal:(UIImage *)imageNameNormal {
    UIButton *btn = [self newUIButtonWithTarget:target mehotd:sel];
    if (imageNameNormal != nil)
        [btn setImage:imageNameNormal forState:UIControlStateNormal];
    return btn;
}
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel bgImgNormal:(UIImage *)bgImageNameNormal{
    UIButton *btn = [self newUIButtonWithTarget:target mehotd:sel];
    if (bgImageNameNormal != nil)
        [btn setBackgroundImage:bgImageNameNormal forState:UIControlStateNormal];
    return btn;
}
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel bgImgNormal:(UIImage *)bgImageNameNormal bgImgHighlighted:(UIImage *)bgImageNameHighlighted {
    UIButton *btn = [self newUIButtonWithTarget:target mehotd:sel bgImgNormal:bgImageNameNormal];
    if (bgImageNameHighlighted != nil)
        [btn setBackgroundImage:bgImageNameHighlighted forState:UIControlStateHighlighted];
    return btn;
}

- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font titleEdgeInsets:(UIEdgeInsets)titleEdge imgNormal:(UIImage *)imageNameNormal imageEdgeInsets:(UIEdgeInsets)imgeEdge
{
    UIButton *btn = [self newUIButtonWithTarget:target mehotd:sel title:title titleColor:titleColor titleFont:font];
    [btn setImage:imageNameNormal forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setImageEdgeInsets:imgeEdge];
    [btn setTitleEdgeInsets:titleEdge];
    return btn;
}



- (UITextField *)newUITextField {
    UITextField *view = UITextField.new;
    [self addSubview:view];
    return view;
}
- (UITextField *)newUITextFieldWithPlaceholder:(NSString *)placeholder {
    UITextField *view = [self newUITextField];
    view.placeholder = placeholder;
    return view;
}
- (UITextField *)newUITextFieldWithPlaceholder:(NSString *)placeholder text:(NSString *)text{
    UITextField *view = [self newUITextField];
    view.placeholder = placeholder;
    view.text = text;
    return view;
}
- (UITextField *)newUITextFieldWithPlaceholder:(NSString *)placeholder keyboardType:(UIKeyboardType)keyboardType{
    UITextField *view = [self newUITextField];
    view.placeholder = placeholder;
    view.keyboardType = keyboardType;
    [self addSubview:view];
    return view;
}

- (UITextView *)newUITextView {
    UITextView *view = UITextView.new;
    [self addSubview:view];
    return view;
}

- (UIScrollView *)newUIScrollView {
    UIScrollView *view = [[UIScrollView alloc] init];
    [self addSubview:view];
    return view;
}




-(UISearchBar *)newUISearchBar
{
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    [self addSubview:searchBar];
    return searchBar;
}
-(UISearchBar *)newUISearchBarWithPlaceholder:(NSString *)placeholder
{
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = placeholder;
    [self addSubview:searchBar];
    return searchBar;
}


@end



@implementation UIView (Additions)

#pragma mark -
#pragma mark - UIView-->Add

-(void)removeViewWithTag:(NSInteger)tag
{
    if ([self viewWithTag:tag]) {
        [[self viewWithTag:tag] removeFromSuperview];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}
/*
 NSArray *na = [self.view subviews];
 NSEnumerator *ne = [na objectEnumerator];
 UIView *subView;
 while (subView = [ne nextObject]) {
 [self ChangeSegmentFont:subView];
 }
 */

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
        
    } else if (self.superview) {
        return [self.superview ancestorOrSelfWithClass:cls];
        
    } else {
        return nil;
    }
}


@end








@implementation UITableView (HeaderView)


@end