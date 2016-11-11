//
//  UserYuETableViewCell.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"

@interface UserYuETableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *msgLable;
@property(nonatomic,strong) UILabel *moneyLable;
@property(nonatomic,strong) UILabel *timeLable;
@end
