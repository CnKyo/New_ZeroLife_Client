//
//  UserHouseTableViewCell.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"

@protocol UserAddressEditTableViewCellDelegate <NSObject>

@optional

- (void)UserAddressEditTableViewCellSelectedCityClicked;

@end

@interface UserAddressEditTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *consigneeField;   // 收货人姓名
@property (weak, nonatomic) IBOutlet UIButton *sexManBtn;
@property (weak, nonatomic) IBOutlet UIButton *sexWomanBtn;
@property (weak, nonatomic) IBOutlet UITextField *mobileField;  // 手机号
@property (weak, nonatomic) IBOutlet UITextField *areaField;    // 地区地址
@property (weak, nonatomic) IBOutlet UITextField *addressField; // 详细地址
@property (weak, nonatomic) IBOutlet UISwitch *defaultAddressSwitch;

@property (weak, nonatomic) IBOutlet UIButton *mSelectedCityBtn;

@property (weak, nonatomic)id<UserAddressEditTableViewCellDelegate>delegate;

-(void)reloadSexUI:(kUserSexType)sex;

@end

