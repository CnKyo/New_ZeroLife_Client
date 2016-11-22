//
//  ZLRatingTableViewCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/22.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 设置代理
 */
@protocol ZLRatingTableViewCellDelegate  <NSObject>

@optional

/**
 评分

 @param mRateNum 返回评分数
 */
- (void)ZLRatingTableViewCellWithRateNum:(int)mRateNum;

/**
 评价内容

 @param mText 返回内容
 */
- (void)ZLRatingTableViewCellWithRateContent:(NSString *)mText;

/**
 上传的图片

 @param mImgArr 返回图片数组
 */
- (void)ZLRatingTableViewCellWithImagesArr:(NSMutableArray *)mImgArr;


@end

@interface ZLRatingTableViewCell : UITableViewCell

/**
 头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImg;

/**
 标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mTitle;

/**
 内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;

/**
 评价view
 */
@property (weak, nonatomic) IBOutlet UIView *mRateView;

/**
 评价内容背景色
 */
@property (weak, nonatomic) IBOutlet UIView *mRateBgkView;

/**
 评价输入框
 */
@property (weak, nonatomic) IBOutlet UITextView *mRateTxView;

/**
 上传图片view
 */
@property (weak, nonatomic) IBOutlet UIView *mLoadImgView;

/**
 设置代理
 */
@property (strong,nonatomic) id<ZLRatingTableViewCellDelegate>delegate;

@end
