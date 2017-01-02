//
//  ZLSuperMarketShopLeftCellType1.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"
@interface ZLSuperMarketShopLeftCellType : UITableViewCell

/**
 图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *mLogo;

/**
 内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;

/**
 内容左边的约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mContentLeftContraint;

@property (strong,nonatomic) ZLShopClassify *mClassify;
@property (strong,nonatomic) ZLShopCampain *mCampain;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mImgW;


@end
