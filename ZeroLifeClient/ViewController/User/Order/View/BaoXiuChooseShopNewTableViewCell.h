//
//  BaoXiuChooseShopNewTableViewCell.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/30.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"
#import "RatingBar.h"

@interface BaoXiuChooseShopNewTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *nameLable;
@property(nonatomic,strong) UILabel *priceLable;
@property(nonatomic,strong) UILabel *salesMonthLable;

@property(nonatomic,strong) RatingBar *ratingBarView;
@property(nonatomic,strong) UIButton *chooseBtn;

@end
