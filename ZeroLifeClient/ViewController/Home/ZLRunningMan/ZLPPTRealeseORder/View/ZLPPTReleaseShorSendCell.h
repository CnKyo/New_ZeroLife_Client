//
//  ZLPPTReleaseShorSendCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/16.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"
/**
 设置代理
 */
@protocol ZLPPTReleaseShorSendCellDelegate <NSObject>

@optional


/**
 送出地址代理方法
 */
- (void)ZLPPTReleaseShorSendCellWithSendAddressAction;

/**
 送达地址代理方法
 */
- (void)ZLPPTReleaseShorSendCellWithArriveAddressAction;

/**
 服务时间代理方法
 */
- (void)ZLPPTReleaseShorSendCellWithWorkTimeBtnAction:(NSString *)mTime;

/**
 物品名称代理方法

 @param mProductName 返回string
 */
- (void)ZLPPTReleaseShorSendCellWithProductNameTx:(NSString *)mProductName;

/**
 备注代理方法

 @param mNote 返回string
 */
- (void)ZLPPTReleaseShorSendCellWithNoteTx:(NSString *)mNote;


@end

@interface ZLPPTReleaseShorSendCell : UITableViewCell

#pragma mark----****----短程配送cell样式1

/**
 送出地址的姓名电话
 */
@property (weak, nonatomic) IBOutlet UILabel *mSendNamePhone;

/**
 送出地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mSendAddress;

/**
 送出地址按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mSendAddressBtn;

/**
 送达地址的姓名电话
 */
@property (weak, nonatomic) IBOutlet UILabel *mArriveNamePhone;

/**
 送达地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mArriveAddress;

/**
 送达地址按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mArriveAddressBtn;

/**
 服务时间
 */
@property (weak, nonatomic) IBOutlet UIButton *mworkTime;

/**
 物品名称
 */
@property (weak, nonatomic) IBOutlet UITextField *mProductNameTx;

/**
 备注
 */
@property (weak, nonatomic) IBOutlet UITextField *mNoteTx;


#pragma mark----****----短程配送cell样式2

/**
 说明
 */
@property (weak, nonatomic) IBOutlet UILabel *mExplainLb;

/**
 cell高度
 */
@property (assign,nonatomic) CGFloat mCellH;

/**
 设置代理
 */
@property (strong,nonatomic) id<ZLPPTReleaseShorSendCellDelegate>delegate;

@property (strong,nonatomic) ZLCommitPPTPreOrder *mPreOrder;

@end
