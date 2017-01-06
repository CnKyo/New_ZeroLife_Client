//
//  ZLPPTReleaseGeneryCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/16.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"
#import <IQTextView.h>
/**
 设置代理
 */
@protocol ZLPPTReleaseGeneryCellDelegate <NSObject>

@optional
///办理时间代理方法
- (void)ZLPPTReleaseGeneryCellWithWorkTimeBtnClicked:(NSString *)mTime;
///送达地址代理方法
- (void)ZLPPTReleaseGeneryCellWithArriveTimeBtnClicked;

/**
 需求代理方法

 @param mDemand 返回string
 */
- (void)ZLPPTReleaseGeneryCellWithDemand:(NSString *)mDemand;

/**
 商品价格代理方法

 @param mProductPrice 返回string
 */
- (void)ZLPPTReleaseGeneryCellWithProductPrice:(NSString *)mProductPrice;

/**
 联系方式和备注代理方法

 @param mConnect 联系方式
 */
- (void)ZLPPTReleaseGeneryCellWithConnect:(NSString *)mConnect;
/**
 联系方式和备注代理方法
 
 @param mNote 备注
 */
- (void)ZLPPTReleaseGeneryCellWithNote:(NSString *)mNote;


@end

@interface ZLPPTReleaseGeneryCell : UITableViewCell

#pragma mark----****----通用cell1
///需求tx
@property (weak, nonatomic) IBOutlet IQTextView *mDemandTx;
///价格tx
@property (weak, nonatomic) IBOutlet UITextField *mProductPrice;

#pragma mark----****----通用cell2
///服务时间
@property (weak, nonatomic) IBOutlet UIButton *mWorkTime;
///送达地址
@property (weak, nonatomic) IBOutlet UIButton *mArriveAddress;
///联系方式
@property (weak, nonatomic) IBOutlet UITextField *mConnectTx;
///备注
@property (weak, nonatomic) IBOutlet UITextField *mNoteTx;
///设置代理
@property (strong, nonatomic) id<ZLPPTReleaseGeneryCellDelegate>delegate;

@property (strong,nonatomic) ZLCommitPPTPreOrder *mPreOrder;

@end



