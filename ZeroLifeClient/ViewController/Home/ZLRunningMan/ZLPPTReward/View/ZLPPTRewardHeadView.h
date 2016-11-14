//
//  ZLPPTRewardHeadView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomDefine.h"
@interface ZLPPTRewardHeadView : UIView

@property (weak, nonatomic) IBOutlet WPHotspotLabel *mRewardMoney;

+ (ZLPPTRewardHeadView *)shareView;


@end
