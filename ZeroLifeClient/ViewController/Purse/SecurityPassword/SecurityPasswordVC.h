//
//  SecurityPasswordVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"

@interface NewTextField : UITextField

@end

@interface SecurityPasswordView : UIView
@property(nonatomic,strong) NewTextField *field;
@property(nonatomic,strong) NSMutableString *pwStr;
@end



@interface SecurityPasswordVC : CustomVC

@end
