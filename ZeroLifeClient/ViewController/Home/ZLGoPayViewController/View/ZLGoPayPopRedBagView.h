//
//  ZLGoPayPopRedBagView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ZLGoPayShareDelegate <NSObject>

@optional

- (void)ZLGoPayShareWithBtnClickIndex:(NSInteger)mIndex;

@end
@interface ZLGoPayPopRedBagView : UIView

+ (ZLGoPayPopRedBagView *)initShareViewWithFrame:(CGRect)mFrame andDataSource:(NSArray *)mDataSource;

@property (strong,nonatomic)id<ZLGoPayShareDelegate>delegate;

@end
