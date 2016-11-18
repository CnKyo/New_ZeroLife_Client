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
    CGFloat mH = [Util labelText:mModel fontSize:14 labelWidth:self.mDetail.mwidth]+46;

      
    self.mCellH = 250+mH;

    
//    
//    for (UIView *vvv in self.contentView.subviews) {
//        [vvv removeFromSuperview];
//    }
//    
//    for (UILabel *lll in self.contentView.subviews) {
//        [lll removeFromSuperview];
//    }
//    
//    
//    UIView *mBgkV = [UIView new];
//    mBgkV.backgroundColor = [UIColor whiteColor];
//    [self.contentView addSubview:mBgkV];
//    
//    
//    UILabel *mTitleL = [UILabel new];
//    mTitleL.textColor = [UIColor colorWithRed:0.23 green:0.23 blue:0.23 alpha:1.00];
//    mTitleL.font = [UIFont systemFontOfSize:15];
//    mTitleL.textAlignment = NSTextAlignmentCenter;
//    [mBgkV addSubview:mTitleL];
//    
//    UIView *mLine1 = [UIView new];
//    mLine1.backgroundColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.96 alpha:1.00];
//    [mBgkV addSubview:mLine1];
//    
//    
//    UILabel *mContentL = [UILabel new];
//    mContentL.textColor = [UIColor colorWithRed:0.25 green:0.24 blue:0.25 alpha:1.00];
//    mContentL.font = [UIFont systemFontOfSize:15];
//    mContentL.textAlignment = NSTextAlignmentLeft;
//    [mBgkV addSubview:mContentL];
//    
//    UILabel *mTimeL = [UILabel new];
//    mTimeL.textColor = [UIColor colorWithRed:0.25 green:0.24 blue:0.25 alpha:1.00];
//    mTimeL.font = [UIFont systemFontOfSize:15];
//    mTimeL.textAlignment = NSTextAlignmentRight;
//    [mBgkV addSubview:mTimeL];
//    
//    UIView *mLine2 = [UIView new];
//    mLine2.backgroundColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.96 alpha:1.00];
//    [mBgkV addSubview:mLine2];
//    
//    UIButton *mDetailBtn = [UIButton new];
//    [mDetailBtn setTitle:@"查看详情>>" forState:0];
//    [mDetailBtn setTitleColor:[UIColor colorWithRed:0.25 green:0.24 blue:0.25 alpha:1.00] forState:0];
//    [mBgkV addSubview:mDetailBtn];
//    
//    [mBgkV makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.equalTo(self.contentView).offset(-5);
//    }];
//    
//    [mTitleL makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(mBgkV).offset(0);
//        make.bottom.equalTo(mLine1.top).offset(0);
//        make.height.offset(20);
//    }];
//    
//    [mLine1 makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(mBgkV).offset(-5);
//        make.top.equalTo(mTitleL.bottom).offset(0);
//        make.bottom.equalTo(mContentL.top).offset(0);
//        make.height.offset(@1);
//    }];
//    
//    [mContentL makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(mBgkV).offset(-5);
//        make.top.equalTo(mLine1.bottom).offset(0);
//        make.bottom.equalTo(mTimeL.top).offset(0);
//
//    }];
//    
//    [mTimeL makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(mBgkV).offset(0);
//        make.top.equalTo(mContentL.bottom).offset(0);
//        make.bottom.equalTo(mLine2.top).offset(0);
//        make.height.offset(20);
//    }];
//    
//    [mLine2 makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(mBgkV).offset(-5);
//        make.top.equalTo(mTimeL.bottom).offset(0);
//        make.bottom.equalTo(mDetailBtn.top).offset(0);
//        make.height.offset(@1);
//    }];
//    
//    [mDetailBtn makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(mBgkV).offset(-5);
//        make.top.equalTo(mLine2.bottom).offset(0);
//        make.bottom.equalTo(mBgkV).offset(0);
//        make.height.offset(@40);
//    }];
}

@end
