//
//  ZLPPTMyOrderHeaderView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLPPTMyOrderHeaderViewDelegate <NSObject>

@optional

- (void)ZLPPTMyOrderHeaderViewBtnWithClicked;

@end

@interface ZLPPTMyOrderHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *mBtn;


+ (ZLPPTMyOrderHeaderView *)shareView;

@property (weak, nonatomic) id<ZLPPTMyOrderHeaderViewDelegate>delegate;

@end
