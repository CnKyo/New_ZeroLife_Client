//
//  ZLPPTReleaseBottomView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/16.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomDefine.h"

/**
 设置代理
 */
@protocol ZLPPTReleaseBottomViewDelegate <NSObject>

@optional

/**
 去支付按钮代理方法
 */
- (void)ZLPPTReleaseBottomViewWithGoPayBtnClicked;

@end

@interface ZLPPTReleaseBottomView : UIView

/**
 合计支付
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mTotlePrice;

/**
 去支付按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mGoPayBtn;

/**
 设置代理
 */
@property (strong, nonatomic) id<ZLPPTReleaseBottomViewDelegate>delegate;

/**
 初始化方法

 @return 返回view
 */
+ (ZLPPTReleaseBottomView *)shareView;

@end
