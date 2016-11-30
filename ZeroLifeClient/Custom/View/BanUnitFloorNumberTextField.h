//
//  BanUnitFloorNumberTextField.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/30.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
// 小区楼栋选择

#import <UIKit/UIKit.h>

@interface BanUnitFloorNumberTextField : UITextField
@property (strong, nonatomic) NSMutableArray*              dataArr;

@property (nonatomic, copy) void (^callBack) (NSString *currentText, int ban, int unit, int floor, int number);  //返回当前选择文字

@end
