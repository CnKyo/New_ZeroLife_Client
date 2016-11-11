//
//  PlurseValueNameControl.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"

@interface PlurseValueNameControl : UIControl
@property(nonatomic,strong) UILabel *valueLable;
@property(nonatomic,strong) UILabel *nameLable;

-(void)loadName:(NSString *)nameStr value:(NSString *)valueStr;

@end
