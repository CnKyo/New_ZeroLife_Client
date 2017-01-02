//
//  ZLPPTRateCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/15.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTRateCell.h"
#import "CustomProgress.h"

@interface ZLPPTRateCell ()



@end

@implementation ZLPPTRateCell
{
    NSTimer *mGoodTimer;
    NSTimer *mMidTimer;
    NSTimer *mBadTimer;
    
    CustomProgress *mGoodProgress;
    
    CustomProgress *mMidProgress;
    
    CustomProgress *mBadProgress;
    
    int mGood;
    
    int mMid;
    
    int mBad;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setMExt:(OrderCommentExtraObject *)mExt{

    
    self.mTotlerate.text = [NSString stringWithFormat:@"%d",mExt.totalScore];
    
    mGoodProgress = [[CustomProgress alloc] initWithFrame:CGRectMake(0, 0, self.mGoodsRateView.mwidth, self.mGoodsRateView.mheight) andType:2];
    
    mGoodProgress.mType = 2;
    mGoodProgress.maxValue = mExt.evaluate*10;
    //设置背景色
    mGoodProgress.bgimg.backgroundColor =[UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1];
    mGoodProgress.leftimg.backgroundColor =[UIColor colorWithRed:0.93 green:0.22 blue:0.21 alpha:1.00];
    
    mGoodProgress.presentlab.textColor = [UIColor redColor];
    [self.mGoodsRateView addSubview:mGoodProgress];
    
    mMidProgress = [[CustomProgress alloc] initWithFrame:CGRectMake(0, 0, self.mMidRateView.mwidth, self.mMidRateView.mheight) andType:2];
    
    mMidProgress.mType = 2;
    
    mMidProgress.maxValue = mExt.favourable*10;
    //设置背景色
    mMidProgress.bgimg.backgroundColor =[UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1];
    mMidProgress.leftimg.backgroundColor =[UIColor colorWithRed:1.00 green:0.56 blue:0.56 alpha:1.00];
    
    mMidProgress.presentlab.textColor = [UIColor redColor];
    [self.mMidRateView addSubview:mMidProgress];
    
    mBadProgress = [[CustomProgress alloc] initWithFrame:CGRectMake(0, 0, self.mBadRateView.mwidth, self.mBadRateView.mheight) andType:2];
    
    mBadProgress.mType = 2;
    
    
    mBadProgress.maxValue = mExt.negative*10;
    //设置背景色
    mBadProgress.bgimg.backgroundColor =[UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1];
    mBadProgress.leftimg.backgroundColor =[UIColor colorWithRed:0.34 green:0.34 blue:0.34 alpha:1.00];
    
    mBadProgress.presentlab.textColor = [UIColor redColor];
    [self.mBadRateView addSubview:mBadProgress];

    
    mGoodTimer =[NSTimer scheduledTimerWithTimeInterval:0.02
                                                 target:self
                                               selector:@selector(goodtimer)
                                               userInfo:nil
                                                repeats:YES];
    mMidTimer =[NSTimer scheduledTimerWithTimeInterval:0.02
                                                target:self
                                              selector:@selector(midtimer)
                                              userInfo:nil
                                               repeats:YES];
    mBadTimer =[NSTimer scheduledTimerWithTimeInterval:0.02
                                                target:self
                                              selector:@selector(badtimer)
                                              userInfo:nil
                                               repeats:YES];

    
    
}
-(void)goodtimer
{
    mGood++;
    if (mGood<=_mOne) {
        
        [mGoodProgress setPresent:mGood];
        
    }
    else
    {
        
        [mGoodTimer invalidate];
        mGoodTimer = nil;
        mGood = 0;
    }
    
    
}
-(void)midtimer
{
    mMid++;
    if (mMid<=_mTwo) {
        
        [mMidProgress setPresent:mMid];
        
    }
    else
    {
        
        [mMidTimer invalidate];
        mMidTimer = nil;
        mMid = 0;
    }
    
    
}
-(void)badtimer
{
    mBad++;
    if (mBad<=_mThree) {
        
        [mBadProgress setPresent:mBad];
        
    }
    else
    {
        
        [mBadTimer invalidate];
        mBadTimer = nil;
        mBad = 0;
    }
    
    
}


- (void)setMRate:(OrderCommentObject *)mRate{

    
    [self.mHeaderImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mRate.user_header]] placeholderImage:ZLDefaultAvatorImg];
    self.mName.text = mRate.user_nike;
    self.mTime.text = mRate.com_add_time;
    self.mContent.text = mRate.com_content;
    
    int mStars = [[NSString stringWithFormat:@"%f",mRate.com_star] intValue];
    
    for (UIView *vv  in self.mStarView.subviews) {
        [vv removeFromSuperview];
    }
    
    int x = 0;
    
    for ( int i = 0; i<mStars; i++) {
        if (i>=5) {
            continue;
        }
        UIImageView *mStar = [UIImageView new];
        mStar.frame = CGRectMake(x, 0, 20, 20);
        mStar.image = IMG(@"btn_star_evaluation_press");
        [self.mStarView addSubview:mStar];
        x+=25;
    }
    
    for (UIView *vv  in self.mImgView.subviews) {
        [vv removeFromSuperview];
    }
    
    if ([Util wk_StringToArr:mRate.com_imgs]) {
    
        int x = 0;
        
        NSArray *mImgS = [Util wk_StringToArr:mRate.com_imgs];
        
        for ( int i = 0; i<mImgS.count; i++) {
            if (i>=3) {
                continue;
            }
            UIImageView *mStar = [UIImageView new];
            mStar.frame = CGRectMake(x, 0, 60, 60);
            [mStar sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mImgS[i]]] placeholderImage:ZLDefaultAvatorImg];
            [self.mImgView addSubview:mStar];
            x+=65;
        }
    }

    
}

@end
