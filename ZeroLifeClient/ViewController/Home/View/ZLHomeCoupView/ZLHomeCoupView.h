//
//  ZLHomeCoupView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/2.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 设置代理
 */
@protocol ZLCoupViewDelegate <NSObject>

@optional

/**
 确定按钮
 */
- (void)ZLCoupOKBtnSelected;

@end

@interface ZLHomeCoupView : UIView

/**
 背景图
 */
@property (weak, nonatomic) IBOutlet UIImageView *mBgkImage;

/**
 列表
 */
@property (weak, nonatomic) IBOutlet UITableView *mCoupTableView;

/**
 确定按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mOKBtn;

/**
 代理方法
 */
@property (strong, nonatomic) id <ZLCoupViewDelegate> delegate;

/**
 初始化方法

 @return 返回view
 */
+ (ZLHomeCoupView *)shareView;

@end
