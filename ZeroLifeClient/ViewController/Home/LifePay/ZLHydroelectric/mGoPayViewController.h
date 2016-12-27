//
//  mGoPayViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/18.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface mGoPayViewController : BaseVC

@property (nonatomic,assign) int mType;

@property (nonatomic,strong) NSString *mTitel;

/**
 *  省份
 */
@property (nonatomic,strong) NSString *mProvince;
/**
 *  城市
 */
@property (nonatomic,strong) NSString *mCity;
/**
 *  缴费类型
 */
@property (nonatomic,strong) NSString *mPayType;
/**
 *  单位
 */
@property (nonatomic,strong) NSString *mUnit;
/**
 *  户号
 */
@property (nonatomic,strong) NSString *mHouseNum;
/**
 *  户名
 */
@property (nonatomic,strong) NSString *mName;

/**
 *  要传递的参数
 */
@property (nonatomic,strong) NSMutableDictionary *mPara;


@end
