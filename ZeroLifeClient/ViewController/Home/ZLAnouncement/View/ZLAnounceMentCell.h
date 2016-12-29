//
//  ZLAnounceMentCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/22.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"
@interface ZLAnounceMentCell : UITableViewCell

/**
 时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;

/**
 背景view
 */
@property (weak, nonatomic) IBOutlet UIView *mView;

/**
 标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mTitle;

/**
 子标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mSubTitle;

/**
 日期
 */
@property (weak, nonatomic) IBOutlet UILabel *mDate;

/**
 图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImg;

/**
 内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;


@property (strong,nonatomic) ZLHomeAnouncement *mAnouncement;

@end
