//
//  UIView+AutoSize.h
//  GoApp
//
//  Created by 瞿伦平 on 15/1/13.
//  Copyright (c) 2015年 allran.mine. All rights reserved.
//

#import <UIKit/UIKit.h>


const static float OnePixNumber = 1;
const static float TenPixNumber = 10;


@interface UIView (UIView_AutoSize)
- (UIView *)newUIView;
- (UIView *)newUIViewWithBgColor:(UIColor *)bgColor;
- (UIView *)newDefaultLineView;  //默认虚线

- (UILabel *)newUILable;
- (UILabel *)newUILableWithText:(NSString *)text;
- (UILabel *)newUILableWithText:(NSString *)text textColor:(UIColor *)color;
- (UILabel *)newUILableWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font;
- (UILabel *)newUILableWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;

- (UIImageView *)newUIImageView;
- (UIImageView *)newUIImageViewWithImg:(UIImage *)img;

- (UIButton *)newUIButton;
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel;
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel title:(NSString *)title;
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel title:(NSString *)title titleColor:(UIColor *)titleColor;
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font;
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font bgImgNormal:(UIImage *)bgImageNameNormal;
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font bgImgNormal:(UIImage *)bgImageNameNormal bgImgHighlighted:(UIImage *)bgImageNameHighlighted;
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font highlightedTitleColor:(UIColor *)highlightedTitleColor;
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font titleEdgeInsets:(UIEdgeInsets)titleEdge imgNormal:(UIImage *)imageNameNormal imageEdgeInsets:(UIEdgeInsets)imgeEdge;
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel imgNormal:(UIImage *)imageNameNormal;
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel bgImgNormal:(UIImage *)bgImageNameNormal;
- (UIButton *)newUIButtonWithTarget:(id)target mehotd:(SEL)sel bgImgNormal:(UIImage *)bgImageNameNormal bgImgHighlighted:(UIImage *)bgImageNameHighlighted;

- (UITextField *)newUITextField;
- (UITextField *)newUITextFieldWithPlaceholder:(NSString *)placeholder;
- (UITextField *)newUITextFieldWithPlaceholder:(NSString *)placeholder text:(NSString *)text;
- (UITextField *)newUITextFieldWithPlaceholder:(NSString *)placeholder keyboardType:(UIKeyboardType)keyboardType;

- (UITextView *)newUITextView;

- (UIScrollView *)newUIScrollView;

-(UISearchBar *)newUISearchBar;
-(UISearchBar *)newUISearchBarWithPlaceholder:(NSString *)placeholder;


@end



@interface UIView (Additions)
-(void)removeViewWithTag:(NSInteger)tag;
- (void)removeAllSubviews ;
- (UIView*)descendantOrSelfWithClass:(Class)cls;
- (UIView*)ancestorOrSelfWithClass:(Class)cls;
@end


@interface UITableView (HeaderView)

@end
