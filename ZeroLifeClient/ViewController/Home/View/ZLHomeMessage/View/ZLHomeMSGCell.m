//
//  ZLHomeMSGCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/3.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLHomeMSGCell.h"
#import "CustomDefine.h"
@implementation ZLHomeMSGCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{

    [super layoutSubviews];
    self.mBgkView.layer.masksToBounds = YES;
    self.mBgkView.layer.cornerRadius = 5;
}

- (void)setMMessage:(ZLMessageObj *)mMessage{

    self.mPoint.hidden = mMessage.mIsRead?YES:NO;
    self.mTiem.text = mMessage.msg_title;
    self.mContent.text = mMessage.msg_content;
    
    
    
    self.mTitle.text = mMessage.msg_title;
    self.mDetail.text = mMessage.msg_content;
    self.mDetailTime.text = mMessage.msg_auth;
    CGFloat mH = [Util labelText:mMessage.msg_content fontSize:14 labelWidth:self.mDetail.mwidth]+46;
    
    
    self.mCellH = 250+mH;
}

@end
