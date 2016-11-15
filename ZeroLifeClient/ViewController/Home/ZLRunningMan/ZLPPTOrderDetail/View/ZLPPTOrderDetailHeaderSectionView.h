//
//  ZLPPTOrderDetailHeaderSectionView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/15.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLPPTOrderDetailHeaderSectionViewDelegate <NSObject>

@optional

- (void)ZLPPTOrderDetailHeaderSectionViewWithRunnerPhoneAction;

@end

@interface ZLPPTOrderDetailHeaderSectionView : UIView

@property (weak, nonatomic) IBOutlet UILabel *mRunnerName;

@property (weak, nonatomic) IBOutlet UIButton *mRunnerPhone;

@property (strong, nonatomic) id <ZLPPTOrderDetailHeaderSectionViewDelegate>delegate;


+ (ZLPPTOrderDetailHeaderSectionView *)initFirstView;

+ (ZLPPTOrderDetailHeaderSectionView *)initSecondView;

@end
