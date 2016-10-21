//
//  ZLCustomBtnView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/10/21.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLCustomBtnView : UIView

/**
 初始化自定义方法

 @param mFrame    frame位置
 @param mTitle    标题
 @param mImageStr 图片

 @return 返回self
 */
-(id)initWithZLCustomBtnViewFrame:(CGRect)mFrame Title:(NSString *)mTitle ImageStr:(NSString *)mImageStr;

@end
