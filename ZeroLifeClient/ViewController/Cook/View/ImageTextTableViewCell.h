//
//  ImageTextTableViewCell.h
//  StaffTraining
//
//  Created by 瞿伦平 on 16/5/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"

@interface ImageTextTableViewCell : UITableViewCell
@property(strong, nonatomic) UIImageView*       iconImgView;
@property(strong, nonatomic) UILabel*           text1Lable;
@property(strong, nonatomic) UILabel*           text2Lable;
@end
