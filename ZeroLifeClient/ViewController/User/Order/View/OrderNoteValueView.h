//
//  OrderNoteValueView.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"

@interface OrderNoteValueView : UIView
@property(nonatomic,strong) UILabel *noteLable;
@property(nonatomic,strong) UILabel *valueLable;

-(void)loadNotestr:(NSString *)note valueStr:(NSString *)value;

@end
