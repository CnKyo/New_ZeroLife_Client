//
//  FavoriteTableViewCell.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/8.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"

@interface FavoriteTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView *iconImgView;
@property(nonatomic,strong) UILabel *nameLable;
@property(nonatomic,strong) UILabel *timeLable;
@property(nonatomic,strong) UILabel *msgLable;
@property(nonatomic,strong) UILabel *priceLable;
@property(nonatomic,strong) UILabel *goodLable;
@end
