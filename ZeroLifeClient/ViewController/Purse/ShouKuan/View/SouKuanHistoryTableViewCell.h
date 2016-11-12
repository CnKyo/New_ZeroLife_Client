//
//  SouKuanHistoryTableViewCell.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"

@interface SouKuanHistoryTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *nameLable;
@property(nonatomic,strong) UILabel *moneyLable;
@property(nonatomic,strong) UILabel *timeLable;
@property(nonatomic,strong) UILabel *statusLable;
@end
