//
//  ZLAnounceMentCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/22.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLAnounceMentCell.h"

@implementation ZLAnounceMentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.mView.layer.masksToBounds = YES;
    self.mView.layer.cornerRadius = 5;
    self.mView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.mView.layer.borderWidth = 0.5;
    
    self.mTime.layer.masksToBounds = YES;
    self.mTime.layer.cornerRadius = 3;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMAnouncement:(ZLHomeAnouncement *)mAnouncement{

    self.mTime.text = mAnouncement.not_add_time;
    self.mTitle.text = mAnouncement.not_title;
    self.mSubTitle.text = mAnouncement.not_add_person;

    [self.mImg sd_setImageWithURL:[NSURL imageurl:mAnouncement.not_image] placeholderImage:ZLDefaultBannerImg];
    self.mContent.text = mAnouncement.not_sub;
    self.mDate.text = mAnouncement.not_deadline;
    
    
}

@end
