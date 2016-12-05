//
//  ZLSkuCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/12/5.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLSkuCell.h"
#import <SKTagView/SKTagView.h>
#import "CustomDefine.h"


@interface ZLSkuCell ()

@property (nonatomic,weak) UIButton *Selectbutton;

@end

@implementation ZLSkuCell
{
    NSInteger mCout;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setMName:(NSString *)mName{

    self.mSpeName.text = mName;
}
- (void)setMDataSource:(NSArray *)mDataSource{

    for (UIButton *vvv in self.mSpeSubView.subviews) {
        [vvv removeFromSuperview];
    }
    
    if (mDataSource.count<= 0) {
        return;
    }
    
    
    
    
    mCout = mDataSource.count;
    
    CGFloat oneLineBtnWidtnLimit = 300;//每行btn占的最长长度，超出则换行
    CGFloat btnGap = 10;//btn的x间距
    NSInteger BtnlineNum = 0;
    CGFloat BtnHeight = 30;
    CGFloat minBtnLength =  50;//每个btn的最小长度
    CGFloat maxBtnLength = oneLineBtnWidtnLimit - btnGap*2;//每个btn的最大长度
    CGFloat Btnx = 0;//每个btn的起始位置
    Btnx += btnGap;
    
    NSMutableArray *tempArr = [NSMutableArray array];
    
    
    CGFloat mH = 0;
    
    CGFloat mYY = 0;
    
    CGFloat mXX = 10;
    
    for (int i =0; i<mDataSource.count; i++) {
        
        
        ZLSpeObj *mSpe = mDataSource[i];
        
        NSString *str = mSpe.mSpeGoodsName;
        
        CGFloat btnWidth = [self WidthWithString:str fontSize:14 height:BtnHeight];
        btnWidth += 20;//让文字两端留出间距
        
        if(btnWidth<minBtnLength)
            btnWidth = minBtnLength;
        
        if(btnWidth>maxBtnLength)
            btnWidth = maxBtnLength;
        
        
        if(Btnx + btnWidth > oneLineBtnWidtnLimit)
        {
            BtnlineNum ++;//长度超出换到下一行
            Btnx = btnGap;
        }
        
        
        UIButton *btn = [[UIButton alloc] init];
        
        
        btn.frame = CGRectMake(mXX, mYY+10,
                               btnWidth,BtnHeight );
        [btn setTitle:str forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        btn.layer.cornerRadius = 5;
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [[UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1.00] CGColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(standardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        btn.tag = i;
        
        
        [tempArr addObject:btn];
        
        Btnx = btn.frame.origin.x + btn.frame.size.width + btnGap;
        [self.mSpeSubView addSubview:btn];
        
        
        mXX+=btnWidth+5;
        
        if (mXX>=DEVICE_Width-btnWidth*2) {
            mXX = 10;
            mYY+=35;
        }
        mH+=mYY;

    }
    self.mCellH = 46+mH+50;
    
    
}
//规格键点击
-(void)standardBtnClick:(UIButton *)sender
{

    
    if (!sender.selected) {
        self.Selectbutton.selected = !self.Selectbutton.selected;
        self.Selectbutton.backgroundColor = [UIColor whiteColor];
        [self.Selectbutton setTitleColor:[UIColor grayColor] forState:0];

        sender.selected = !sender.selected;
        
        sender.backgroundColor = M_CO;
        [sender setTitleColor:[UIColor whiteColor] forState:0];

        self.Selectbutton = sender;
     
        
        MLLog(@"TTTTTTTT：%ld",(long)sender.tag);
        
        
        if ([self.delegate respondsToSelector:@selector(ZLSkuCellWithSelectedIndexPath:andIndex:)]) {
            [self.delegate ZLSkuCellWithSelectedIndexPath:self.mIndexPath andIndex:sender.tag];
            
        }
        
        
    }

}

#pragma mark - self tools
//根据字符串计算宽度
-(CGFloat)WidthWithString:(NSString*)string fontSize:(CGFloat)fontSize height:(CGFloat)height
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width;
}

@end
