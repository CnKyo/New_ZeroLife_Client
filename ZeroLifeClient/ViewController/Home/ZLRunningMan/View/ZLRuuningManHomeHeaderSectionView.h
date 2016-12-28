//
//  ZLRuuningManHomeHeaderSectionView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 设置代理
 */
@protocol ZLRuuningManHomeHeaderSectionViewDelegate <NSObject>

@optional

/**
 开通代理方法
 */
- (void)ZLRuuningManHomeHeaderSectionViewBtnClicked;

@end

@interface ZLRuuningManHomeHeaderSectionView : UIView

/**
 按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mBtn;

/**
 设置代理
 */
@property (strong, nonatomic) id<ZLRuuningManHomeHeaderSectionViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIView *mSectionView;

@property (weak, nonatomic) IBOutlet UILabel *mContent;

@property (weak, nonatomic) IBOutlet UILabel *mDetail;

/**
 初始化方法

 @return 返回view
 */
+ (ZLRuuningManHomeHeaderSectionView *)initView;

/**
 初始化方法

 @return fanhuiview
 */
+ (ZLRuuningManHomeHeaderSectionView *)initSecondView;

@end
