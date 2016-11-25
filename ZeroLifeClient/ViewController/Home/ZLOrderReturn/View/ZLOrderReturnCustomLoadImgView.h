//
//  ZLOrderReturnCustomLoadImgView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/21.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLOrderReturnCustomLoadImgView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *mImg;

@property (weak, nonatomic) IBOutlet UIButton *mDeleteBtn;

+ (ZLOrderReturnCustomLoadImgView *)shareView;

@end
