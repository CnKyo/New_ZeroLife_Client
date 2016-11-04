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

- (void)setMModel:(NSString *)mModel{
    self.mDetail.text = mModel;
    CGFloat mH = [Util labelText:mModel fontSize:15 labelWidth:self.mDetail.mwidth]+18;

    self.mCellH = 200+mH;

    
}

@end
