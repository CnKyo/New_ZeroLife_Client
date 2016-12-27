//
//  utilityView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol utilityViewDelegate <NSObject>

@optional

/**
 缴费账号代理方法

 @param mText 返回文本内容
 */
- (void)utilityViewCurrentAmountText:(NSString *)mText;

@end

@interface utilityView : UIView

/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (utilityView *)shareView;
/**
 *  省份按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mProvinceBtn;
/**
 *  城市按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCityBtn;
/**
 *  缴费类型按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mPayType;
/**
 *  缴费单位按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mUnitBtn;

/**
 *  户号
 */
@property (weak, nonatomic) IBOutlet UITextField *mNumTx;
/**
 *  缴费按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mInquireBtn;




/**
 *  初始化查询界面
 *
 *  @return view
 */
+ (utilityView *)shareInquireView;
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mLogo;
/**
 *  支付类型
 */
@property (weak, nonatomic) IBOutlet UILabel *mPaytypeLb;
/**
 *  欠费
 */
@property (weak, nonatomic) IBOutlet UILabel *mArrearsMoneyLb;
/**
 *  省份
 */
@property (weak, nonatomic) IBOutlet UILabel *mProvinceLb;
/**
 *  城市
 */
@property (weak, nonatomic) IBOutlet UILabel *mCityLb;
/**
 *  缴费类型
 */
@property (weak, nonatomic) IBOutlet UILabel *mTypeLb;
/**
 *  单位
 */
@property (weak, nonatomic) IBOutlet UILabel *mUnitLb;
/**
 *  户号
 */
@property (weak, nonatomic) IBOutlet UILabel *mHouseLb;
/**
 *  户名
 */
@property (weak, nonatomic) IBOutlet UILabel *mNameLb;
/**
 *  缴费按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mGoPayBtn;

/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;
+ (utilityView *)shareEmpty;


@property (strong,nonatomic) id<utilityViewDelegate>delegate;

@end
