//
//  ZLCommitRepairsCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"
/**
 设置代理
 */
@protocol ZLCommitRepairsCellDelegate <NSObject>

@optional

/**
 选择地址代理方法
 */
- (void)ZLCommitRepairsCellWithAddressAction;

/**
 服务时间
 */
- (void)ZLCommitRepairsCellWithTimeAction:(NSString *)mDate;

/**
 优惠券
 */
- (void)ZLCommitRepairsCellWithCoupAction;

/**
 上传图片
 */
- (void)ZLCommitRepairsCellWithUpLoadImgAction;

/**
 上传视频
 */
- (void)ZLCommitRepairsCellWithUpLoadVideoAction;

/**
 提交
 */
- (void)ZLCommitRepairsCellWithCommitAction;

/**
 提交备注信息

 @param mRemark 返回备注
 */
- (void)ZLCommitRepairsCellWithRemark:(NSString *)mRemark;

@end

@interface ZLCommitRepairsCell : UITableViewCell

/**
 地址名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddressName;

/**
 地址详情
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddressContent;

@property (weak, nonatomic) IBOutlet UILabel *mDisplayAddress;


/**
 选择地址按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mSelectedAddress;

/**
 选择时间按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mTimeBtn;

/**
 选择优惠券按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCoupBtn;

/**
 保证金
 */
@property (weak, nonatomic) IBOutlet UILabel *mEnsureMoney;

/**
 服务图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mServiceImg;

/**
 服务名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mServiceName;

/**
 服务内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mServiceContent;

/**
 上传图片
 */
@property (weak, nonatomic) IBOutlet UIButton *mUploadImgBtn;

/**
 上传视频
 */
@property (weak, nonatomic) IBOutlet UIButton *mUpLoadVideoBtn;

/**
 备注
 */
@property (weak, nonatomic) IBOutlet UITextField *mNoteTx;

/**
 提交
 */
@property (weak, nonatomic) IBOutlet UIButton *mCommitBtn;

/**
 设置代理
 */
@property (weak, nonatomic) id<ZLCommitRepairsCellDelegate>delegate;


@property (strong,nonatomic) ZLCreatePreOrder *mPreOrder;

@end
