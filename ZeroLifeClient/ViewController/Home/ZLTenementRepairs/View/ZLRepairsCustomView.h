//
//  ZLRepairsCustomView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 设置代理
 */
@protocol ZLRepairsCustomViewDelegate <NSObject>

@optional

/**
 点击代理方法

 @param mIndex 索引
 */
- (void)ZLRepairsCustomViewWithBtnClicked:(NSInteger)mIndex;

@end

@interface ZLRepairsCustomView : UIView

/**
 图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mFixLogo;

/**
 名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mFixName;

/**
 内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mFixContent;

/**
 按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mClickBtn;

/**
 设置代理
 */
@property (weak, nonatomic) id <ZLRepairsCustomViewDelegate>delegate;

/**
 初始化方法

 @param mLogoStr    图片url
 @param mFixName    名称
 @param mFixContent 内容
 @param mTag tag

 @return 返回view
 */
+ (ZLRepairsCustomView *)initWithFixLogo:(NSString *)mLogoStr andFixName:(NSString *)mFixName andFixContent:(NSString *)mFixContent andTag:(NSInteger)mTag;

+ (ZLRepairsCustomView *)initView;
@end
