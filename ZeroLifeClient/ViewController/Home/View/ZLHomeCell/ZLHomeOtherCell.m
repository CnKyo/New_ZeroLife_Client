//
//  ZLHomeOtherCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/2.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLHomeOtherCell.h"
#import "ZLHomeCampFuncView.h"

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

    for (UIView *vvv in self.contentView.subviews) {
        [vvv removeFromSuperview];
    }

    ZLHomeCellType mType = mDataSource.count;
    switch (mType) {
        case ZLHomeFuncOne:
        {
            UIImageView *mBgk = [UIImageView new];
            mBgk.backgroundColor = [UIColor redColor];
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
                ZLHomeCampFuncView *mSubView = [ZLHomeCampFuncView initBigView];
                mSubView.frame = CGRectMake(x, 0, w, 200);
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
                if (i==0) {
                    ZLHomeCampFuncView *mSubView = [ZLHomeCampFuncView initBigView];
                    mSubView.frame = CGRectMake(x, 0, w, 200);
                    mSubView.mIndex = i;
                    mSubView.delegate = self;
                    [self.contentView addSubview:mSubView];
                    
                }else{
                
                    ZLHomeCampFuncView *mSubView = [ZLHomeCampFuncView initImgRightView];
                    mSubView.frame = CGRectMake(w, y, w, h);
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
                
                ZLHomeCampFuncView *mSubView = [ZLHomeCampFuncView initImgRightView];
                mSubView.frame = CGRectMake(x, y, w, h);
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
                if (i==0) {
                    ZLHomeCampFuncView *mSubView = [ZLHomeCampFuncView initBigView];
                    mSubView.frame = CGRectMake(x, 0, w, 200);
                    mSubView.mIndex = i;
                    mSubView.delegate = self;
                    [self.contentView addSubview:mSubView];
                    
                }else{
                    w = DEVICE_Width/4;
                    ZLHomeCampFuncView *mSubView = [ZLHomeCampFuncView initSmallView];
                    mSubView.frame = CGRectMake(x, y, w, h);
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
