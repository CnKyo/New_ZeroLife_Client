//
//  UserHouseEditTableViewCell.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"
#import "BanUnitFloorNumberTextField.h"

@protocol UserHouseEditTableViewCellDelegate <NSObject>

@optional

- (void)UserHouseEditTableViewCellSelectedCityBtnClicked;

@end

@interface UserHouseEditTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *realNameField;   // 姓名
@property (weak, nonatomic) IBOutlet UIButton *sexManBtn;
@property (weak, nonatomic) IBOutlet UIButton *sexWomanBtn;
@property (weak, nonatomic) IBOutlet UITextField *mobileField;  // 手机号
@property (weak, nonatomic) IBOutlet UITextField *areaField;    // 地区地址
@property (weak, nonatomic) IBOutlet UIView *areaView;

@property (weak, nonatomic) IBOutlet UITextField *xiaoquField;  //小区
@property (weak, nonatomic) IBOutlet UIView *xiaoquView;

@property (weak, nonatomic) IBOutlet BanUnitFloorNumberTextField *addressField; // 详细地址
@property (weak, nonatomic) IBOutlet UIView *addressView;

@property (weak, nonatomic) IBOutlet UISwitch *defaultAddressSwitch;

@property (weak, nonatomic) IBOutlet UIButton *mSelectedCityBtn;

@property (weak, nonatomic) id<UserHouseEditTableViewCellDelegate>delegate;

-(void)reloadSexUI:(kUserSexType)sex;

@end




