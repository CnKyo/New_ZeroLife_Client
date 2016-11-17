//
//  ZLPPTRewardCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/16.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 设置代理
 */
@protocol ZLPPTRewardCellDelegate <NSObject>

@optional

/**
 选择跑腿酬金

 @param mReward 返回string
 */
- (void)ZLPPTRewardCellWithRewardBtnDidClicked:(NSString *)mReward;

/**
 自定义跑腿酬金

 @param mCustomReward 返回string
 */
- (void)ZLPPTRewardCellWithRewardCustom:(NSString *)mCustomReward;

@end

@interface ZLPPTReleaseRewardCell : UITableViewCell

/**
 3元
 */
@property (weak, nonatomic) IBOutlet UIButton *mThreeBtn;

/**
 5元
 */
@property (weak, nonatomic) IBOutlet UIButton *mFiveBtn;

/**
 10元
 */
@property (weak, nonatomic) IBOutlet UIButton *mTenBtn;

/**
 15元
 */
@property (weak, nonatomic) IBOutlet UIButton *mFifteenBtn;

/**
 20元
 */
@property (weak, nonatomic) IBOutlet UIButton *mTwentyBtn;

/**
 自定义tx
 */
@property (weak, nonatomic) IBOutlet UITextField *mCustomTx;

/**
 设置代理
 */
@property (strong, nonatomic) id<ZLPPTRewardCellDelegate>delegate;


@end
