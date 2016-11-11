//
//  UserIDAuthTableViewCell.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserIDAuthTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *userNameField; //户名
@property (weak, nonatomic) IBOutlet UITextField *cityField; //城市
@property (weak, nonatomic) IBOutlet UITextField *xiaoquField; //小区
@property (weak, nonatomic) IBOutlet UITextField *louchengField; //楼层
@property (weak, nonatomic) IBOutlet UIButton *userIDBtn1;
@property (weak, nonatomic) IBOutlet UIButton *userIDBtn2;
@end
