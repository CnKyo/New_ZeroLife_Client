//
//  ZLRunningManTopView.h
//  ZeroLifeClient
//
//  Created by Mac on 2017/1/5.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLCustomSegView.h"
/**
 设置代理
 */
@protocol ZLRunningManTopViewDelegate <NSObject>

@optional

/**
 按钮点击代理方法
 
 @param mIndex 索引
 */
- (void)ZLRunningManTopViewBtnClickedWithIndex:(NSInteger)mIndex;

/**
 分类按钮点击代理方法

 @param mIndex 索引
 */
- (void)ZLRunningManClassViewBtnClickedWithIndex:(NSInteger)mIndex;


@end

@interface ZLRunningManTopView : UIView<ZLCustomSegViewDelegate>

+ (ZLRunningManTopView *)initView:(NSArray *)mData;


+ (ZLRunningManTopView *)initclassViewText:(NSArray *)mText andImg:(NSArray *)mImg;


/**
 设置代理
 */
@property (strong,nonatomic) id<ZLRunningManTopViewDelegate>delegate;
@end
