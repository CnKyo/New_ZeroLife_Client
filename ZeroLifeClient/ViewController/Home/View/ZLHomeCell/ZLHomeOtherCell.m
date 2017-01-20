//
//  ZLHomeOtherCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/2.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLHomeOtherCell.h"
#import "ZLHomeCampFuncView.h"
#import "APIObjectDefine.h"
@interface ZLHomeOtherCell()<ZLHomeCampFuncViewDelegate>

@end

@implementation ZLHomeOtherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setMDataSource:(NSArray *)mDataSource{
    self.contentView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    for (UIView *vvv in self.contentView.subviews) {
        [vvv removeFromSuperview];
    }

    ZLHomeCellType mType = mDataSource.count;
    switch (mType) {
        case ZLHomeFuncOne:
        {
            
            ZLHomeAdvList *mAdv = mDataSource[0];
            UIImageView *mBgk = [UIImageView new];
//            mBgk.backgroundColor = [UIColor redColor];
            [mBgk sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mAdv.adv_image_other]] placeholderImage:ZLDefaultBannerImg];
            mBgk.frame = CGRectMake(5, 5, DEVICE_Width-10, 190);
            [self.contentView addSubview:mBgk];
            
            UIButton *mBtn = [UIButton new];
            mBtn.tintColor = [UIColor clearColor];
            mBtn.frame = CGRectMake(5, 5, DEVICE_Width-10, 190);
            [mBtn setTitleColor:[UIColor clearColor] forState:0];
            mBtn.tag = 0;
            [mBtn addTarget:self action:@selector(mbtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:mBtn];
        }
            break;
        case ZLHomeFuncTwo:
        {
            CGFloat w = self.contentView.mwidth/2;
            CGFloat x = 0;
            for (int i = 0; i<mDataSource.count; i++) {
                
                ZLHomeAdvList *mAdv = mDataSource[i];

                NSString *Icon = nil;
                NSString *Big = nil;
                
                if (Big==nil && mAdv.adv_image_l.length > 0) {
                    Big = mAdv.adv_image_l;
                }
                if (Big==nil && mAdv.adv_image_other) {
                    Big = mAdv.adv_image_l;
                }
                if (Big==nil && mAdv.adv_image_s) {
                    Big = mAdv.adv_image_s;
                }
                
                
                if (Icon==nil && mAdv.adv_image_logo.length > 0) {
                    Icon = mAdv.adv_image_logo;
                }
                if (Icon==nil && mAdv.adv_image_other.length > 0) {
                    Icon = mAdv.adv_image_other;
                }
                
//                if (mAdv.adv_image_l.length<=0) {
//                    Big = mAdv.adv_image;
//                }else if (mAdv.adv_image.length<=0){
//                    Big = nil;
//                }else{
//                    Big = mAdv.adv_image_other;
//                }
                
                

                
//                if (mAdv.adv_image_logo.length<=0) {
//                    Icon = mAdv.adv_image;
//                }else if (mAdv.adv_image_logo.length<=0){
//                    Icon = nil;
//                }else{
//                    Icon = mAdv.adv_image_other;
//                }
                
                
                ZLHomeCampFuncView *mSubView = [ZLHomeCampFuncView initBigView];
                mSubView.frame = CGRectMake(x, 0, w, 200);
                [mSubView.mIcon sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:Icon]] placeholderImage:ZLDefaultAvatorImg];
                [mSubView.mBigImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:Big]] placeholderImage:ZLDefaultGoodsImg];
                
                mSubView.mTitle.text = mAdv.adv_title;
                mSubView.mContent.text = mAdv.adv_desc;
                
                mSubView.mIndex = i;
                mSubView.delegate = self;
                [self.contentView addSubview:mSubView];
                x+=w;
                if (i>=2) {
                    continue;
                }
            }
        }
            break;
        case ZLHomeFuncThree:
        {
            CGFloat w = self.contentView.mwidth/2;
            CGFloat h = 200/2;
            CGFloat x = 0;
            CGFloat y = 0;
            for (int i = 0; i<mDataSource.count; i++) {
                ZLHomeAdvList *mAdv = mDataSource[i];
                NSString *Icon = nil;
                NSString *Big = nil;
                
                if (Big==nil && mAdv.adv_image_l.length > 0) {
                    Big = mAdv.adv_image_l;
                }
                if (Big==nil && mAdv.adv_image_other) {
                    Big = mAdv.adv_image_l;
                }
                if (Big==nil && mAdv.adv_image_s) {
                    Big = mAdv.adv_image_s;
                }
                
                
                if (Icon==nil && mAdv.adv_image_logo.length > 0) {
                    Icon = mAdv.adv_image_logo;
                }
                if (Icon==nil && mAdv.adv_image_other.length > 0) {
                    Icon = mAdv.adv_image_other;
                }
                
                if (i==0) {
                    ZLHomeCampFuncView *mSubView = [ZLHomeCampFuncView initBigView];
                    mSubView.frame = CGRectMake(x, 0, w, 200);
                    [mSubView.mIcon sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:Icon]] placeholderImage:ZLDefaultAvatorImg];
                    [mSubView.mBigImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:Big]] placeholderImage:ZLDefaultGoodsImg];
                    mSubView.mTitle.text = mAdv.adv_title;
//                    mSubView.mContent.text = [NSString stringWithFormat:@"%@%@%@%@%@%@",mAdv.adv_desc,mAdv.adv_desc,mAdv.adv_desc,mAdv.adv_desc,mAdv.adv_desc,mAdv.adv_desc];
                    mSubView.mContent.text = mAdv.adv_desc;

                    mSubView.mIndex = i;
                    mSubView.delegate = self;
                    [self.contentView addSubview:mSubView];
                    
                }else{
                
                    ZLHomeCampFuncView *mSubView = [ZLHomeCampFuncView initImgRightView];
                    mSubView.frame = CGRectMake(w, y, w, h);
                    [mSubView.mIcon sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:Icon]] placeholderImage:ZLDefaultAvatorImg];
                    [mSubView.mBigImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:Big]] placeholderImage:ZLDefaultGoodsImg];                    mSubView.mTitle.text = mAdv.adv_title;
                    mSubView.mContent.text = mAdv.adv_desc;
                    mSubView.mIndex = i;
                    mSubView.delegate = self;
                    [self.contentView addSubview:mSubView];
                }
                if (i==0) {
                    y=0;
                }else{
                    y+=h;
                }
                
            }
        }
            break;
        case ZLHomeFuncFour:
        {
            CGFloat w = DEVICE_Width/2;
            CGFloat h = 200/2;
            CGFloat x = 0;
            CGFloat y = 0;
            for (int i = 0; i<mDataSource.count; i++) {
                ZLHomeAdvList *mAdv = mDataSource[i];
                NSString *Icon = nil;
                NSString *Big = nil;
                
                if (Big==nil && mAdv.adv_image_s) {
                    Big = mAdv.adv_image_s;
                }
                if (Big==nil && mAdv.adv_image_l.length > 0) {
                    Big = mAdv.adv_image_l;
                }
                if (Big==nil && mAdv.adv_image_other) {
                    Big = mAdv.adv_image_l;
                }

                
                if (Icon==nil && mAdv.adv_image_logo.length > 0) {
                    Icon = mAdv.adv_image_logo;
                }
                if (Icon==nil && mAdv.adv_image_other.length > 0) {
                    Icon = mAdv.adv_image_other;
                }
                
                
                ZLHomeCampFuncView *mSubView = [ZLHomeCampFuncView initImgRightView];
                mSubView.frame = CGRectMake(x, y, w, h);
                [mSubView.mIcon sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:Icon]] placeholderImage:ZLDefaultAvatorImg];
                [mSubView.mBigImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:Big]] placeholderImage:ZLDefaultGoodsImg];
                mSubView.mTitle.text = mAdv.adv_title;
                mSubView.mContent.text = mAdv.adv_desc;
                mSubView.mIndex = i;
                mSubView.delegate = self;
                [self.contentView addSubview:mSubView];
                
                x+=w;
                if (x>=DEVICE_Width) {
                    x=0;
                    y+=h;
                }
            }
        }
            break;
        case ZLHomeFuncFive:
        {
            CGFloat w = DEVICE_Width/2;
            CGFloat h = 200/2;
            CGFloat x = 0;
            CGFloat y = 0;
            for (int i = 0; i<mDataSource.count; i++) {
                ZLHomeAdvList *mAdv = mDataSource[i];
                NSString *Icon = nil;
                NSString *Big = nil;
                
                if (i==0) {
                    if (Big==nil && mAdv.adv_image_l.length > 0) {
                        Big = mAdv.adv_image_l;
                    }
                }
                if (Big==nil && mAdv.adv_image_s) {
                    Big = mAdv.adv_image_s;
                }
                if (Big==nil && mAdv.adv_image_l.length > 0) {
                    Big = mAdv.adv_image_l;
                }
                if (Big==nil && mAdv.adv_image_other) {
                    Big = mAdv.adv_image_l;
                }

                
                
                if (Icon==nil && mAdv.adv_image_logo.length > 0) {
                    Icon = mAdv.adv_image_logo;
                }
                if (Icon==nil && mAdv.adv_image_other.length > 0) {
                    Icon = mAdv.adv_image_other;
                }
                
                
                if (i==0) {
                    ZLHomeCampFuncView *mSubView = [ZLHomeCampFuncView initBigView];
                    mSubView.frame = CGRectMake(x, 0, w, 200);
                    [mSubView.mIcon sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:Icon]] placeholderImage:ZLDefaultAvatorImg];
                    [mSubView.mBigImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:Big]] placeholderImage:ZLDefaultGoodsImg];
                    mSubView.mTitle.text = mAdv.adv_title;
                    mSubView.mContent.text = mAdv.adv_desc;
                    mSubView.mIndex = i;
                    mSubView.delegate = self;
                    [self.contentView addSubview:mSubView];
                    
                }else{
                    w = DEVICE_Width/4;
                    ZLHomeCampFuncView *mSubView = [ZLHomeCampFuncView initSmallView];
                    mSubView.frame = CGRectMake(x, y, w, h);
                    [mSubView.mIcon sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:Icon]] placeholderImage:ZLDefaultAvatorImg];
                    [mSubView.mBigImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:Big]] placeholderImage:ZLDefaultGoodsImg];
                    mSubView.mTitle.text = mAdv.adv_title;
                    mSubView.mContent.text = mAdv.adv_desc;
                    mSubView.mIndex = i;
                    mSubView.delegate = self;
                    [self.contentView addSubview:mSubView];
                    
                
                }
                x+=w;
                if (x>=DEVICE_Width) {
                    x=DEVICE_Width/2;
                    y+=h;
                }
            }
        }
            break;
            
        default:
            break;
    }
    
    
    UIView *mLine = [UIView new];
    mLine.frame = CGRectMake(0, 200, DEVICE_Width, 10);
    mLine.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:mLine];
}

- (void)mbtnAction:(UIButton *)sender{

    if ([_delegate respondsToSelector:@selector(ZLHomeOtherCellFuncDidSelectedWithIndex:)]) {
        [_delegate ZLHomeOtherCellFuncDidSelectedWithIndex:sender.tag];
    }
    
}
- (void)ZLHomeCampFuncViewDidSelected:(NSInteger)mIndex{

    if ([_delegate respondsToSelector:@selector(ZLHomeOtherCellFuncDidSelectedWithIndex:)]) {
        [_delegate ZLHomeOtherCellFuncDidSelectedWithIndex:mIndex];
    }
    
}
@end
