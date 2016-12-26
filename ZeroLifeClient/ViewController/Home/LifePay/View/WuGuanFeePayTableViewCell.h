//
//  WuGuanFeePayTableViewCell.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/26.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"
#import <JKCategories/UIButton+JKBackgroundColor.h>


@interface WuGuanFeePayTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel *pfee_companyLable;
@property(nonatomic,strong) UILabel *pfee_titleLable;
@property(nonatomic,strong) UILabel *pfee_costsLable;
@property(nonatomic,strong) UILabel *pfee_nameLable;
@property(nonatomic,strong) UILabel *pfee_menpaiLable;
@property(nonatomic,strong) UILabel *pfee_endtimeLable;

@property(nonatomic,strong) UIButton *actionBtn;
@end
