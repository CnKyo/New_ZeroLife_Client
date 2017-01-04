//
//  ZLGoodsDetailCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLGoodsDetailCell.h"
#import "RKImageBrowser.h"
#import "CustomDefine.h"
#import "ZLActivityView.h"

@interface ZLGoodsDetailCell ()

{
    RKImageBrowser  *mScrollerView;
    ZLActivityView *mActivityView;
}

@end

@implementation ZLGoodsDetailCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews{

    [super layoutSubviews];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMBanerDataSource:(NSMutableArray *)mBanerDataSource{
    if (mBanerDataSource.count<=0) {
        return;
    }
    
    NSMutableArray *mImgArr = [NSMutableArray new];
    
    for (ZLGoodsDetailImg *mImg in mBanerDataSource) {
    
        [mImgArr addObject:mImg.img_url];
        
    }
    
    mScrollerView = [[RKImageBrowser alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, self.mBanerView.mheight)];
    mScrollerView.backgroundColor = [UIColor whiteColor];
    [mScrollerView setBrowserWithImagesArray:mImgArr];
//    __weak __typeof(self)weakSelf = self;
    
    mScrollerView.didselectRowBlock = ^(NSInteger clickRow) {
        MLLog(@"333点击了图片%ld", clickRow);
           
    };
    [self.mBanerView addSubview:mScrollerView];

    
}

- (void)setMActivityDataSource:(NSArray *)mActivityDataSource{

    
    for (UIView *vvv in self.mActivityView.subviews) {
        [vvv removeFromSuperview];
    }
    
    CGFloat mYY = 0.0;
    
    if (mActivityDataSource.count <= 0) {
        return;
    }
    
    for (int i = 0; i<mActivityDataSource.count; i++) {
        mActivityView = [ZLActivityView initWithActivityView];
        mActivityView.frame = CGRectMake(0, mYY, self.mActivityView.mwidth, self.mActivityView.mheight);
        
        [self.mActivityView addSubview:mActivityView];
        
        mYY += 30;
  
    }
    
    CGRect mRR = self.mActivityView.frame;
    mRR.size.height = mYY;
    self.mActivityView.frame = mRR;
    
    self.mCellH = 400+mYY;
    
}

- (IBAction)mSpecAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLGoodsDetailSpecAction)]) {
    [self.delegate ZLGoodsDetailSpecAction];
    }
    
    
}

- (void)setMGoodsDetail:(ZLGoodsDetail *)mGoodsDetail{

    
}


@end
