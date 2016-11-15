//
//  WKSegmentControl.h
//  kTest
//
//  Created by wangke on 16/1/4.
//  Copyright © 2016年 wangke. All rights reserved.
//

#import <UIKit/UIKit.h>

///代理方法
@protocol WKSegmentControlDelagate <NSObject>

@optional
///选择了哪一个？
- (void)WKDidSelectedIndex:(NSInteger)mIndex;

@end

@interface WKSegmentControl : UIView

@property (nonatomic,strong) id <WKSegmentControlDelagate> delegate;
///按钮数组
@property (nonatomic,strong) NSMutableArray *FWHBtnArr;
///按钮标签颜色
@property (nonatomic,strong) UIColor    *FWHBtnTitelColor;
///按钮选中的颜色
@property (nonatomic,strong) UIColor    *FWHBtnSelectedColor;
///按钮横线的颜色
@property (nonatomic,strong) UIColor    *FWHUnderLineColor;
///字体
@property (nonatomic,strong) UIFont     *FWHBtnFont;
///按钮下划线的间隔
@property (assign,nonatomic)int FWHInterVal;

///是否隐藏下划线
@property (assign,nonatomic) BOOL   FWHHiddenLine;
/**
 *  初始化方法
 *
 *  @param frame            view的frame
 *  @param btnTitleArr      标题数组
 *  @param mBackgroudColor  背景色
 *  @param btnSelectedColor 按钮选中色
 *  @param btnTitleColor    标题颜色
 *  @param btnUndeLineColor 下划线颜色
 *  @param btnTitleFont     按钮标题字体
 *  @param mInterVal        间距
 *  @param delegate         代理
 *  @param mHidden          是否隐藏间距之间的线
 *
 *  @return 返回的view
 */
+ (WKSegmentControl *)initWithSegmentControlFrame:(CGRect)frame andTitleWithBtn:(NSArray *)btnTitleArr andBackgroudColor:(UIColor *)mBackgroudColor andBtnSelectedColor:(UIColor *)btnSelectedColor andBtnTitleColor:(UIColor *)btnTitleColor andUndeLineColor:(UIColor *)btnUndeLineColor andBtnTitleFont:(UIFont *)btnTitleFont andInterval:(int)mInterVal delegate:(id)delegate andIsHiddenLine:(BOOL)mHidden andType:(int)mtype;
@end
