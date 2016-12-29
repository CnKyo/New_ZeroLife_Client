//
//  ZLCustomSegView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/12/26.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLCustomSegView.h"
#import "ZLCustomSegSubView.h"
#import "CustomDefine.h"
@interface ZLCustomSegView()

@property (strong,nonatomic) NSMutableArray *mTemArr;

@end

@implementation ZLCustomSegView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLCustomSegView *)initViewType:(ZLCustomSegViewType)mType andTextArr:(NSArray *)mTextArr andImgArr:(NSArray *)mImgArr{

    ZLCustomSegView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLCustomSegView" owner:self options:nil] objectAtIndex:0];
    view.mTemArr = [NSMutableArray new];
    [view.mTemArr removeAllObjects];
    UIScrollView *mScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_Width, 80)];
    mScrollerView.showsVerticalScrollIndicator = FALSE;
    mScrollerView.showsHorizontalScrollIndicator = FALSE;
    [view addSubview:mScrollerView];
    
    float x = 0;
    float   w = DEVICE_Width/4;

    if (mType == ZLCustomSegViewTypeOnlyText) {
        
        for (int i = 0; i<mTextArr.count; i++) {
            
            ZLCustomSegSubView *mSubView = [ZLCustomSegSubView initView];
            mSubView.frame = CGRectMake(x, 5, w, 80);
            mSubView.mSubImg.hidden = YES;
            mSubView.mTitle.text = mTextArr[i];
            mSubView.tag = i;
            mSubView.mBtn.tag = i;
            [mSubView.mBtn addTarget:view action:@selector(mBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [mScrollerView addSubview:mSubView];
            [view.mTemArr addObject:mSubView];
            if (i == 0) {
                mSubView.mLine.backgroundColor = M_CO;
            }else{
                mSubView.mLine.backgroundColor = [UIColor clearColor];
            }
            x +=w;
            
        }
        
        mScrollerView.contentSize = CGSizeMake(x, 80);
        
    }else if (mType == ZLCustomSegViewTypeOnlyImage){
    
        for (int i = 0; i<mImgArr.count; i++) {
            
            ZLCustomSegSubView *mSubView = [ZLCustomSegSubView initView];
            mSubView.frame = CGRectMake(x, 5, w, 80);
            mSubView.mTitle.hidden = YES;
            mSubView.mImg.hidden = YES;

            [mSubView.mSubImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mImgArr[i]]] placeholderImage:ZLDefaultClassImg];
            mSubView.tag = i;
            mSubView.mBtn.tag = i;
            [mSubView.mBtn addTarget:view action:@selector(mBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [mScrollerView addSubview:mSubView];
            [view.mTemArr addObject:mSubView];
            if (i == 0) {
                mSubView.mLine.backgroundColor = M_CO;
            }else{
                mSubView.mLine.backgroundColor = [UIColor clearColor];
            }
            x +=w;
            
        }
        
        mScrollerView.contentSize = CGSizeMake(x, 80);
        
    }else{
        for (int i = 0; i<mTextArr.count; i++) {
            
            ZLCustomSegSubView *mSubView = [ZLCustomSegSubView initView];
            mSubView.frame = CGRectMake(x, 5, w, 80);
            mSubView.mSubImg.hidden = YES;

            mSubView.mTitle.text = mTextArr[i];
            [mSubView.mImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mImgArr[i]]] placeholderImage:ZLDefaultClassImg];
            mSubView.tag = i;
            mSubView.mBtn.tag = i;
            [mSubView.mBtn addTarget:view action:@selector(mBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [mScrollerView addSubview:mSubView];
            [view.mTemArr addObject:mSubView];
            if (i == 0) {
                mSubView.mLine.backgroundColor = M_CO;
            }else{
                mSubView.mLine.backgroundColor = [UIColor clearColor];
            }
            x +=w;
            
        }
        
        mScrollerView.contentSize = CGSizeMake(x, 80);
    }
    

    
    return view;
}

- (void)mBtnAction:(UIButton *)sender{
    
    MLLog(@"----%@",self.mTemArr);
    
    for (ZLCustomSegSubView *mView in self.mTemArr) {
        if (sender.tag == mView.tag) {
            
            mView.mLine.backgroundColor = M_CO;
            
        }else{
            mView.mLine.backgroundColor = [UIColor clearColor];

        }
    }
    
    sender.selected = !sender.selected;
    
    if ([_delegate respondsToSelector:@selector(ZLCustomSegViewDidBtnSelectedWithIndex:)]) {
        [self.delegate ZLCustomSegViewDidBtnSelectedWithIndex:sender.tag];
    }
    

    
}

@end
