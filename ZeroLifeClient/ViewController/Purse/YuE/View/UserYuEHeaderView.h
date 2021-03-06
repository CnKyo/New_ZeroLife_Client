//
//  UserYuEHeaderView.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"

@interface UserYuEHeaderView : UIView
@property(nonatomic,strong) UILabel *noteELable;
@property(nonatomic,strong) UILabel *yuELable;
@property(nonatomic,strong) UIButton *chongZiBtn;


-(void)setYuEStyle;
-(void)setScoreStyle;

-(void)loadYuEMoney:(NSString *)moneyStr;
-(void)loadUserScore:(NSString *)scoreStr;
@end
