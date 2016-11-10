//
//  BaoXiuChooseShopTableViewCell.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"
#import "RatingBar.h"

@interface BaoXiuChooseShopTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *nameLable;
@property(nonatomic,strong) UILabel *priceLable;
@property(nonatomic,strong) RatingBar *ratingBarView;
@property(nonatomic,strong) UIButton *chooseBtn;
@property(nonatomic,strong) UILabel *extensionLable1;
@property(nonatomic,strong) UILabel *extensionLable2;
@property(nonatomic,strong) UILabel *extensionLable3;
@end
