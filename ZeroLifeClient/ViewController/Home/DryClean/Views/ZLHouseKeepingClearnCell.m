//
//  ZLHouseKeepingClearnCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/25.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLHouseKeepingClearnCell.h"
#import "NoticeTextView.h"
#import "ZLCustomBtnView.h"
#import "CustomDefine.h"

@interface ZLHouseKeepingClearnCell ()

<UIScrollViewDelegate>
{
    //第一页
    UIView *mBgkView1;
    //第二页
    UIView *mBgkView2;
    
   
    
    
}


@end

@implementation ZLHouseKeepingClearnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDataSource:(NSMutableArray *)mDataSource{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
        
        int mPage;
        if (mDataSource.count>8) {
            mPage = 2;
        }else{
            mPage = 1;
        }
        
        //
        mBgkView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 160)];
        mBgkView2 = [[UIView alloc] initWithFrame:CGRectMake(screen_width, 0, screen_width, 160)];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 178)];
        scrollView.backgroundColor = [UIColor whiteColor];
        
        scrollView.contentSize = CGSizeMake(mPage*screen_width-16, 178);
        
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        
        
        CGRect mBgkView1Rect = mBgkView1.frame;
        CGRect mBgkView2Rect = mBgkView2.frame;
        CGRect mSRR = scrollView.frame;
        
        //创建8个
        for (int i = 0; i < mDataSource.count; i++) {
            if (i < 4) {
                CGRect frame = CGRectMake(i*screen_width/4, 0, screen_width/4, 80);
                NSString *title = [mDataSource[i] objectForKey:@"title"];
                NSString *imageStr = [mDataSource[i] objectForKey:@"image"];
                ZLCustomBtnView *btnView = [[ZLCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
                btnView.tag = i;
                [mBgkView1 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
                
                mBgkView1Rect.size.height = 160/2;
                mSRR.size.height = 178/2;
            }else if(i<8){
                CGRect frame = CGRectMake((i-4)*screen_width/4, 80, screen_width/4, 80);
                NSString *title = [mDataSource[i] objectForKey:@"title"];
                NSString *imageStr = [mDataSource[i] objectForKey:@"image"];
                ZLCustomBtnView *btnView = [[ZLCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
                btnView.tag = i;
                [mBgkView1 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
                mBgkView1Rect.size.height = 160;
                mSRR.size.height = 178;
            }else if(i < 12){
                CGRect frame = CGRectMake((i-8)*screen_width/4, 0, screen_width/4, 80);
                NSString *title = [mDataSource[i] objectForKey:@"title"];
                NSString *imageStr = [mDataSource[i] objectForKey:@"image"];
                ZLCustomBtnView *btnView = [[ZLCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
                btnView.tag = i;
                [mBgkView2 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
                mBgkView2Rect.size.height = 160;
                mSRR.size.height = 178;
                
            }else{
                CGRect frame = CGRectMake((i-12)*screen_width/4, 80, screen_width/4, 80);
                NSString *title = [mDataSource[i] objectForKey:@"title"];
                NSString *imageStr = [mDataSource[i] objectForKey:@"image"];
                ZLCustomBtnView *btnView = [[ZLCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
                btnView.tag = i;
                [mBgkView2 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
                mBgkView2Rect.size.height = 160;
                mSRR.size.height = 178;
                
            }
        }
        
        mBgkView1.frame =mBgkView1Rect;
        mBgkView2.frame =mBgkView2Rect;
        scrollView.frame = mSRR;
        [scrollView addSubview:mBgkView1];
        [scrollView addSubview:mBgkView2];
        [self addSubview:scrollView];
        
        
        NoticeTextView *noticeView = [[NoticeTextView alloc] init];
        noticeView.frame = CGRectMake(0, scrollView.mbottom, DEVICE_Width, 40);
        [self addSubview:noticeView];

    }
    return self;

}

- (void)setMClassArr:(NSArray *)mClassArr{

    
//    for (UIView *vvv in self.contentView.subviews) {
//        [vvv removeFromSuperview];
//    }

   
    int mPage;
    if (mClassArr.count>8) {
        mPage = 2;
    }else{
        mPage = 1;
    }
    
    //
    mBgkView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 160)];
    mBgkView2 = [[UIView alloc] initWithFrame:CGRectMake(screen_width, 0, screen_width, 160)];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 178)];
    scrollView.backgroundColor = [UIColor whiteColor];

    scrollView.contentSize = CGSizeMake(mPage*screen_width-16, 178);
    
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    
    CGRect mBgkView1Rect = mBgkView1.frame;
    CGRect mBgkView2Rect = mBgkView2.frame;
    CGRect mSRR = scrollView.frame;
    
    //创建8个
    for (int i = 0; i < mClassArr.count; i++) {
        if (i < 4) {
            CGRect frame = CGRectMake(i*screen_width/4, 0, screen_width/4, 80);
            NSString *title = [mClassArr[i] objectForKey:@"title"];
            NSString *imageStr = [mClassArr[i] objectForKey:@"image"];
            ZLCustomBtnView *btnView = [[ZLCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
            btnView.tag = i;
            [mBgkView1 addSubview:btnView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
            [btnView addGestureRecognizer:tap];
            
            mBgkView1Rect.size.height = 160/2;
            mSRR.size.height = 178/2;
        }else if(i<8){
            CGRect frame = CGRectMake((i-4)*screen_width/4, 80, screen_width/4, 80);
            NSString *title = [mClassArr[i] objectForKey:@"title"];
            NSString *imageStr = [mClassArr[i] objectForKey:@"image"];
            ZLCustomBtnView *btnView = [[ZLCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
            btnView.tag = i;
            [mBgkView1 addSubview:btnView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
            [btnView addGestureRecognizer:tap];
            mBgkView1Rect.size.height = 160;
            mSRR.size.height = 178;
        }else if(i < 12){
            CGRect frame = CGRectMake((i-8)*screen_width/4, 0, screen_width/4, 80);
            NSString *title = [mClassArr[i] objectForKey:@"title"];
            NSString *imageStr = [mClassArr[i] objectForKey:@"image"];
            ZLCustomBtnView *btnView = [[ZLCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
            btnView.tag = i;
            [mBgkView2 addSubview:btnView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
            [btnView addGestureRecognizer:tap];
            mBgkView2Rect.size.height = 160;
            mSRR.size.height = 178;
            
        }else{
            CGRect frame = CGRectMake((i-12)*screen_width/4, 80, screen_width/4, 80);
            NSString *title = [mClassArr[i] objectForKey:@"title"];
            NSString *imageStr = [mClassArr[i] objectForKey:@"image"];
            ZLCustomBtnView *btnView = [[ZLCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
            btnView.tag = i;
            [mBgkView2 addSubview:btnView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
            [btnView addGestureRecognizer:tap];
            mBgkView2Rect.size.height = 160;
            mSRR.size.height = 178;
            
        }
    }
    
    mBgkView1.frame =mBgkView1Rect;
    mBgkView2.frame =mBgkView2Rect;
    scrollView.frame = mSRR;
    [scrollView addSubview:mBgkView1];
    [scrollView addSubview:mBgkView2];
    [self.contentView addSubview:scrollView];
    
   
    NoticeTextView *noticeView = [[NoticeTextView alloc] init];
    noticeView.frame = CGRectMake(0, scrollView.mbottom, DEVICE_Width, 40);
    [self.contentView addSubview:noticeView];


    
}
- (void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *mTap = (UITapGestureRecognizer *)sender;
    MLLog(@"%ld",[mTap view].tag);
    
    if ([self.delegate respondsToSelector:@selector(ZLHouseKeepingClearnCellWithCatigryDidSelectedIndex:)]) {
        [self.delegate ZLHouseKeepingClearnCellWithCatigryDidSelectedIndex:[mTap view].tag];
    }
    
}

@end
