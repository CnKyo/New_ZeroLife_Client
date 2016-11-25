//
//  ZLHomeLocationView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/1.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 设置代理
 */
@protocol ZLHomeLocationViewDelegate <NSObject>

@optional

/**
 代理方法
 */
- (void)ZLHomLocationViewDidSelected;

@end

@interface ZLHomeLocationView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *mLocation;
@property (weak, nonatomic) IBOutlet UIImageView *mDown;

/**
 地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddress;

/**
 地址安宁
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddressBtn;

/**
 代理
 */
@property (strong, nonatomic) id <ZLHomeLocationViewDelegate> delegate;

/**
 初始化方法

 @return 返回view
 */
+ (ZLHomeLocationView *)shareView;

@end
