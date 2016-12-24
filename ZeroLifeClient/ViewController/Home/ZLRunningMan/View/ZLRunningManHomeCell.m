//
//  ZLRunningManHomeCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLRunningManHomeCell.h"
#import "ZLCustomBtnView.h"
#import "CustomDefine.h"

@implementation ZLRunningManHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setMDataSource:(NSArray *)mDataSource{

    for (ZLCustomBtnView *btnView in self.contentView.subviews) {
        [btnView removeFromSuperview];
    }
    
    
    for (int i = 0; i < mDataSource.count; i++) {
        CGRect frame = CGRectMake(i*screen_width/4, 10, screen_width/4, 80);
        
        NSDictionary *dic = mDataSource[i];
        
        NSString *title = [dic objectForKey:@"title"];
        NSString *imageStr = [dic objectForKey:@"img"];
        
        ZLCustomBtnView *btnView = [[ZLCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
        btnView.tag = i;
        [self.contentView addSubview:btnView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
        [btnView addGestureRecognizer:tap];
        
    }
}
- (void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *mTap = (UITapGestureRecognizer *)sender;
    MLLog(@"%ld",[mTap view].tag);
    
    if ([self.delegate respondsToSelector:@selector(ZLRunningManHomeCellBtnClickedWithIndex:)]) {
        [self.delegate ZLRunningManHomeCellBtnClickedWithIndex:[mTap view].tag];
    }
    
}

@end
