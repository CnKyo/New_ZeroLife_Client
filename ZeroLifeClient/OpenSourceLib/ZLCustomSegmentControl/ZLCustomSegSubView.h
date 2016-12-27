//
//  ZLCustomSegSubView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/12/26.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLCustomSegSubView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *mImg;

@property (weak, nonatomic) IBOutlet UIImageView *mSubImg;

@property (weak, nonatomic) IBOutlet UILabel *mTitle;

@property (weak, nonatomic) IBOutlet UIView *mLine;

@property (weak, nonatomic) IBOutlet UIButton *mBtn;

+ (ZLCustomSegSubView *)initView;
@end
