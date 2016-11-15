//
//  DryCleanTimeChooseView.h
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "DryCleanOrderChooseTimeVC.h"

@interface DryCleanTimeChooseBtn : UIButton
@property(nonatomic, strong) TimeObject *item;
@end



@interface DryCleanTimeChooseView : UIView
@property(nonatomic, strong) NSArray *arr;

-(void)loadUIWithTitleArr:(NSArray *)arr chooseTime:(NSString *)timeStr;

@property (nonatomic, copy) void (^chooseCallBack)(NSString* timeStr);

@end
