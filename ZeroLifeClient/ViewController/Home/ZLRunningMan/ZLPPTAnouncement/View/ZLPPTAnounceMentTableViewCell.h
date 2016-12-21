//
//  ZLPPTAnounceMentTableViewCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"
@interface ZLPPTAnounceMentTableViewCell : UITableViewCell

/**
 等级图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mLevelImg;

/**
 头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHeaderImg;

/**
 名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;

/**
 接单数
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderNum;

/**
 内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;

/**
 等级
 */
@property (weak, nonatomic) IBOutlet UILabel *mLevel;

@property (strong,nonatomic) ZLPPTRKLObj *mTopObj;


@end
