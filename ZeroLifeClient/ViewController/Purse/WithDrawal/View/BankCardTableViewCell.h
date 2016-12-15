//
//  BankCardTableViewCell.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"

@interface BankCardTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView *bankImgView;
@property(nonatomic,strong) UILabel *bankNameLable;
@property(nonatomic,strong) UILabel *cardTypeLable;
@property(nonatomic,strong) UILabel *cardNumberLable;
@property(nonatomic,strong) UIButton *deleteBtn;
@end
