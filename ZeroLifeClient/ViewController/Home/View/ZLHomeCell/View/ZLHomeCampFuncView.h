//
//  ZLHomeCampFuncView.h
//  ZeroLifeClient
//
//  Created by Mac on 2017/1/16.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 设置代理
 */
@protocol ZLHomeCampFuncViewDelegate <NSObject>

@optional

/**
 点击代理方法

 @param mIndex 索引
 */
- (void)ZLHomeCampFuncViewDidSelected:(NSInteger)mIndex;

@end

@interface ZLHomeCampFuncView : UIView

/**
 小图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *mIcon;

/**
 标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mTitle;

/**
 内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;

/**
 大图
 */
@property (weak, nonatomic) IBOutlet UIImageView *mBigImg;

/**
 按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mBtn;

/**
 索引
 */
@property (assign,nonatomic) NSInteger mIndex;

/**
 设置代理
 */
@property (strong,nonatomic) id<ZLHomeCampFuncViewDelegate>delegate;

+ (ZLHomeCampFuncView *)initSmallView;
+ (ZLHomeCampFuncView *)initBigView;
+ (ZLHomeCampFuncView *)initImgRightView;

@end
