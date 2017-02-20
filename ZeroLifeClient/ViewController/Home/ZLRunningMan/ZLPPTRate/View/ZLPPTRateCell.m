//
//  ZLPPTRateCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/15.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTRateCell.h"
#import "CustomProgress.h"
#import "MJPhotoBrowser.h"

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

    self.mImgArr = [NSMutableArray new];
    
    [self.mHeaderImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mRate.user_header]] placeholderImage:ZLDefaultAvatorImg];
    self.mName.text = mRate.user_nike;
    self.mTime.text = mRate.com_add_time;
    self.mContent.text = mRate.com_content;
    
    int mStars = [[NSString stringWithFormat:@"%f",mRate.com_star] intValue];
    
    for (UIView *vv  in self.mStarView.subviews) {
        [vv removeFromSuperview];
    }
    
    for (UIImageView *mImg in self.mImgView.subviews) {
        [mImg removeFromSuperview];
    }
    
    int x = 0;
    
    for ( int i = 0; i<mStars; i++) {
        if (i>=5) {
            continue;
        }
        UIImageView *mStar = [UIImageView new];
        mStar.frame = CGRectMake(x, 0, 15, 15);
        mStar.image = IMG(@"ZLRate_Heart");
        [self.mStarView addSubview:mStar];
        x+=25;
    }
    
    for (UIView *vv  in self.mImgView.subviews) {
        [vv removeFromSuperview];
    }
    
    if ([Util wk_StringToArr:mRate.com_imgs]) {
        int x = 0;
    
        NSArray *mImgS = [Util wk_StringToArr:mRate.com_imgs];

        [self.mImgArr addObjectsFromArray:mImgS];

        for ( int i = 0; i<mImgS.count; i++) {
            if (i>=3) {
                continue;
            }
            NSString *mUrl = self.mImgArr[i];
            UIImageView *mImg = [UIImageView new];
            mImg.frame = CGRectMake(x, 0, 60, 60);
            mImg.backgroundColor = [UIColor redColor];
            mImg.tag = i;
            mImg.userInteractionEnabled = YES;
            [mImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            
            mImg.clipsToBounds = YES;
            mImg.contentMode = UIViewContentModeScaleAspectFill;

            [mImg setImageURLStr:[Util currentSourceImgUrl:mUrl] placeholder:ZLDefaultAvatorImg];

            [self.mImgView addSubview:mImg];
            x+=65;
        }
    }

}
- (void)tapImage:(UITapGestureRecognizer *)tap{
    NSInteger count = self.mImgArr.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        if (i>=3) {
            continue;
        }
        // 替换为中等尺寸图片
        NSString *url = self.mImgArr[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        photo.srcImageView = self.mImgView.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];

}
@end
