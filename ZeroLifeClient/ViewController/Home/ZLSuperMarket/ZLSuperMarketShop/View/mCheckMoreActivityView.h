//
//  mCheckMoreActivityView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/2.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol mCheckMoreActivityViewDelegate <NSObject>

@optional
- (void)closeMCheckMoreActivityView;

@end

@interface mCheckMoreActivityView : UIView
/**
 *  店铺名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mShopName;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;
/**
 *  活动view
 */
@property (weak, nonatomic) IBOutlet UIView *mCampainView;
/**
 *  关闭按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCloseBtn;

@property (strong,nonatomic) id<mCheckMoreActivityViewDelegate>delegate;

/**
 *  初始化方法
 *
 *  @return fanhuiview
 */
+ (mCheckMoreActivityView *)shareView;

@end
