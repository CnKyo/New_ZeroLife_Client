//
//  ZLORderReturnCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/21.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 设置代理
 */
@protocol ZLORderReturnCellDelegate <NSObject>

@optional

/**
 提交按钮
 */
- (void)ZLORderReturnCellWithCommitAction;

/**
 备注说明

 @param mText 返回text
 */
- (void)ZLORderReturnCellWithNoteTx:(NSString *)mText;

/**
 原因

 @param mReason 返回原因
 */
- (void)ZLORderReturnCellWithReasonAction:(NSString *)mReason;

/**
 选择图片

 @param mImgArr 返回图片集
 */
- (void)ZLORderReturnCellWithUpLoadImages:(NSMutableArray *)mImgArr;


@end
@interface ZLORderReturnCell : UITableViewCell

#pragma mark----****----维权cell1

/**
 维权原因按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mReasonBtn;

/**
 订单价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderPrice;

@property (weak, nonatomic) IBOutlet UILabel *mContetn;

/**
 备注说明
 */
@property (weak, nonatomic) IBOutlet UITextView *mNote;

@property (strong,nonatomic)NSArray *mReasonArr;

#pragma mark----****----维权cell2

/**
 上传图片view
 */
@property (weak, nonatomic) IBOutlet UIView *mUpLoadImgView;

/**
 图片数组
 */
@property (strong,nonatomic)NSMutableArray *mUpLoadImgArr;

/**
 提交按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCommitBtn;



/**
 设置代理
 */
@property (strong,nonatomic) id<ZLORderReturnCellDelegate>delegate;



@end
