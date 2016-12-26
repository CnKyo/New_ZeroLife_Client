//
//  ZLCustomSegView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/12/26.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    ZLCustomSegViewTypeOnlyText = 0,///默认值显示文字
    ZLCustomSegViewTypeOnlyImage = 1,///只显示图片
    ZLCustomSegViewTypeTextAndImage = 2,///显示文字和图片
} ZLCustomSegViewType;///显示类型


/**
 设置代理
 */
@protocol ZLCustomSegViewDelegate <NSObject>

@optional

/**
 选择了哪一个

 @param mIndex 返回索引
 */
- (void)ZLCustomSegViewDidBtnSelectedWithIndex:(NSInteger)mIndex;

@end

@interface ZLCustomSegView : UIView

+ (ZLCustomSegView *)initViewType:(ZLCustomSegViewType)mType andTextArr:(NSArray *)mTextArr andImgArr:(NSArray *)mImgArr;


@property (strong,nonatomic) id <ZLCustomSegViewDelegate>delegate;

@end
