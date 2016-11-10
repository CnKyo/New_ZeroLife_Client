//
//  ZLPayTypeHeaderView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLPayTypeHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *mLogo;

@property (weak, nonatomic) IBOutlet UILabel *mName;

@property (weak, nonatomic) IBOutlet UILabel *mPricce;

+ (ZLPayTypeHeaderView *)shareView;

@end
