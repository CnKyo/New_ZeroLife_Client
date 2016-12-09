//
//  ZLHomeMSGCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/3.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"


@interface ZLHomeMSGCell : UITableViewCell
#pragma mark ----****----消息列表cell样式
/**
 未读消息红点
 */
@property (weak, nonatomic) IBOutlet UIImageView *mPoint;

/**
 消息图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *mMsgType;

/**
 时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTiem;

/**
 内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;

#pragma mark ----****----消息详情cell样式

/**
 背景view
 */
@property (weak, nonatomic) IBOutlet UIView *mBgkView;
/**
 标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mTitle;

/**
 详情内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mDetail;

/**
 时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mDetailTime;

/**
 查看按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCheckBtn;

/**
 cell的高
 */
@property (assign,nonatomic) CGFloat mCellH;

///消息对象
@property (strong,nonatomic) ZLMessageObj *mMessage;


@end
