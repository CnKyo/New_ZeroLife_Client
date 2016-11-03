//
//  ZLHomeCoupCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/3.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPHotspotLabel.h"
@interface ZLHomeCoupCell : UITableViewCell

/**
 金额
 */
@property (weak, nonatomic) IBOutlet UILabel *mMoney;

/**
 标题
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mTitle;

/**
 内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;

@end
