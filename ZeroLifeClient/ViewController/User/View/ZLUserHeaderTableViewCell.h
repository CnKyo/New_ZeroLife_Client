//
//  ZLUserHeaderTableViewCell.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLUserHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImgView; //用户头像
@property (weak, nonatomic) IBOutlet UILabel *userNameLable; //用户姓名
@property (weak, nonatomic) IBOutlet UILabel *userNoteLable; //用户信息
@property (weak, nonatomic) IBOutlet UILabel *userMobileLable; //用户手机号

@property (weak, nonatomic) IBOutlet UIView *paopaoRegisterView; //跑跑注册view

@property (weak, nonatomic) IBOutlet UIView *paopaoInfoView; //跑跑资料view
@property (weak, nonatomic) IBOutlet UIProgressView *paopaoProgressView; //跑跑等级进度view
@property (weak, nonatomic) IBOutlet UILabel *paopaoLevelLable; //跑跑等级

@end
