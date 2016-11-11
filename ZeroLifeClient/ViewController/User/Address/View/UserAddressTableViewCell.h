//
//  UserAddressTableViewCell.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"

@interface UserAddressTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel *nameLable;
@property(nonatomic,strong) UILabel *addressLable;
@property(nonatomic,strong) UIButton *chooseBtn;
@property(nonatomic,strong) UIButton *delBtn;
@property(nonatomic,strong) UIButton *editBtn;
@end
